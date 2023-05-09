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
    @Published var count = defaults.integer(forKey: "count")
    
    @Published var isUnregistered = false
    @Published var name = ""
    
    @Published var beforeImage:UIImage?
    @Published var afterImage:UIImage?
    @Published var isTimerOn:Bool = false
    @Published var isDone:Bool = false
    
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
    
}

// DailyData 구조체
struct DailyData: Codable {
    var date: Date
    var before: Data // UIImage 대신 Data 사용
    var after: Data // UIImage 대신 Data 사용
}

// 데이터 저장 및 로드를 관리하는 클래스
class DataManager {
    private let userDefaults = UserDefaults.standard
    private let key = "dailyData"
    
    func saveData(_ data: [DailyData]) {
        do {
            let encodedData = try JSONEncoder().encode(data)
            userDefaults.set(encodedData, forKey: key)
        } catch {
            print("Failed to encode data: \(error)")
        }
    }
    
    func loadData() -> [DailyData] {
        guard let encodedData = userDefaults.data(forKey: key) else { return [] }
        
        do {
            let decodedData = try JSONDecoder().decode([DailyData].self, from: encodedData)
            return decodedData
        } catch {
            print("Failed to decode data: \(error)")
            return []
        }
    }
}

//색 Hex코드로 전환시켜줌
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

//func saveImageToUserDefaults(image: UIImage) {
//    // 이미지를 UserDefaults에 저장
////    if let image = UIImage(named: "myImage.png") {
////        if let imageData = image.pngData() {
////            UserDefaults.standard.set(imageData, forKey: "myImageKey")
////        }
////    }
//
//    if let imageData = image.pngData() {
//        UserDefaults.standard.set(imageData, forKey: "myImageKey")
//    }
//}
//
//
//func getImageFromUserDefaults() -> UIImage {
////    // UserDefaults에서 이미지를 가져오기
////    if let imageData = UserDefaults.standard.data(forKey: "myImageKey") {
////        let image = UIImage(data: imageData)
////        // 이미지 사용
////    }
//
//    let imageData = UserDefaults.standard.data(forKey: "myImageKey")
//    let image = UIImage(data: imageData!)
//    return image!
//}
