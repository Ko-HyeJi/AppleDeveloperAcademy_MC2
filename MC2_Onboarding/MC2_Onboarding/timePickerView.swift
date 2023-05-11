//
//  timePickerView.swift
//  MC2_Onboarding
//
//  Created by 유빈 on 2023/05/11.
//

import SwiftUI

struct timePickerView: View {
    @State var AlarmTime = Date()
    
    var body: some View {
        Form {
            DatePicker("Time", selection: $AlarmTime)
        }
    }
}

struct timePickerView_Previews: PreviewProvider {
    static var previews: some View {
        timePickerView()
    }
}
