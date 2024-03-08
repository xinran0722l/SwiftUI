//
//  ListView.swift
//  SwiftUIExercise
//
//  Created by Xinran Yu on 3/7/24.
//

import SwiftUI

struct ListView: View{
    var title: String = "Default Title"
    var body: some View {
        VStack{
            Spacer()
            
            HStack {
                Button{
                    print("user profile")
                } label: {
                    Circle()
                        .fill(.cyan)
                        .frame(width:40,height:40)
                }
                
                Spacer()
                Text(title)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .bold()
                Spacer()
                Image(systemName: "bell.fill")
            }
            .padding(.all)
            .background(.purple)
            .border(.mint,width: 2)
            
            // table 1
            Section(title: "Table 1", names: Array(0...3).map{String($0)})
                .padding(.all)
            // table 2
            Section(title:"Table 2", names: Array(repeating: "A", count: 8))
                .padding(.all)
            
        }
        .background(.orange)
        
    }
    
}


struct ListView_Previews: PreviewProvider{
    static var previews: some View{
        ListView()
    }
    
}

// MARK: - Table 1: Section
struct Section: View {
    var title: String
    var names: [String]
    
    var body: some View {
        VStack{
            HStack{
                Text(title)
                Spacer()
                Button("+"){
                    print("add section item")
                }.padding(.all)
            }
            List(names, id:\.self){ name in
                SectionItem(name:name)
            }
        }.background(.gray)
    }
}



// MARK: - SectionItem
struct SectionItem: View{
    var name: String
    var body: some View{
        HStack{
            Image(systemName: "triangle")
            Text(name)
        }
    }
}





