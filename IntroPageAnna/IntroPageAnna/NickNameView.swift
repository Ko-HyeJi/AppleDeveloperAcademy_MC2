//
//  NickNameView.swift
//  IntroPageAnna
//
//  Created by 유빈 on 2023/05/02.
//

import SwiftUI

struct NickNameView: View {
    @State var ChooseNickName: String = " "
    
    var body: some View {
        VStack {
            Text("이 앱에서 당신을 어떻게 불러드릴까요?")

//닉네임 입력하는 칸이에요
            TextField("2~6글자로 작성해주세요", text: $ChooseNickName)
                .padding()
                .background(Color(uiColor: .secondarySystemBackground))

//내가 쓴 이름이 바로 나타나요
            Text("내 이름은 \(ChooseNickName)")
            
            NavigationLink(destination: DatePickerView(), label: {
                Text("다음으로")
                    .bold()
                    .frame(width: 280, height: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            })
        }
    }
}

struct NickNameView_Previews: PreviewProvider {
    static var previews: some View {
        NickNameView()
    }
}

