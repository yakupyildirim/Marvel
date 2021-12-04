//
//  Comics.swift
//  SwiftUICombine (iOS)
//
//  Created by Yakup Yıldırım on 1.12.2021.
//

import SwiftUI

struct Comics: View {
    @ObservedObject var comicData = ComiciewModel()
    var body: some View {
        NavigationView{
            ScrollView(.vertical, showsIndicators: false,
               content:{
                if comicData.comics.isEmpty{
                    ProgressView()
                        .padding(.top, 30)
                }
                else{
                    VStack(spacing: 15){
                        ForEach(comicData.comics){ comic in
                            ComicRowView(comic: comic)
                        }
                        
                        if comicData.offset == comicData.comics.count{
                            ProgressView()
                                .padding(.vertical)
                                .onAppear(perform: {
                                    print("fetching new data")
                                    comicData.getComics()
                                })
                        }
                        else{
                            GeometryReader{reader ->Color in
                                let minY = reader.frame(in: .global).minY
                                let height = UIScreen.main.bounds.height/1.3
                                
                                if !comicData.comics.isEmpty && minY < height{
                                    
                                    DispatchQueue.main.async {
                                        comicData.offset =
                                        comicData.comics.count
                                    }
                                    
                                }
                                return Color.clear
                            }
                            .frame(width: 20, height: 20)
                        }
                        
                        
                    }
                    .padding(.bottom)
                }
            })
        }
        .onAppear(perform: {
            if comicData.comics.isEmpty{
                comicData.getComics()
            }
        })
        .navigationTitle("Marvel's Comic")
    }
}

struct Comics_Previews: PreviewProvider {
    static var previews: some View {
        Comics()
    }
}

struct ComicRowView:View{
    var comic: Comic
    
    var body: some View{
        HStack(alignment: .top, spacing: 15){
            AsyncImage(url: extractImage(data: comic.thumbnail), placeholder: { Text("Loading ...") })
                //.resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150)
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 8, content: {
                Text(comic.title)
                    .font(.title3)
                    .fontWeight(.bold)
                
                
                if let description = comic.description{
                    Text(description)
                        .font(.caption)
                        .foregroundColor(.gray)
                        .lineLimit(4)
                        .multilineTextAlignment(.leading)
                   }
                
                HStack(spacing: 10){
                    ForEach(comic.urls, id: \.self){ data in
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
