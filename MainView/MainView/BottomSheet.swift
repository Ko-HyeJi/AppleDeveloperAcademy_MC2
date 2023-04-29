//
//  BottomSheet.swift
//  MainView
//
//  Created by 고혜지 on 2023/04/30.
//

import SwiftUI

//struct BottomSheetView: View {
//    @Binding var isBottomSheetOn: Bool
//    var body: some View {
//        HStack {
//            Button(action: {
//                isBottomSheetOn.toggle()
//            }) {
//                Image(systemName: "photo")
//                    .resizable()
//                    .frame(width: 30, height: 25)
//                    .padding(50)
//            }
//                .sheet(isPresented: $isBottomSheetOn) {
//                GridView()
//                    .presentationDetents([.fraction(0.5), .large])
//            }
//            Spacer()
//        }
//    }
//}

struct BottomSheetView: View {
    @Binding var isBottomSheetOn: Bool
    var body: some View {
        Text("")
            .onAppear { isBottomSheetOn.toggle() }
            .sheet(isPresented: $isBottomSheetOn) {
                GridView()
                .presentationDetents([.fraction(0.2), .large])
        }
    }
}

struct GridView: View {
    let columnLayout = Array(repeating: GridItem(), count: 3)
    let allColors: [Color] = [.pink, .red, .orange, .yellow, .green, .mint, .teal, .cyan, .blue, .indigo, .purple, .brown]
    
    @State private var selectedColor = Color.gray
    
    var body: some View {
        VStack {
            Text("Selected Color")
                .font(.body)
                .fontWeight(.semibold)
                .foregroundColor(selectedColor)
                .padding()
            
            ScrollView {
                LazyVGrid(columns: columnLayout) {
                    ForEach(allColors, id: \.description) { color in
                        Button {
                            selectedColor = color
                        } label: {
                            RoundedRectangle(cornerRadius: 4.0)
                                .aspectRatio(1.0, contentMode: .fit)
                                .foregroundColor(color)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
        .padding(10)
    }
}

//struct BottomSheetView_Previews: PreviewProvider {
//    @Binding var isBottomSheetOn: Bool
//    static var previews: some View {
//        BottomSheetView(isBottomSheetOn: $isBottomSheetOn)
//    }
//}
