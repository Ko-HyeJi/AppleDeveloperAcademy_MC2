import SwiftUI
import Combine

struct CheckProgressView: View {
    @State var selectedIndex: Int = 0 // 사용자가 터치한 원
    @State var dayCount: Int = 15  // 그리드 생성 개수
    @State var scrollToIndex: Int = 0  // 사용자가 터치한 원으로 스크롤
    
    @State var activatedCount: Int = 3// 활성화된 날짜 수
    @State var clearedCount: Int = 0
    
    @State var subheadingText: String = "아직 정리되지 않은 곳이 있어요!"
    
    @EnvironmentObject var data: DataModel
    @EnvironmentObject var viewModel: CameraViewModel
    @State var showDetailView: Bool = false

    
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        VStack(spacing: 1) {
            ZStack {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.backward")
                            .resizable()
//                            .aspectRatio(contentMode: .fit)
                            .frame(width: 10, height: 15)
                            .foregroundColor(.white)
                            .padding(.bottom)
                            .padding(.horizontal)
                }
                    Spacer()
                }
            
                
                
                Text("History")
                    .font(.system(size: 22))
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.bottom)
            }

            
            Text("\(subheadingText)")
                .font(.system(size: 18))
                .foregroundColor(.white)
            
            HorizontalScrollView(dayCount: $dayCount, selectedIndex: $selectedIndex, scrollToIndex: $scrollToIndex, activatedCount: $activatedCount, clearedCount: $clearedCount)
                
            
            Divider()
            
            VerticalScrollView(selectedIndex: $selectedIndex, dayCount: $dayCount, scrollToIndex: $scrollToIndex, activatedCount: $activatedCount, clearedCount: $clearedCount, showDetailView: $showDetailView)
                
        }
        .background(.black)
        .padding(.bottom)
        .edgesIgnoringSafeArea(.bottom)
        .onAppear {
            activatedCount = calcActivatedCount()
            subheadingText = selectSubheadingText()
        }
        .fullScreenCover(isPresented: $showDetailView) { DetailView(showDetailView: $showDetailView) }
       
    }
    func calcActivatedCount() -> Int {
        if data.dataArr.count < 3 {
            return 3
        } else if data.dataArr.count < 8 {
            return 8
        } else {
            return 15
        }
    }
    
    func selectSubheadingText() -> String {
        var countDay =  activatedCount - data.dataArr.count
        
        if countDay >= 0 {
            return "목표 정리 횟수 \(countDay)회 남았어요!"
        } else {
            return "15일간의 방정리를 완료했어요!"
        }
    }
}


struct HorizontalScrollView: View {
    @Binding var dayCount: Int
    @Binding var selectedIndex: Int
    @Binding var scrollToIndex: Int
    
    @Binding var activatedCount: Int
    @Binding var clearedCount: Int
    
    @EnvironmentObject var data: DataModel
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            ScrollViewReader { scrollViewProxy in
                ZStack(alignment: .topLeading) {
                    HStack(spacing: 0) {
                        ForEach(0 ..< dayCount) { index in
                            VStack {
                                Circle()
                                    .stroke(index < activatedCount ? Color(hex: "5E5CE6"): Color(hex: "595959"), lineWidth: 2)
                                    .frame(width: 36, height: 36)
//                                    .padding(.horizontal)
                                    .background(Circle().fill(index < activatedCount ? index < clearedCount ? Color(hex: "5E5CE6") : Color(hex: "595959") : Color(.clear)))
    //                                .scaleEffect(selectedIndex == index ? 1.2 : 1)
                                    .id(index)
                                    .onTapGesture {
                                        withAnimation {
                                            selectedIndex = index
                                            scrollToIndex = index
                                    }
                                }
                                    .overlay{
                                        (index < clearedCount ? Image(systemName: "checkmark") : Image(systemName: ""))
                                        .foregroundColor(.white)
                                }
                                    .padding(.trailing, 16)
                                
                                Text("\(index + 1)")
                                    .font(.system(size: 16))
                                    .foregroundColor(.white)
                                    .padding(.horizontal)
                                    .opacity(index < activatedCount ? 1 : 0)
                                    .padding(.trailing, 16)
                            }
                        }
                    }
                    .onAppear {
                        clearedCount = data.dataArr.count
                    }
                    .onReceive(Just(scrollToIndex)) { index in
                                        withAnimation {
                                            scrollViewProxy.scrollTo(scrollToIndex, anchor: .center)
                                        }
                                    }
                    .padding(.vertical)
                    .padding(.horizontal, 23)
                    }
                }
            }
        }
    }


