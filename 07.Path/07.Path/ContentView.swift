//
//  ContentView.swift
//  07.Path
//
//  Created by junlong lin on 2022/8/31.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView {
        VStack {
            Path() { path in
                path.move(to: CGPoint(x: 0, y: 40))
                path.addLine(to: CGPoint(x: 15, y: 40))
                path.addQuadCurve(to: CGPoint(x: 285, y: 40), control: CGPoint(x: 150, y: 0))
                path.addLine(to: CGPoint(x: 300, y: 40))
                path.addLine(to: CGPoint(x: 300, y: 100))
                path.addLine(to: CGPoint(x: 0, y: 100))
                }
            .stroke(Color.blue, lineWidth: 10)
            
            //绘制半圆弧

            Path { path in
                path.move(to: CGPoint(x: 200, y: 200))
                path.addArc(center: .init(x: 200, y: 200), radius: 100, startAngle: Angle(degrees: 0.0), endAngle: Angle(degrees: 90), clockwise: true)
            }
            .fill(Color.green)
        }
    }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
