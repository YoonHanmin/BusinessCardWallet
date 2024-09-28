//
//  NameCardView1.swift
//  BusinessWallet
//
//  Created by elice86 on 9/28/24.
//

import SwiftUI

struct NameCardView: View {
    
    @State var user: GitHubUser?
    let name : String
    let repo : String
    var body: some View {
        VStack{
            
            // 프로필 이미지
            
            AsyncImage(url: URL(string: user?.avatarUrl ?? "")) {
                image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
            
        } placeholder: {
            
            
            Circle()
                .frame(width:150)
                .foregroundStyle(.secondary)
                .padding(.bottom,30)
        }
        
        .frame(width: 150)
        
            // 이름
            Text(user?.name ?? "이름 없음")
                .font(.title)
                .bold()
            
            //회사
            Text(user?.company ?? "회사 없음")
            
           
            NavigationLink {
              
                RepoView(name: self.name,repo: self.repo)
                
              
            } label: {
                Text("View More")
                    .padding(.horizontal,70)
                    .padding(.vertical,10)
                    .background{
                        Capsule()
                            .foregroundStyle(.cyan)
                    }
                    .foregroundStyle(.white)
                
            }
            .padding(.bottom,50)
            
            HStack{
                Text(user?.htmlUrl ?? "깃허브 주소 없음")
                
                Spacer()
            }
            Divider()
            
            HStack{
                Text(user?.email ?? "이메일 정보 없음.")
                
                Spacer()
            }
            
            
            
        }
        
        .padding(.horizontal,30)
        .task{ // 정의된 비동기 함수 자동 실행
            self.user = try? await getUserData(name : name)
            print(user)
            
        }
    }
    
    func getUserData(name: String) async throws -> GitHubUser{
        
    
       guard let url = URL(string :
                            "https://api.github.com/users/\(name)") else{ // url 이 string 일경우,
           throw URLError(.badURL)
       }
        
       let(data,response) = try await URLSession.shared.data(from: url)
        
        guard
            let response = response as? HTTPURLResponse,
                response.statusCode == 200
        else{ throw URLError(.badServerResponse)}
    
    
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    
    return try decoder.decode(GitHubUser.self, from: data)
    
}

}
#Preview {
    NavigationStack {
        NameCardView(name : "YoonHanmin",repo : "ShoppingMall")
    }
    
}


struct GitHubUser : Codable{
    let avatarUrl : String? // nullable한 데이터의 경우 ?처리로 옵셔널 처리해준다.
    let name : String?
    let company : String?
    let email: String?
    let htmlUrl: String
}