struct VerticalScrollView: View {
    let columns = [
        //추가 하면 할수록 화면에 보여지는 개수가 변함
        GridItem(.flexible(), spacing: nil, alignment: nil),
        GridItem(.flexible(), spacing: nil, alignment: nil),
        GridItem(.flexible(), spacing: nil, alignment: nil)
    ]
    @Binding var selectedIndex: Int
    @Binding var dayCount: Int
    @Binding var scrollToIndex: Int
    
    @Binding var activatedCount: Int
    @Binding var clearedCount: Int
    
    @EnvironmentObject var data: DataModel
    @EnvironmentObject var viewModel: CameraViewModel
    @Binding var showDetailView: Bool
    
    var body: some View {
        ScrollView {
            ScrollViewReader { scrollViewProxy in
                VStack {
                    LazyVGrid(columns: columns) {
//                        let dataArr = data.loadData()
                        ForEach(0..<max(activatedCount, data.dataArr.count)) { index in
                            ZStack {
                                RoundedRectangle(cornerRadius: 40)
//                                    .stroke(index < clearedCount ? Color(hex: "5E5CE6"): Color(hex: "595959"), lineWidth: 2)
                                    .stroke(Color(hex: "5E5CE6"), lineWidth: 2)
                                    .background(RoundedRectangle(cornerRadius: 40).fill(Color(hex: "595959")))
                                    .id(index)
                                    .padding(.vertical)
                                    .contentShape(Rectangle())
                                    .overlay {
                                        ZStack {
                                            if index < clearedCount {
                                            
                                                ZStack {
                                                    VStack(spacing: 0) {
                                                        if index < data.dataArr.count {
                                                            let specificData = data.dataArr[index] // 특정 인덱스의 요소를 가져옴
                                                            
                                                            if let beforeImage = data.convertToUIImage(from: specificData.before) {
                                                                Image(uiImage: beforeImage)
                                                                    .resizable()
                                                                    .scaledToFill()
                                                            }
                                                        }
                                                        if index < data.dataArr.count {
                                                            let specificData = data.dataArr[index] // 특정 인덱스의 요소를 가져옴
                                                            
                                                            if let afterImage = data.convertToUIImage(from: specificData.after) {
                                                                Image(uiImage: afterImage)
                                                                    .resizable()
                                                                    .scaledToFill()
                                                            }
                                                        }
                                                        
                                                    }
                                                    .mask(RoundedRectangle(cornerRadius: 40).frame(width: 103, height: 106))
                                                    
                                                    Color(.black).opacity(0.3).mask(RoundedRectangle(cornerRadius: 40).frame(width: 103, height: 106))
                                                    
                                                    if index < clearedCount {
                                                        Text(data.getDate(index: index)).multilineTextAlignment(.center).font(.title2)
                                                            .foregroundColor(.white)
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    .onTapGesture {
                                        withAnimation{
                                            selectedIndex = index
                                            scrollToIndex = index
                                        }
                                        if index < clearedCount {
                                            showDetailView = true
                                            data.selectedIndex = index
                                        }
                                    }
                            }
                            .frame(width: 105, height: 140)
                            .onTapGesture {
                                withAnimation {
                                    selectedIndex = index
                                    scrollToIndex = index
                                }
                            }
                        }
                    }
                }
                .onAppear {
                    clearedCount = data.dataArr.count
                }
                .onReceive(Just(scrollToIndex)) { index in
                    withAnimation {
                        scrollViewProxy.scrollTo(scrollToIndex, anchor: .center)
                    }
                }
            }
        }
        .background(Color(hex: "1C1C1E").ignoresSafeArea())
    }
}
