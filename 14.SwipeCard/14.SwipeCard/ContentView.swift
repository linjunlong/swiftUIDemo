//
//  ContentView.swift
//  14.SwipeCard
//
//  Created by junlong lin on 2022/9/1.
//

import SwiftUI
// 创建Album定义变量
struct Album: Identifiable {
    var id = UUID()
    var name: String
    var image: String
}
// 创建演示数据
var album = [
    Album(name: "图片01", image: "image01"),
    Album(name: "图片02", image: "image02"),
    Album(name: "图片03", image: "image03"),
    Album(name: "图片04", image: "image04"),
    Album(name: "图片05", image: "image05"),
    Album(name: "图片06", image: "image06"),
    Album(name: "图片07", image: "image07"),
    Album(name: "图片08", image: "image08"),
    Album(name: "图片09", image: "image09"),
]
// 创建2个卡片视图
var albums: [Album] = {
    var views = [Album]()
    for index in 0 ..< 2 {
        views.append(Album(name: album[index].name, image: album[index].image))
    }
    return views
}()
//主视图
struct ContentView: View {
    @GestureState private var dragState = DragState.inactive
    @State private var offset: CGFloat = .zero
    private let dragPosition: CGFloat = 80.0
    //图片数组
    @State var albums: [Album] = {
        var views = [Album]()
        
        for index in 0 ..< 2 {
            views.append(Album(name: album[index].name, image: album[index].image))
        }
        return views
    }()
    //最后一张图片索引值
    @State private var lastIndex = 1
    //转场类型动画
    @State private var removalTransition = AnyTransition.trailingBottom
    
    var body: some View {
        VStack {
            TopBarMenu()
            // 卡片视图
            ZStack {
                ForEach(albums) { album in
                    CardView(name: album.name, image: album.image)
                        .zIndex(self.isTopCard(cardView: album) ? 1 : 0)
                        //判断喜欢或者不喜欢
                        .overlay(
                            ZStack {
                                Image(systemName: "hand.thumbsdown.fill")
                                    .foregroundColor(.white)
                                    .font(.system(size: 100))
                                    .opacity(self.dragState.translation.width < -self.dragPosition && self .isTopCard(cardView: album) ? 1.0 : 0)
                                Image(systemName: "hand.thumbsup.fill")
                                    .foregroundColor(.white)
                                    .font(.system(size: 100))
                                    .opacity(self.dragState.translation.width > self.dragPosition && self .isTopCard(cardView: album) ? 1.0 : 0.0)
                            }
                        )
                        //偏移
                        .offset(x: self.isTopCard(cardView: album) ? self.dragState.translation.width : 0, y: self.isTopCard(cardView: album) ? self.dragState.translation.height : 0)
                        //缩放
                        .scaleEffect(self.dragState.isDragging && self.isTopCard(cardView: album) ? 0.95 : 1.0)
                        //旋转
                        .rotationEffect(Angle(degrees: self.isTopCard(cardView: album) ? Double( self.dragState.translation.width / 10) : 0))
                        //动画
                        .animation(.interpolatingSpring(stiffness: 180, damping: 100), value: offset)
                        //转场动画
                        .transition(self.removalTransition)
                        //手势
                        .gesture(LongPressGesture(minimumDuration: 0.01)
                            .sequenced(before: DragGesture())
                            .updating(self.$dragState, body: { value, state, _ in
                                switch value {
                                
                                case .first(true):
                                    state = .pressing
                                case .second(true, let drag):
                                    state = .dragging(translation: drag?.translation ?? .zero)
                                default:
                                    break
                                }
                            })
                                 //拖动时添加转场效果
                                .onChanged({ (value) in
                                    guard case .second(true, let drag?) = value else {
                                        return
                                    }
                                    
                                    if drag.translation.width < -self.dragPosition {
                                        self.removalTransition = .leadingBottom
                                    }
                                    
                                    if drag.translation.width > self.dragPosition {
                                        self.removalTransition = .trailingBottom
                                    }
                                })
                                 //拖拽移除卡片
                                .onEnded({ (value) in
                                    guard case .second(true, let drag?) = value else {
                                        return
                                    }
                                    if drag.translation.width < -self.dragPosition || drag.translation.width > self.dragPosition {
                                        self.moveCard()
                                    }
                                })
                    )
                }
            }
            Spacer(minLength: 20)
            BottomBarMenu()
                .opacity(dragState.isDragging ? 0.0 : 1.0)
                .animation(.default, value: offset)
        }
    }
    // 获得图片zIndex值
    func isTopCard(cardView: Album) -> Bool {
        guard let index = albums.firstIndex(where: { $0.id == cardView.id }) else {
            return false
        }
        return index == 0
    }
    //移除卡片显示下一张卡片
    func moveCard() {
        albums.removeFirst()
        self.lastIndex += 1
        let cards = album[lastIndex % album.count]
        let newCardView = Album(name: cards.name, image: cards.image)
        
        albums.append(newCardView)
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
// 顶部导航栏
struct TopBarMenu: View {
    var body: some View {
        HStack {
            Image(systemName: "ellipsis.circle")
                .font(.system(size: 30))
            Spacer()
            Image(systemName: "heart.circle")
                .font(.system(size: 30))
        }.padding()
    }
}
// 卡片视图
struct CardView: View {
    let name: String
    let image: String
    
    var body: some View {
        Image(image)
            .resizable()
            .frame(minWidth: 0, maxWidth: .infinity)
            .cornerRadius(10)
            .padding(.horizontal, 15)
            
            .overlay(
                VStack {
                    Text(name)
                        .font(.system(.headline, design: .rounded)).fontWeight(.bold)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 10)
                        .background(Color.white)
                        .cornerRadius(5)
                }
                .padding([.bottom], 20), alignment: .bottom
            )
    }
}
// 底部导航栏
struct BottomBarMenu: View {
    var body: some View {
        HStack {
            Image(systemName: "xmark")
                .font(.system(size: 30))
                .foregroundColor(.black)
            Button(action: {
            }) {
                Text("立即选择")
                    .font(.system(.subheadline, design: .rounded)).bold()
                    .foregroundColor(.white)
                    .padding(.horizontal, 35)
                    .padding(.vertical, 15)
                    .background(Color.black)
                    .cornerRadius(10)
            }.padding(.horizontal, 20)
            Image(systemName: "heart")
                .font(.system(size: 30))
                .foregroundColor(.black)
        }
    }
}
// Gestures手势特性
enum DragState {
    case inactive
    case pressing
    case dragging(translation: CGSize)
    var translation: CGSize {
        switch self {
        case .inactive, .pressing:
            return .zero
        case let .dragging(translation):
            return translation
        }
    }
    var isDragging: Bool {
        switch self {
        case .dragging:
            return true
        case .pressing, .inactive:
            return false
        }
    }
    var isPressing: Bool {
        switch self {
        
        case .pressing, .dragging:
            return true
        case .inactive:
            return false
        }
    }
}
//转场动画效果
extension AnyTransition {
    static var trailingBottom: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .identity, removal: AnyTransition.move(edge: .trailing).combined(with: .move(edge : .bottom))
        )
    }
    static var leadingBottom: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .identity, removal: AnyTransition.move(edge: .leading).combined(with: .move(edge: .bottom))
        )
    }
}
