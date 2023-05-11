//
//  OnboardingAlarmTimeView.swift
//  MC2_Onboarding
//
//  Created by 유빈 on 2023/05/11.
//

import SwiftUI

struct OnboardingAlarmTimeView: View {
    
    @State var AlarmTime = Date() //
    @Binding var isSecondLaunching: Bool
    @State var originalValue = true
    

//    let calendar = Calendar.current
    @State var nowComponents: DateComponents?
    @State var  sixPm = Calendar.current.date(from: DateComponents(hour: 18, minute: 0, second: 0))!
    @State var  elevenFiftyNine = Calendar.current.date(from: DateComponents(hour: 23, minute: 59, second: 59))!

    
    
    var body: some View {
        ZStack {
            Color(hex: "#1C1C1E")
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("언제 알람받기를 원하시나요?")
                    .font(.system(size: 22, weight: .bold))
                Form {
                    DatePicker("Time", selection: $AlarmTime)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .onChange(of: AlarmTime) { newValue in
                            nowComponents = Calendar.current.dateComponents([.hour, .minute, .second], from: AlarmTime)
                        }//타임피커에서 뽑아온 시, 분, 초가 바뀔 때 마다 데이터를 수집함
                }
            }
            // 온보딩 완료 버튼.
            // AppStorage의 isSecondLaunching 값을 false로 바꾸기 때문에, 다음번에 앱을 실행할 때는 OnboardingTabView를 띄우지 않음.
            VStack {

                if let nowHour = nowComponents?.hour {
                    if (nowHour >= 18) && (nowHour < 24) {
                     Button {
                         isSecondLaunching.toggle()
                     } label: {
                         Text("시간을 선택해주세요")
                             .fontWeight(.bold)
                             .foregroundColor(Color(hex: "FFFFFF"))
                             .frame(width: 358, height: 56)
                             .background(Color(hex: "5E5CE6"))
                             .cornerRadius(14)
                     }
                     
                     
                 } else {
                     Button {
                         isSecondLaunching.toggle()
                     } label: {
                         Text("밤정리 시작하기")
                             .fontWeight(.bold)
                             .foregroundColor(Color(hex: "FFFFFF"))
                             .frame(width: 358, height: 56)
                             .background(Color(hex: "9C9C9C"))
                             .cornerRadius(14)
                     }
                     .disabled(true)
                 }
                }
                   
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
            .padding(.bottom, 85)
            .onAppear {
                
                       

                nowComponents = Calendar.current.dateComponents([.hour, .minute, .second], from: AlarmTime)
                //시, 분, 초를 정의함
            }
            
        }
    }
}

