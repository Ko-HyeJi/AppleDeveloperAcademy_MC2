import SwiftUI

struct ProgressBarView: View {
    @EnvironmentObject var data: DataModel
    
    var body: some View {
        
        @State var countDay: Int = 2
        @State var currentGoal: Int = 7
        @State var progress: Double = Double(calcCountDay(currentGoal: calcCurrentGoal())) / Double(calcCurrentGoal())

        VStack(alignment: .center) {
            Spacer()
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: 358, height: 126)
                    .foregroundColor(Color (hex: "48484A"))
                    .overlay {
                        VStack(alignment: .leading) {
                            HStack {
                                Text("내 기록")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.white)
                                    .padding(.vertical)
                                
                                Spacer()
                                
                                NavigationLink(destination: CheckProgressView().navigationBarBackButtonHidden(true).navigationBarHidden(true)) {
                                    Label {
                                        Image(systemName: "chevron.right")
                                                .foregroundColor(Color(hex: "757575"))
                                            } icon: {
                                                Text("자세히 보기")
                                                    .foregroundColor(.white)
                                        }
                                    .padding(.vertical)
                                }
                            }
                            .padding(.top)
                            
                            Spacer()
                            
                            Text("밤정리 완료 횟수 " + String(calcCountDay(currentGoal: calcCurrentGoal())) +  "/" + String(calcCurrentGoal()))
                                .foregroundColor(Color.white)
                                .fontWeight(.semibold)
                            
                            ProgressView()
                                .progressViewStyle(CustomProgressViewStyle(lineWidth: 10, progress: progress))
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
}

struct CustomProgressViewStyle: ProgressViewStyle {
    var lineWidth: CGFloat
    var progress: Double

    @EnvironmentObject var data: DataModel

    func makeBody(configuration: Configuration) -> some View {
        let _ = configuration.fractionCompleted ?? 0
        let backgroundColor = Color.gray
        let foregroundColor = Color(hex: "5E5CE6")

        return VStack(alignment: .leading, spacing: -10) {
            Text(selectMessage())
                .foregroundColor(.white)
                .padding(.bottom)

            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 5)
                        .frame(height: lineWidth)
                        .foregroundColor(backgroundColor)

                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: progress * geometry.size.width, height: lineWidth)
                        .foregroundColor(foregroundColor)
                }
            }
        }
    }

    private func selectMessage() -> String {
        if (data.dataArr.count == 0) {
            return "첫 밤정리를 기다리고 있어요"
        } else if (data.dataArr.count == 1) {
            return "대단해요! 첫 밤정리를 완료하셨군요🎉"
        } else {
            return "마지막 밤정리 완료일 " + data.getLastDay()
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProgressBarView()
//    }
//}
