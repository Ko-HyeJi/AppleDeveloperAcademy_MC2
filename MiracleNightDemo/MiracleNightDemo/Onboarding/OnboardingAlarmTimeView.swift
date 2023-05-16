//
//  OnboardingAlarmTimeView.swift
//  MC2_Onboarding
//
//  Created by 유빈 on 2023/05/11.
//

//import SwiftUI
//
//struct OnboardingAlarmTimeView: View {
//    @EnvironmentObject var data: DataModel
//    @Binding var isSecondLaunching: Bool
//    @State var originalValue = true
//    @State var alarmTime = Date()
//
//    var body: some View {
//        ZStack {
//            Color(hex: "#1C1C1E")
//                .edgesIgnoringSafeArea(.all)
//            VStack {
//                Text("언제 알람받기를 원하시나요?").font(.system(size: 22, weight: .bold))
//
//                let dateFormatter = DateFormatter()
//                let _ = dateFormatter.dateFormat = "h:mm a"
//                HStack {
//                    Text(dateFormatter.string(from: alarmTime))
//                        .font(.system(size: 17))
//                        .frame(alignment: .leading)
//                        .padding([.top, .leading])
//                    Spacer()
//                }
//                Divider()
//                    .foregroundColor(Color(hex: "545458"))
//
//                Form {
//                    DatePicker("Please enter a date", selection: $alarmTime, displayedComponents: .hourAndMinute)
//                        .datePickerStyle(WheelDatePickerStyle())
//                        .labelsHidden()
//                        .onChange(of: alarmTime) { newValue in
//                            data.notificationTime = Calendar.current.dateComponents([.hour, .minute, .second], from: alarmTime)
//                        }
//                }.scrollDisabled(true)
//            }.padding(.top, 64)
//            // 온보딩 완료 버튼.
//            // AppStorage의 isSecondLaunching 값을 false로 바꾸기 때문에, 다음번에 앱을 실행할 때는 OnboardingTabView를 띄우지 않음.
//            VStack {
//
//                if let nowHour = data.notificationTime?.hour {
//                    if (nowHour >= 00) && (nowHour < 24) {
//                        Button {
//                            isSecondLaunching.toggle()
//                            RequestNotificationPermission()
//                            SendNotification(notificationTime: data.notificationTime!) //여기서 설정하면 왜 안되는지 모르겠음...
//                        } label: {
//                            Text("시간을 선택해주세요")
//                                .fontWeight(.bold)
//                                .foregroundColor(Color(hex: "FFFFFF"))
//                                .frame(width: 358, height: 56)
//                                .background(Color(hex: "5E5CE6"))
//                                .cornerRadius(14)
//                        }
//
//
//                    } else {
//                        Button {
//                            isSecondLaunching.toggle()
//                        } label: {
//                            Text("밤정리 시작하기")
//                                .fontWeight(.bold)
//                                .foregroundColor(Color(hex: "FFFFFF"))
//                                .frame(width: 358, height: 56)
//                                .background(Color(hex: "9C9C9C"))
//                                .cornerRadius(14)
//                        }
//                        .disabled(true)
//                    }
//                }
//
//            }
//            .frame(maxHeight: .infinity, alignment: .bottom)
//            .padding(.bottom, 50)
//            .onAppear {
//
//
//
//                data.notificationTime = Calendar.current.dateComponents([.hour, .minute, .second], from: alarmTime)
//                //시, 분, 초를 정의함
//            }
//
//        }
//        .navigationBarBackButtonHidden(true)
//    }
//}
//
