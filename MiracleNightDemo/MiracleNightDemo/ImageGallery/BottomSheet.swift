//
//  BottomSheet.swift
//  MainView
//
//  Created by 고혜지 on 2023/04/30.
//

//import SwiftUI
//
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
//                PhotoGridView()
//                    .presentationDetents([.fraction(0.5), .large])
//            }
//            Spacer()
//        }
//    }
//}
