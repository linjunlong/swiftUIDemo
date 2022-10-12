//
//  ContentView.swift
//  02.Image
//
//  Created by junlong lin on 2022/8/29.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Image("stmarylake")
            .resizable()
            .scaledToFit()
            .aspectRatio(contentMode: .fit)
            .frame(width: 350)
            .clipShape(Circle())
            .opacity(0.8)
            .overlay(
                    Text("编辑")
                        .fontWeight(.bold)
                        .font(.system(size: 24))
                        .foregroundColor(Color.white)
                        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
