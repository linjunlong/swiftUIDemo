//
//  ContentView.swift
//  SwiftUIAnimation
//
//  Created by junlong lin on 2022/9/2.
//

import SwiftUI

struct ContentView: View {
    // MARK: -  PROPERTY
    @State private var showRectangle: Bool = false
    // MARK: -  BODY
    var body: some View {
        VStack {
            Spacer()
            
            if showRectangle {
                RoundedRectangle(cornerRadius: 25)
                    .frame(width: 250, height: 350)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .transition(.rotateOn)
            }
            
            Spacer()
            Button("Click Me!") {
                withAnimation(.easeInOut) {
                    showRectangle.toggle()
                }
            }
            .padding(.horizontal, 40)
        } //: VSTACK
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// MARK: -  VIEWMODIFIER
struct RotateViewModifier: ViewModifier {
    let rotation: Double
    func body(content: Content) -> some View {
        content
            .rotationEffect(Angle(degrees: rotation))
            .offset(
                x: rotation != 0 ? UIScreen.main.bounds.width : 0,
                y: rotation != 0 ? UIScreen.main.bounds.height : 0)
    }
}

// MARK: -  EXTENSTION
//自定义动画属性
extension AnyTransition {
    static var rotaing: AnyTransition {
        modifier(
            active: RotateViewModifier(rotation: 180),
            identity: RotateViewModifier(rotation: 0))
    }
    
    static func rotaing(rotation: Double) -> AnyTransition {
        modifier(
            active: RotateViewModifier(rotation: rotation),
            identity: RotateViewModifier(rotation: 0))
    }
    
    static var rotateOn: AnyTransition {
        asymmetric(
            insertion: .rotaing,
            removal: .move(edge: .leading))
    }
}
