//
//  Home.swift
//  SwiftUICombine
//
//  Created by Yakup Yıldırım on 29.11.2021.
//

import SwiftUI

struct Home: View {

    var body: some View {
        TabView{
               Characters()
                .tabItem{
                    Image(systemName: "person.3.fill")
                    Text("Characters")
                }
                 Comics()
                .tabItem{
                    Image(systemName: "books.vertical.fill")
                    Text("Comics")
                }
            }
        }
    }

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
