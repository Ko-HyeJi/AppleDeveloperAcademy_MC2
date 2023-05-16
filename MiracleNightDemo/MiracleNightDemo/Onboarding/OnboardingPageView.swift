//
//  OnboardingPageView.swift
//  MC2_Onboarding
//
//  Created by 유빈 on 2023/05/08.
//

import SwiftUI

struct OnboardingPageView: View {
    let uppertitle: String
    let lowertitle: String
    let subtitle: String
    
    var body: some View {
        ZStack {
            Image("onboardingBG")
                .resizable()
                .frame(width: 390, height: 860)
            VStack {
                VStack(spacing: UIScreen.main.bounds.height * 0.05) {
                    Text(uppertitle)
                        .frame(width: 350)
                        .font(Font(UIFont.systemFont(ofSize: 120, weight: .bold, width: .compressed)))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, -80)
                    Text(lowertitle)
                        .frame(width: 350)
                        .font(Font(UIFont.systemFont(ofSize: 120, weight: .bold, width: .compressed)))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 40)
                }
                Text(subtitle)
                    .frame(width: 250)
                    .font(.system(size: 17))
                    .lineSpacing(2)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.top, 60)
            }
            .padding(.top, -180)
        }
        .edgesIgnoringSafeArea(.all)
    }
}


//struct OnboardingPageView_Previews: PreviewProvider {
//    static var previews: some View {
//        OnboardingPageView(
//            uppertitle: "00",
//            lowertitle: "00",
//            subtitle: "24시간 중 단 1%\n 15분동안 정리할 곳을 정해"
//        )
//    }
//}
