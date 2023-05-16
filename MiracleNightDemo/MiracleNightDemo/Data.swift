//
//  Data.swift
//  MiracleNightDemo
//
//  Created by 고혜지 on 2023/05/03.
//

import Foundation
import SwiftUI
import AVFoundation

let defaults = UserDefaults.standard

class DataModel: ObservableObject {
    private var audioPlayer: AVAudioPlayer?
    
    @Published var isMusicOn = false
    @Published var currentTime: TimeInterval = 0

    init() {
        configureAudioSession()
    }

    func configureAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("오디오 세션 설정에 실패했습니다.")
        }
    }
    
    func playMusic() {
        if let path = Bundle.main.path(forResource: "music", ofType: "mp3") {
            do {
                let url = URL(fileURLWithPath: path)
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.currentTime = currentTime
                audioPlayer?.play()
                isMusicOn = true
            } catch {
                print("음악 재생에 실패했습니다.")
            }
        }
    }

    func pauseMusic() {
        audioPlayer?.pause()
        currentTime = audioPlayer?.currentTime ?? 0
        isMusicOn = false
    }
    
    @EnvironmentObject var viewModel: CameraViewModel
    
    @Published var username = defaults.string(forKey: "username")
    @Published var name = ""
    @Published var notificationTime: DateComponents?
    @Published var isSetNotification = defaults.bool(forKey: "isSetNotification")
    
    @Published var beforeImage:UIImage?
    @Published var afterImage:UIImage?
    @Published var isTimerOn:Bool = false //before 사진 찍고 타이머 온
    @Published var isTimeOver:Bool = false
    @Published var isDone:Bool = false //after 사진까지 찍었을 떄
    @Published var isSaved:Bool = false
    
    @Published var tmpSavedAfter:Bool = false
    
    @Published var showDetailView:Bool = false
    
    @Published var dataArr: [DailyData] = [] //앱이 처음 실행됐을 때, saveDataToUserDefaults 함수가 호출됐을 때 업데이트
    
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
    
    func saveDataToUserDefaults() {
        let beforeData = beforeImage?.pngData()
        let aftereData = afterImage?.pngData()
        let data = DailyData(date: Date(), before: beforeData!, after: aftereData!)
        var dataArr = loadData()
        dataArr.append(data)
        saveData(dataArr)
        self.dataArr = dataArr
    }
    
    func convertToUIImage(from data: Data) -> UIImage? {
        guard let image = UIImage(data: data) else {
            print("Failed to convert data to UIImage")
            return nil
        }
        return image
    }
    
    func getDate(index: Int) -> String {
        let monthFormat = DateFormatter()
        monthFormat.setLocalizedDateFormatFromTemplate("MMMM")
        let dayFormat = DateFormatter()
        dayFormat.dateFormat = "dd"
        
        return (monthFormat.string(from: self.dataArr[index].date) + "\n" + dayFormat.string(from: self.dataArr[index].date))
    }
    
    func getLastDay() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM.dd"
        
        if let date = self.dataArr.last?.date {
            return dateFormatter.string(from: date)
        } else {
            return ("")
        }

    }
    
    @Published var counter: Int = 0 //타이머 시간 측정 변수
    @Published var countTo: Int = 10 //타이머 시간 측정 변수
    
    @Published var selectedIndex: Int = 0
    
    
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

final class Router<T: Hashable>: ObservableObject {
    @Published var paths: [T] = []
    func push(_ path: T) {
        paths.append(path)
    }
    
    func pop() {
        paths.removeLast(1)
    }
    
    func pop(to: T) {
        guard let found = paths.firstIndex(where: { $0 == to }) else {
            return
        }

        let numToPop = (found..<paths.endIndex).count - 1
        paths.removeLast(numToPop)
    }
    
    func popToRoot() {
        paths.removeAll()
    }
}

enum Path {
    case A
    case B
    case C
    case D
    case E
}

//class AudioPlayer: ObservableObject {
//    private var audioPlayer: AVAudioPlayer?
//
//    func playMusic() {
//        if let path = Bundle.main.path(forResource: "music", ofType: "mp3") {
//            do {
//                let url = URL(fileURLWithPath: path)
//                audioPlayer = try AVAudioPlayer(contentsOf: url)
//                audioPlayer?.play()
//            } catch {
//                print("음악 재생에 실패했습니다.")
//            }
//        }
//    }
//
//    func pauseMusic() {
//        audioPlayer?.pause()
//    }
//}
