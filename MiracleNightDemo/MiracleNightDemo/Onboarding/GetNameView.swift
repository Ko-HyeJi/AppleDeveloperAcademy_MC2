//
//  GetNameView.swift
//  MiracleNightDemo
//
//  Created by 고혜지 on 2023/05/04.
//

import SwiftUI

struct GetNameView: View {
    @EnvironmentObject var dataModel: DataModel

    var body: some View {
        VStack {
            TextField("Enter your name", text: $dataModel.name)
                .padding()
            Button("Save") {
                let defaults = UserDefaults.standard
                defaults.set(dataModel.name, forKey: "username")
                dataModel.isUnregistered = false
            }
        }
        .padding()
    }
}
