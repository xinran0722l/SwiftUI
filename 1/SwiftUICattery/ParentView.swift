//
//  ParentView.swift
//  SwiftUICattery
//
//  Created by Xinran Yu on 3/6/24.
//

import SwiftUI

// Assuming Cat model exists
struct Cat {
    var name: String
    var imageName: String // Assuming you use local images
}

struct ParentView: View {
    @StateObject var validationManager = ValidationManager()
    @State private var cats = [
        Cat(name: "luna", imageName: "luna"),
        Cat(name: "alex", imageName: "alex"),
        Cat(name: "candy", imageName: "candy"),
        Cat(name: "ginger", imageName: "ginger"),
        Cat(name: "lion", imageName: "lion"),
        Cat(name: "oreo", imageName: "oreo"),
        Cat(name: "nose", imageName: "nose"),
        Cat(name: "tim", imageName: "tim"),
        Cat(name: "apple", imageName: "apple"),
        Cat(name: "robert", imageName: "robert"),
    ]
    
    var body: some View {
        NavigationView {
            List {
                Text("Cats Gallery")
                    .font(.largeTitle)
                
                ForEach($cats.indices, id: \.self) { index in
                    NavigationLink(destination: ChildView(cat: $cats[index], validationManager: validationManager)) {
                        HStack {
                            Image(cats[index].imageName)
                                .resizable()
                                .frame(width: 50, height: 50)
                                .cornerRadius(5)
                            Text(cats[index].name)
                        }
                    }
                }
                
                if validationManager.numFailedAttempts > 0 {
                    Text("Number of attempts failed: \(validationManager.numFailedAttempts)")
                        .foregroundColor(.red)
                }
            }
            .navigationTitle("Cats Gallery")
        }
    }
}

struct ParentView_Previews: PreviewProvider {
    static var previews: some View {
        ParentView()
    }
}


