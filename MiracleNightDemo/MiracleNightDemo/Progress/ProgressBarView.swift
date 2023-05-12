//
//  ContentView.swift
//  CheckProgress
//
//  Created by 장수민 on 2023/05/09.
//

import SwiftUI

struct ProgressBarView: View {
    @EnvironmentObject var data: DataModel
    
    var body: some View {
        
        @State var countDay: Int = 2
        @State var currentGoal: Int = 7
        @State var progress: Double = Double(calcCountDay(currentGoal: calcCurrentGoal())) / Double(calcCurrentGoal())
//        @State var progressText: String = "첫 방정리를 기다리고 있어요"

        VStack(alignment: .center) {
            Spacer()
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 358, height: 126)
                    .foregroundColor(Color (hex: "48484A"))
                    .overlay {
                        VStack(alignment: .leading) {
                            HStack {
                                Text("방정리 체크")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.white)
                                    .padding(.vertical)
                                
                                Spacer()
                                
                                NavigationLink(destination: CheckProgressView().navigationBarBackButtonHidden(true).navigationBarHidden(true)) {
                                    Label {
                                        Image(systemName: "chevron.right")
                                                .foregroundColor(Color(hex: "757575"))
                                            } icon: {
                                                Text("more")
                                                    .foregroundColor(.white)
                                        }
                                    .padding(.vertical)
                                }
                            }
                            .padding(.top)
                            
                            Spacer()
                            
                            Text(String(calcCountDay(currentGoal: calcCurrentGoal())) +  "/" + String(calcCurrentGoal()))
                                .foregroundColor(Color.white)
                                .fontWeight(.semibold)
                            
                            ProgressView(selectMessage(), value: progress)
                                .progressViewStyle(LinearProgressViewStyle(tint: Color(hex: "5E5CE6")))
                                .foregroundColor(.white)
                                .padding(.bottom)
                            
                            Spacer()
                        }
                        .padding(.vertical)
                        .padding(.horizontal)
                        .padding(.bottom)
                    }
            }
            .padding()
//            .position(x: size.width / 2, y: size.height / 2)
//        }
    }
    
    func calcCurrentGoal() -> Int {
        if data.dataArr.count < 3 {
            return 3
        } else if data.dataArr.count < 8 {
            return 5
        } else {
            return 7
        }
    }
    
    func calcCountDay(currentGoal: Int) -> Int {
        if currentGoal == 3 {
            return data.dataArr.count
        } else if currentGoal == 5 {
            return data.dataArr.count - 3
        } else {
            return data.dataArr.count - 8
        }
    }
    
    func selectMessage() -> String {
        if (data.dataArr.count == 0) {
            return "첫 방정리를 기다리고 있어요"
        } else if (data.dataArr.count == 1) {
            return "첫 방정리를 완료했습니다!"
        } else {
            return "마지막 밤정리 완료일 " + data.getLastDay()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBarView()
    }
}
