//
//  Data.swift
//  MiracleNightDemo
//
//  Created by 고혜지 on 2023/05/03.
//

import Foundation
import SwiftUI

let defaults = UserDefaults.standard

class DataModel: ObservableObject {
    @Published var username = defaults.string(forKey: "username")
    
    @Published var isUnregistered = false
    @Published var name = ""
    
    @Published var beforeImage:UIImage?
    @Published var afterImage:UIImage?
    @Published var isTimerOn:Bool = false //before 사진 찍고 타이머 온
    @Published var isTimeOver:Bool = false
    @Published var isDone:Bool = false //after 사진까지 찍었을 떄
    @Published var showCompareView:Bool = false
    
    // 지우기!!!
    @Published var test:Bool = true
    
    func saveData(_ data: [DailyData]) {
        do {
            let encodedData = try JSONEncoder().encode(data)
            defaults.set(encodedData, forKey: "dailyDataArr")
        } catch {
            print("Failed to encode data: \(error)")
        }
    }
    
    func loadData() -> [DailyData] {
        guard let encodedData = defaults.data(forKey: "dailyDataArr") else { return [] }
        
        do {
            let decodedData = try JSONDecoder().decode([DailyData].self, from: encodedData)
            return decodedData
        } catch {
            print("Failed to decode data: \(error)")
            return []
        }
    }
    
    func convertToUIImage(from data: Data) -> UIImage? {
        guard let image = UIImage(data: data) else {
            print("Failed to convert data to UIImage")
            return nil
        }
        return image
    }
    
    func saveDataToUserDefaults() {
        let beforeData = beforeImage?.pngData()
        let aftereData = afterImage?.pngData()
        let data = DailyData(date: Date(), before: beforeData!, after: aftereData!)
        var dataArr = loadData()
        dataArr.append(data)
        saveData(dataArr)
    }
    
    
    @Published var counter: Int = 0 //타이머 시간 측정 변수
    @Published var countTo: Int = 15 //타이머 시간 측정 변수
}

struct DailyData: Codable {
    var date: Date
    var before: Data // UIImage 대신 Data 사용
    var after: Data // UIImage 대신 Data 사용
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)

        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff

        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff
        )
    }
}

