//
//  ContentView.swift
//  BusinessWallet
//
//  Created by elice86 on 9/28/24.
//

import SwiftUI

struct ContentView: View {
    var list = ["YoonHanmin","seunggyun-jeong","DaonYoon"]
    var repo = ["ShoppingMall","none" ,"daon_talk" ]
    var body: some View {
     
            
            
            NavigationStack{
                NavigationLink("\(list[0])"){
                    NameCardView(name: list[0],repo: repo[0])
                }
                NavigationLink("\(list[1])"){
                    NameCardView(name: list[1],repo: repo[1])
                }
                NavigationLink("\(list[2])"){
                    NameCardView(name: list[2],repo: repo[2])
                }
            
        }
    }
}

#Preview {
    ContentView()
}
