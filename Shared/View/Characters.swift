//
//  Characters.swift
//  SwiftUICombine
//
//  Created by Yakup Yıldırım on 29.11.2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct Characters: View {
    @ObservedObject var characterData = CharacterViewModel()
    var body: some View {
        NavigationView{
        
        ScrollView(.vertical, showsIndicators: false, content: {
            VStack(spacing:15){
                HStack(spacing:10){
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("Search Character", text: $characterData.searchQuery)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
                .padding(.vertical,10)
                .padding(.horizontal)
                .background(Color.white)
                .shadow(color: Color.black.opacity(0.06), radius: 5, x: 5, y: 5)
                .shadow(color: Color.black.opacity(0.06), radius: -5, x: -5, y: 5)
            }
            .padding()
            
            if let characters = characterData.characters{
                if characters.isEmpty{
                    Text("No Data Found.")
                        .padding(.top, 20)
                }else{
                    ForEach(characters){ data in
                        CharacterRowView(character: data)
                        
                    }
                }
            }else{
                if characterData.characters != nil{
                    ProgressView()
                        .padding(.top, 20)
                }
            }
            
        })
         .navigationTitle("Marvel")
        
        }
    }
}

struct Characters_Previews: PreviewProvider {
    static var previews: some View {
        Characters()
    }
}


struct CharacterRowView:View{
    var character:Character
    
    var body: some View{
        HStack(alignment: .top, spacing: 15){
            WebImage(url: extractImage(data: character.thumbnail))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150)
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 8, content: {
                Text(character.name)
                    .font(.title3)
                    .fontWeight(.bold)
                
                Text(character.description!)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .lineLimit(4)
                    .multilineTextAlignment(.leading)
                
                HStack(spacing: 10){
                    ForEach(character.urls, id: \.self){ data in
                        NavigationLink(destination: WebView(url: extractUrl(data: data))
                                        .navigationTitle(extractUrlType(data: data)),
                                       label: {
                                Text(extractUrlType(data:data))
                        })
                    }
                }
                
            })
            Spacer(minLength: 0)
        }
        .padding(.horizontal)
    }
}


func extractImage(data: [String: String])->URL{
    let path = data["path"]?.replacingOccurrences(of: "http", with: "https") ?? ""
    let ext = data["extension"] ?? ""
    
    return URL(string: "\(path).\(ext)")!
}

func extractUrl(data: [String: String])->URL{
    let url = data["url"] ?? ""
    
    return URL(string: url)!
}

func extractUrlType(data: [String: String])->String{
    let type = data["type"] ?? ""
    
    return type.capitalized
}