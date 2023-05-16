//
//  ContentView.swift
//  MiracleNightDemo
//
//  Created by 고혜지 on 2023/05/03.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    @EnvironmentObject var data: DataModel
    @EnvironmentObject var viewModel: CameraViewModel
    @ObservedObject var router = Router<Path>()
    
    var body: some View {
        NavigationStack(path: $router.paths) {
            MainView()
            .navigationDestination(for: Path.self) { path in
                switch path {
                case .A: MainView()
                case .B: CameraView()
                case .C: CheckBeforeImageView()
                case .D: DoNotDisturbView()
                case .E: CompareView()
                case .F: SettingView()
                }
            }
        }
        .environmentObject(router)
        .onAppear{
            data.dataArr = data.loadData()
            do {
                try AVAudioSession.sharedInstance().setCategory(.playback)
                try AVAudioSession.sharedInstance().setActive(true)
            } catch {
                print("오디오 세션 설정에 실패했습니다: \(error)")
            }
        }
        .fullScreenCover(isPresented: $data.showDetailView) { DetailView() }
        .fullScreenCover(isPresented: $data.isFirstLaunching) { OnboardingTabView() }
        .fullScreenCover(isPresented: $data.isSecondLaunching) { OnboardingNickNameView() }
    }
}
