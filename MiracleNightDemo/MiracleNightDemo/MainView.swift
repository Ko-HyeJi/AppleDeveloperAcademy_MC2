//
//  ContentView.swift
//  CheckProgress
//
//  Created by 장수민 on 2023/05/09.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        
        @State var countDay: Int = 2
        @State var currentGoal: Int = 7
        @State var progress: Double = Double(countDay) / Double(currentGoal)
        @State var progressText: String = "첫 방정리를 기다리고 있어요"
        
        NavigationView {
            GeometryReader {
                let size = $0.size
                
                VStack(alignment: .center) {
                    Spacer()
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: size.width / 1.08, height: size.height / 6.16)
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
                                    
                                    Text("\(countDay)/\(currentGoal)")
                                        .foregroundColor(Color.white)
                                        .fontWeight(.semibold)
                                    
                                    ProgressView("\(progressText)",value: progress)
                                        .progressViewStyle(LinearProgressViewStyle(tint: Color(hex: "9DEBBB")))
                                        .foregroundColor(.white)
                                        .padding(.bottom, size.height / 30)
                                    
                                    Spacer()
                                }
                                .padding(.vertical, size.height / 30 )
                                .padding(.horizontal, size.width / 15)
                            }
                }
                .padding()
                .position(x: size.width / 2, y: size.height / 2)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
