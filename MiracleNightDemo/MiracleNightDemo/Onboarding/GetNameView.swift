//
//  GetNameView.swift
//  MiracleNightDemo
//
//  Created by 고혜지 on 2023/05/04.
//

import SwiftUI

struct GetNameView: View {
    @EnvironmentObject var data: DataModel

    var body: some View {
        VStack {
            TextField("Enter your name", text: $data.name)
                .padding()
            Button("Save") {
                let defaults = UserDefaults.standard
                defaults.set(data.name, forKey: "username")
                data.isUnregistered = false
            }
        }
        .padding()
    }
}
