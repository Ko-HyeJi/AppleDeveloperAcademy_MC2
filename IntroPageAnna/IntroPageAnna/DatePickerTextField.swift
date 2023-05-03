//
//  DatePickerTextField.swift
//  IntroPageAnna
//
//  Created by 유빈 on 2023/05/01.
//

import Foundation
import SwiftUI

struct DatePickerTextField: UIViewRepresentable {
    //DatePicker요소 정의
    private let textField = UITextField()
    private let datePicker = UIDatePicker()
    private let helper = Helper()
    //2***/00/00으로 날짜 나타냄
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        return dateFormatter
    }()
    
    //DatePicker만들기
    public var placeholder: String
    @Binding public var date: Date?
    
    func makeUIView(context: Context) -> UITextField {
        self.datePicker.datePickerMode = .date
        self.datePicker.preferredDatePickerStyle = .wheels
        self.datePicker.addTarget(self.helper,
                                  action: #selector(self.helper.dateValueChanged),
                                  for: .valueChanged)
        self.textField.placeholder = self.placeholder
        self.textField.inputView = self.datePicker
        
    //Accessory View
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done",
                                         style: .plain,
                                         target: self.helper,
                                         action: #selector(self.helper.doneButtonAction))
        toolbar.setItems([flexibleSpace, doneButton], animated: true)
        self.textField.inputAccessoryView = toolbar
        
        self.helper.dateChanged = {
            self.date = self.datePicker.date
        }
    
        self.helper.doneButtonTapped = {
            if self.date == nil {
                self.date = self.datePicker.date
            }
            self.textField.resignFirstResponder()
        }
        
        return self.textField
    }
    
    //사용자 지정에 따른 날짜 나타내기
    func updateUIView(_ uiView: UITextField, context: Context) {
        if let selectedDate = self.date {
            uiView.text = self.dateFormatter.string(from: selectedDate)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    //헬퍼 클래스 정의
    class Helper {
        
        public var dateChanged: (() -> Void)?
        public var doneButtonTapped: (() -> Void)?
        
        @objc func dateValueChanged() {
            self.dateChanged?()
        }
        
        @objc func doneButtonAction() {
            self.doneButtonTapped?()
        }
    }
    
    class Coordinator {
        
    }
}
