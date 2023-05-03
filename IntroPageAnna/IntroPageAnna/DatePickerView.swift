//
//  DatePickerView.swift
//  IntroPageAnna
//
//  Created by 유빈 on 2023/05/01.
//

import Foundation
import SwiftUI

struct DatePickerView: View {
 
    @State private var date: Date?
    
    var body: some View {
        DatePickerTextField(placeholder: "Select Data",
                            date: self.$date)
    }
}

struct DatePickerView_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerView()
    }
}
