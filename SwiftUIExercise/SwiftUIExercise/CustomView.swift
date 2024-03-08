//
//  CustomView.swift
//  SwiftUIExercise
//
//  Created by Xinran Yu on 3/7/24.
//

import SwiftUI

struct CustomContainerView<Content: View>: View {
    // closure
    let content: () -> Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    var body: some View {
        VStack {
            Text("This is a Custom Container View")
            content() // Combines the child views specified in the closure
        }
    }
}

struct CustomContainerView_Previews: PreviewProvider {
    static var previews: some View {
        CustomContainerView {
            Group {
                Text("a")
                Text("b")
            }
            // respectively setting
            .padding(.all)
            .border(.blue, width: 2)
        }
    }
}

