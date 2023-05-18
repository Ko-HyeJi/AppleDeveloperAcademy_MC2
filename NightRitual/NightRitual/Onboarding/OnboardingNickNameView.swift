import SwiftUI

struct OnboardingNickNameView: View {
    @EnvironmentObject var data: DataModel
    @State var name: String = ""

    var body: some View {

        NavigationView {
            ZStack {
                Color(hex: "#1C1C1E")
                    
                VStack {
                    Text("당신의 이름을 알려주세요.")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.top, 100)

                    HStack {
                        TextField("", text : $name)
                                .frame(height: 45)
                                .foregroundColor(.white)
                                .font(.system(size: 17))
                                .padding(.leading)
                        
                        Button {
                            name = ""
                        } label: {
                            Image("ExitButton")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .padding(.trailing)
                        }
                    }
                    Divider()
                        .background(Color(hex: "545458"))
                    
                    Spacer()

                    FinishButtonView(name: $name)
                        .padding(.bottom, 60)
                }
            }
            .ignoresSafeArea(.container)
            .onDisappear {
                data.userName = name
            }
        }
    }
}

struct FinishButtonView: View {
    @EnvironmentObject var data: DataModel
    @Binding var name: String
    
    var body: some View {
        Button {
            data.isSecondLaunching.toggle()
        } label: {
            Text("작성 완료")
                .fontWeight(.bold)
                .foregroundColor(Color(hex: "FFFFFF"))
                .frame(width: 358, height: 56)
                .background(name.isEmpty ? Color(hex: "9C9C9C") : Color(hex: "5E5CE6"))
                .cornerRadius(14)
        }.disabled(name.isEmpty)
    }
}
