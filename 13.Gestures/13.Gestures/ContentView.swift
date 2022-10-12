//
//  ContentView.swift
//  13.Gestures
//
//  Created by junlong lin on 2022/9/1.
//

import SwiftUI

struct ContentView: View {
    // 定义状态
    @State private var circleColorChanged = false
    @State private var heartColorChanged = false
    @State private var heartSizeChanged = false
    @GestureState private var longPressTap = false
    @GestureState private var dragOffset = CGSize.zero
    @State private var position = CGSize.zero
    var body: some View {
        // 绘制
        ZStack {
            Circle()
                .frame(width: 200, height: 200)
                .foregroundColor(circleColorChanged ? Color(.systemGray5) : .red)
            Image(systemName: "heart.fill")
                .foregroundColor(heartColorChanged ? .red : .white)
                .font(.system(size: 80))
                .scaleEffect(heartSizeChanged ? 1.0 : 0.5)
        }
        // 移动位置
        .offset(x: position.width + dragOffset.width, y: position.height + dragOffset.height)
        // 手势modifier
        .gesture(
            // 长按手势
            LongPressGesture(minimumDuration: 1.0)
                // 长按手势更新方法
                .updating($longPressTap, body: {
                    currentState, state, _ in
                    state = currentState
//                    self.circleColorChanged.toggle()
//                    self.heartColorChanged.toggle()
//                    self.heartSizeChanged.toggle()
                })
                // 拖拽手势
                .sequenced(before: DragGesture())
                // 拖拽手势更新方法
                .updating($dragOffset, body: {
                    currentPosition, state, _ in
                    // 顺序执行
                    switch currentPosition {
                    case .first(true):
                        print("正在点击")
                    case .second(true, let drag):
                        state = drag?.translation ?? .zero
                    default:
                        break
                    }
                })
                // 拖拽结束后的位置
                .onEnded({ currentPosition in
                    guard case .second(true, let drag?) = currentPosition else {
                        return
                    }
                    self.position.height += drag.translation.height
                    self.position.width += drag.translation.width
                    self.circleColorChanged.toggle()
                    self.heartColorChanged.toggle()
                    self.heartSizeChanged.toggle()
                })
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
