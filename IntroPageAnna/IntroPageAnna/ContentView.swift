//
//  ContentView.swift
//  IntroPageAnna
//
//  Created by 유빈 on 2023/04/28.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                //이미지 들어가는 곳
                Image("clean")
                    .resizable()
                    .frame(width: 180, height: 180)
                    .navigationTitle("밤정리가 궁금해요!")
                    .offset(y: -20)
                
                //앱 캐치프레이즈
                Text("하루에 10분씩 투자하는 방청소")
                    .padding()
                
                //시작하기 버튼
                NavigationLink(destination: NickNameView(), label: {
                    Text("시작하기")
                        .bold()
                        .frame(width: 280, height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                })
            }
        }
    }
}
//이미지 뷰 설정
struct CircleNumberView: View {
    
    var color: Color
    var number: Int
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 200, height: 200)
                .foregroundColor(color)
            Text("\(number)")
                .foregroundColor(.white)
                .font(.system(size: 70, weight: .bold))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
