//
//  RepoView.swift
//  BusinessWallet
//
//  Created by elice86 on 9/28/24.
//

import SwiftUI

struct RepoView: View {
    
    @State var repository : GitHubRepo?
    let name : String
    let repo : String
    var body: some View {
        

        Text(repository?.repoName ?? "repo없음")
        
        
        
            .task{
                self.repository = try? await getUserRepo(name: name,repo : repo)
                print(repository)
            }
    }
    
    func getUserRepo(name: String,repo : String) async throws -> GitHubRepo{
        
        guard let url = URL(string :
                                "https://api.github.com/users/\(name)/\(repo)") else{ // url 이 string 일경우,
            throw URLError(.badURL)
            
        }
        
        let(data,response) = try await URLSession.shared.data(from: url)
        
        guard
            let response = response as? HTTPURLResponse,
            response.statusCode == 200
        else{ throw URLError(.badServerResponse)}
        
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return try decoder.decode(GitHubRepo.self, from: data)
        
        
        
    }
    
}
#Preview {
    RepoView(name: "YoonHanMin",repo : "ShoppingMall")
}


struct GitHubRepo : Codable {
    let repoName : String
    let star : Int
}
