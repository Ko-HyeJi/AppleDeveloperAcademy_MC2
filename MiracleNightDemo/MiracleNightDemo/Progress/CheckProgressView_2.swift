//
//  CheckProgressView.swift
//  CheckProgress
//
//  Created by 장수민 on 2023/05/09.
//

//import SwiftUI
//import Combine
//
//struct CheckProgressView: View {
//    @State var selectedIndex: Int = 0 // 사용자가 터치한 원
//    @State var dayCount: Int = 15  // 그리드 생성 개수
//    @State var scrollToIndex: Int = 0  // 사용자가 터치한 원으로 스크롤
//
//    @State var isActivated: Bool = false  // 사용자가 진행하고 있는 챌린지 날짜 안인지 확인(활성화? 원 색상 변경 위해서)
//    @State var isDone: Bool = false  // 그 날의 챌린지 완료했는지
//    @State var isGoing: Bool = false  // 사용자가 청소 진행중인지(사진을 비포만 찍었는지)
//
//
//    @State var activatedCount: Int = 15// 활성화된 날짜 수
//    @State var clearedCount: Int = 3
//
//    var subheadingText: String = "아직 정리되지 않은 곳이 있어요!"
//
//    @EnvironmentObject var data: DataModel
//
//    @Environment(\.presentationMode) var presentationMode
//
//
//    var body: some View {
//        VStack(spacing: 1) {
//            HStack {
//                Button(action: {
//                    presentationMode.wrappedValue.dismiss()
//                }) {
//                    Image("ExitButton")
//                        .resizable()
//                        .frame(width: 30, height: 30)
//                        .foregroundColor(.white)
//                        .padding(.bottom)
//                        .padding(.leading)
//                }
//
//                Spacer()
//
//                Text("History")
//                    .font(.system(size: 22))
//                    .foregroundColor(.white)
//                    .fontWeight(.bold)
//                    .padding(.bottom)
//
//                Spacer()
//
//                Text("")
//                    .padding(.trailing)
//            }
//
//
//            Text("\(subheadingText)")
//                .font(.system(size: 18))
//                .foregroundColor(.white)
//
//            HorizontalScrollView(dayCount: $dayCount, selectedIndex: $selectedIndex, scrollToIndex: $scrollToIndex, activatedCount: $activatedCount, clearedCount: $clearedCount)
//
//            Divider()
//
//            VerticalScrollView(selectedIndex: $selectedIndex, dayCount: $dayCount, scrollToIndex: $scrollToIndex, activatedCount: $activatedCount, clearedCount: $clearedCount)
//
//        }
//        .background(.black)
//        .padding(.bottom)
//        .edgesIgnoringSafeArea(.bottom)
//
//    }
//}
//
//
//struct HorizontalScrollView: View {
//    @Binding var dayCount: Int
//    @Binding var selectedIndex: Int
//    @Binding var scrollToIndex: Int
//
//    @Binding var activatedCount: Int
//    @Binding var clearedCount: Int
//
//    @EnvironmentObject var data: DataModel
//
//    var body: some View {
//
//        ScrollView(.horizontal, showsIndicators: false) {
//            ScrollViewReader { scrollViewProxy in
//                ZStack(alignment: .topLeading) {
//                    HStack {
//                        ForEach(0 ..< dayCount) { index in
//                            Circle()
//                                .stroke(index < clearedCount ? Color(hex: "5E5CE6"): Color(hex: "979797"), lineWidth: 1)
//                                .frame(width: 36, height: 36)
//                                .padding(.horizontal)
//                                .background(Circle().fill(index < activatedCount ? index < clearedCount ? Color(hex: "5E5CE6") : Color(hex: "879392") : Color(.clear)))
////                                .scaleEffect(selectedIndex == index ? 1.2 : 1)
//                                .id(index)
//                                .onTapGesture {
//                                    withAnimation {
//                                        selectedIndex = index
//                                        scrollToIndex = index
//                                }
//                            }
//                                .overlay{
//                                    (index <= clearedCount ? index == clearedCount ? Image(systemName: "ellipsis") : Image(systemName: "checkmark") : Image(systemName: ""))
//                                    .foregroundColor(.black)
//                                }
//                        }
//                    }
//                    .onAppear {
//                        clearedCount = data.dataArr.count
//                    }
//                    .onReceive(Just(scrollToIndex)) { index in
//                                        withAnimation {
//                                            scrollViewProxy.scrollTo(scrollToIndex, anchor: .center)
//                                        }
//                                    }
//                    .padding()
//                    }
//                }
//            }
//        }
//    }
//
//
//struct VerticalScrollView: View {
//    let columns = [
//        //추가 하면 할수록 화면에 보여지는 개수가 변함
//        GridItem(.flexible(), spacing: nil, alignment: nil),
//        GridItem(.flexible(), spacing: nil, alignment: nil),
//        GridItem(.flexible(), spacing: nil, alignment: nil)
//    ]
//    @Binding var selectedIndex: Int
//    @Binding var dayCount: Int
//    @Binding var scrollToIndex: Int
//
//    @Binding var activatedCount: Int
//    @Binding var clearedCount: Int
//
//    @EnvironmentObject var data: DataModel
//
////    @State var beforeImage: String = "image1"
////    @State var afterImage: String = "image2"
//
//    var body: some View {
//        ScrollView {
//            ScrollViewReader { scrollViewProxy in
//                VStack {
//                    LazyVGrid(columns: columns) {
////                        let dataArr = data.loadData()
//                        ForEach(0..<data.dataArr.count) { index in
//                            let _ = print(index)
//                            ZStack {
//                                RoundedRectangle(cornerRadius: 40)
//                                    .stroke(index < clearedCount ? Color(hex: "5E5CE6"): Color(hex: "979797"), lineWidth: 2)
//                                    .background(RoundedRectangle(cornerRadius: 40).fill(index == clearedCount ? (Color(hex: "979797")) : Color.clear))
//                                    .id(index)
//                                    .padding(.vertical)
//                                    .contentShape(Rectangle())
//                                    .overlay {
//                                        ZStack {
//                                            if index < clearedCount {
//
//                                                ZStack {
//                                                    VStack(spacing: 0) {
//                                                        if index < data.dataArr.count {
//                                                            let specificData = data.dataArr[index] // 특정 인덱스의 요소를 가져옴
//
//                                                            if let beforeImage = data.convertToUIImage(from: specificData.before) {
//                                                                Image(uiImage: beforeImage)
//                                                                    .resizable()
//                                                                    .scaledToFill()
//                                                            }
//                                                        }
//                                                        if index < data.dataArr.count {
//                                                            let specificData = data.dataArr[index] // 특정 인덱스의 요소를 가져옴
//
//                                                            if let afterImage = data.convertToUIImage(from: specificData.after) {
//                                                                Image(uiImage: afterImage)
//                                                                    .resizable()
//                                                                    .scaledToFill()
//                                                            }
//                                                        }
//
//                                                    }
//                                                    .mask(RoundedRectangle(cornerRadius: 40).frame(width: 103, height: 106))
//
//                                                    Color(.black).opacity(0.3).mask(RoundedRectangle(cornerRadius: 40).frame(width: 103, height: 106))
//
//                                                    Text(data.getDate(index: index)).multilineTextAlignment(.center).font(.title2)
//                                                }
//                                            }
//                                        }
//                                    }
//                                    .onTapGesture {
//                                        withAnimation{
//                                            selectedIndex = index
//                                            scrollToIndex = index
//                                        }
//                                        data.showDetailView = true
//                                        data.selectedIndex = index
//                                    }
//                            }
//                            .frame(width: 105, height: 140)
//                            .onTapGesture {
//                                withAnimation {
//                                    selectedIndex = index
//                                    scrollToIndex = index
//                                }
//                            }
//                        }
//                    }
//                }
//                .onAppear {
//                    clearedCount = data.dataArr.count
//                }
//                .onReceive(Just(scrollToIndex)) { index in
//                    withAnimation {
//                        scrollViewProxy.scrollTo(scrollToIndex, anchor: .center)
//                    }
//                }
//            }
//        }
//        .background(Color(hex: "1C1C1E").ignoresSafeArea())
//    }
//}
//
//struct CheckProgressView_Previews: PreviewProvider {
//    static var previews: some View {
//        CheckProgressView()
//    }
//}
