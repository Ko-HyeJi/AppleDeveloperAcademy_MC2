//
//  TestView.swift
//  MiracleNightDemo
//
//  Created by 고혜지 on 2023/05/08.
//

import SwiftUI

struct TestView: View {
    @EnvironmentObject var dataModel: DataModel
    
    let columns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 10), count: 3)
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(dataModel.loadData(), id: \.date) { dailyData in
                    if let beforeData = dailyData.before as? Data,
                       let beforeImage = UIImage(data: beforeData) {
                        Image(uiImage: beforeImage)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
            }
            .padding()
        }
    }
}
