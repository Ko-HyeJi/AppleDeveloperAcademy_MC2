//
//  Data.swift
//  MiracleNightDemo
//
//  Created by 고혜지 on 2023/05/03.
//

import Foundation
import SwiftUI

let defaults = UserDefaults.standard
//let username = defaults.string(forKey: "username")
//let visited = defaults.integer(forKey: "visited")

class DataModel: ObservableObject {
    @Published var username = defaults.string(forKey: "username")
    @Published var visited = defaults.integer(forKey: "visited")
    
    @Published var isUnregistered = false
    @Published var name = ""
    
    @Published var beforeImage:UIImage?
    @Published var afterImage:UIImage?
    @Published var isTimerOn:Bool = false
    @Published var isDone:Bool = false
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
