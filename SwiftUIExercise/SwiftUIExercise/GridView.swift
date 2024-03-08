//
//  GridView.swift
//  SwiftUIExercise
//
//  Created by Xinran Yu on 3/7/24.
//

import SwiftUI

struct Item: Identifiable{
    let id: Int
    let title: String
}
struct GridView: View{
    let items  = (1...10).map{Item(id: $0, title:"Item \($0)")}
    var body: some View{
//        ScrollView(.horizontal){
//            LazyHStack{
//                ForEach(items){ item in
//                    Text(item.title)
//                        .padding(.all)
//                        .border(.indigo, width: 2)
//                    
//                }
//            }
//        }
        ScrollView(.horizontal){
            // rows (1...2).map{_ in GridItem(.flexible()}
            LazyHGrid(rows:(1...2).map{_ in GridItem(.flexible())}, spacing:50){
                ForEach(items){ item in
                    VStack{
                        Text(item.title)
                            .font(.headline)
                        Image(systemName: "house")
                            .resizable()
                            .frame(width:100, height:100)
                            .foregroundColor(.mint)
                    }
                }
            }
        }
    }
}

struct GridView_Previews: PreviewProvider{
    static var previews: some View{
        GridView()
    }
}
