//import SwiftUI
//import AVFoundation
//
//struct CameraView: View {
//    @EnvironmentObject var dataModel: DataModel
//
//    @ObservedObject var viewModel = CameraViewModel()
//
//    var body: some View {
//        ZStack {
//            viewModel.cameraPreview.ignoresSafeArea() //.ignoresSafeArea(): 뷰가 안전 영역 경계를 무시하도록 지시, 뷰가 전체 화면을 차지하고 안전 영역에 있는 내용을 가리는 것을 허용
//                .onAppear { viewModel.configure() } //뷰가 나타날 때 ViewModel에서 제공하는 configure() 메서드가 호출됨
//                .gesture( MagnificationGesture() //.gesture(): 메서드는 뷰에 제스처 인식기를 추가 //MagnificationGesture(): 확대 / 축소 제스처를 인식
//                    .onChanged { val in viewModel.zoom(factor: val) } //.onChanged(): 제스처의 변화가 있을 때 호출 //val 매개변수로 전달된 값에 따라 ViewModel의 zoom() 메서드를 호출
//                    .onEnded { _ in viewModel.zoomInitialize() } ) //.onEnded(): 제스처가 종료될 때 호출 //ViewModel의 zoomInitialize() 메서드를 호출하여 제스처를 초기화
//
//            VStack {
//                HStack {
//                    // 셔터사운드 온오프
//                    Button(action: {viewModel.switchSilent()}) {
//                        Image(systemName: viewModel.isSilentModeOn ? "speaker.fill" : "speaker")
//                            .foregroundColor(viewModel.isSilentModeOn ? .yellow : .white)
//                    }
//                    .padding(.horizontal, 30)
//
//                    // 플래시 온오프
//                    Button(action: {viewModel.switchFlash()}) {
//                        Image(systemName: viewModel.isFlashOn ?
//                              "bolt.fill" : "bolt")
//                            .foregroundColor(viewModel.isFlashOn ? .yellow : .white)
//                    }
//                    .padding(.horizontal, 30)
//                }
//                .font(.system(size:25))
//                .padding()
//
//                Spacer()
//
//                HStack{
//                    // 찍은 사진 미리보기
//                    Button(action: {viewModel.showPreview = true}) {
//                        if let previewImage = viewModel.recentImage {
//                            Image(uiImage: previewImage)
//                                .resizable()
//                                .scaledToFill()
//                                .frame(width: 75, height: 75)
//                                .clipShape(RoundedRectangle(cornerRadius: 15))
//                                .aspectRatio(1, contentMode: .fit)
//                        } else {
//                            RoundedRectangle(cornerRadius: 15)
//                                .stroke(lineWidth: 3)
//                                .foregroundColor(.white)
//                                .frame(width: 75, height: 75)
//                        }
//                    }
//                    .padding()
//
//                    Spacer()
//
//                    // 사진찍기 버튼
//                    Button(action: {
//                        viewModel.capturePhoto()
//                        dataModel.isTimerOn = true
//                    }) {
//                        Circle()
//                            .stroke(lineWidth: 5)
//                            .frame(width: 75, height: 75)
//                            .padding()
//                    }
//
//                    Spacer()
//
//                    // 전후면 카메라 교체
//                    Button(action: {viewModel.changeCamera()}) {
//                        Image(systemName: "arrow.triangle.2.circlepath.camera")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 50, height: 50)
//
//                    }
//                    .frame(width: 75, height: 75)
//                    .padding()
//                }
//            }
//            .foregroundColor(.white) //VStack에 포함된 모든 버튼 흰색으로
//
//
//            //필터 기능 추가 -> 수정 필요
//            CameraFilterView()
//
//
//
//        }
//        .fullScreenCover(isPresented: $viewModel.showPreview) { //왼쪽 하단 미리보기 버튼을 눌렀을 때 화면 전체에 사진이 보이도록
//            Image(uiImage: viewModel.recentImage ?? UIImage())
//                .resizable()
//                .scaledToFit()
//                .frame(width: UIScreen.main.bounds.width,
//                       height: UIScreen.main.bounds.height)
//                .ignoresSafeArea()
//                .onTapGesture {
//                    viewModel.showPreview = false
//                }
//        }
//        .opacity(viewModel.shutterEffect ? 0 : 1) //촬영 버튼 클릭할 때 화면 반짝임
//    }
//}
//
//struct CameraPreviewView: UIViewRepresentable {
//    class VideoPreviewView: UIView {
//        override class var layerClass: AnyClass {
//            AVCaptureVideoPreviewLayer.self
//        }
//
//        var videoPreviewLayer: AVCaptureVideoPreviewLayer {
//            return layer as! AVCaptureVideoPreviewLayer
//        }
//    }
//
//    let session: AVCaptureSession
//
//    func makeUIView(context: Context) -> VideoPreviewView {
//        let view = VideoPreviewView()
//
//        view.videoPreviewLayer.session = session
//        view.backgroundColor = .black
//        session.sessionPreset = AVCaptureSession.Preset.hd1920x1080 // 추가!
//        view.videoPreviewLayer.videoGravity = .resizeAspectFill
//        view.videoPreviewLayer.cornerRadius = 0
//        view.videoPreviewLayer.connection?.videoOrientation = .portrait
//
//        return view
//    }
//
//    func updateUIView(_ uiView: VideoPreviewView, context: Context) {
//
//    }
//}
//
//struct CameraView_Previews: PreviewProvider {
//    static var previews: some View {
//        CameraView()
//    }
//}


//import SwiftUI
//import AVFoundation
//
//struct CameraView: View {
//    @ObservedObject var viewModel = CameraViewModel()
//    @EnvironmentObject var dataModel: DataModel
//    @Environment(\.presentationMode) var presentationMode
//
//    var body: some View {
//        ZStack {
//            viewModel.cameraPreview.ignoresSafeArea()
//                .onAppear {
//                    viewModel.configure()
//                }
//                .gesture(MagnificationGesture()
//                            .onChanged { val in
//                    viewModel.zoom(factor: val)
//                }
//                            .onEnded { _ in
//                    viewModel.zoomInitialize()
//                }
//                )
//
//            VStack {
//                HStack {
//                    // 셔터사운드 온오프
//                    Button(action: {viewModel.switchSilent()}) {
//                        Image(systemName: viewModel.isSilentModeOn ?
//                              "speaker.fill" : "speaker")
//                            .foregroundColor(viewModel.isSilentModeOn ? .yellow : .white)
//                    }
//                    .padding(.horizontal, 30)
//
//                    // 플래시 온오프
//                    Button(action: {viewModel.switchFlash()}) {
//                        Image(systemName: viewModel.isFlashOn ?
//                              "bolt.fill" : "bolt")
//                            .foregroundColor(viewModel.isFlashOn ? .yellow : .white)
//                    }
//                    .padding(.horizontal, 30)
//                }
//                .font(.system(size:25))
//                .padding()
//
//                Spacer()
//
//                HStack{
//                    // 찍은 사진 미리보기
//                    Button(action: {viewModel.showPreview = true}) {
//                        if let previewImage = viewModel.recentImage {
//                            Image(uiImage: previewImage)
//                                .resizable()
//                                .scaledToFill()
//                                .frame(width: 75, height: 75)
//                                .clipShape(RoundedRectangle(cornerRadius: 15))
//                                .aspectRatio(1, contentMode: .fit)
//                        } else {
//                            RoundedRectangle(cornerRadius: 15)
//                                .stroke(lineWidth: 3)
//                                .foregroundColor(.white)
//                                .frame(width: 75, height: 75)
//                        }
//                    }
//                    .padding()
//
//                    Spacer()
//
//                    // 사진찍기 버튼
//                    Button(action: {viewModel.capturePhoto()}) {
//                        Circle()
//                            .stroke(lineWidth: 5)
//                            .frame(width: 75, height: 75)
//                            .padding()
//                    }
//
//                    Spacer()
//
////                    // 전후면 카메라 교체
////                    Button(action: {viewModel.changeCamera()}) {
////                        Image(systemName: "arrow.triangle.2.circlepath.camera")
////                            .resizable()
////                            .scaledToFit()
////                            .frame(width: 50, height: 50)
////
////                    }
////                    .frame(width: 75, height: 75)
////                    .padding()
//
//                    // +) 확인 버튼 -> 수정 필요!!!
//                    Button(action: {
//                        if (dataModel.beforeImage == nil) {
//                            print("Before Image Taken")
//                            dataModel.beforeImage = viewModel.recentImage
//                            dataModel.isTimerOn = true
//                        } else if (dataModel.afterImage == nil) {
//                            print("After Image Taken")
//                            dataModel.afterImage = viewModel.recentImage
//                            dataModel.isDone = true
//
//                            let beforeData = dataModel.beforeImage?.pngData()
//                            let aftereData = dataModel.afterImage?.pngData()
//                            let data = DailyData(date: Date(), before: beforeData!, after: aftereData!)
//                            var dataArr = dataModel.loadData()
//                            dataArr.append(data)
//                            dataModel.saveData(dataArr)
//
//                        }
//                        presentationMode.wrappedValue.dismiss() // CameraView 닫기
//
////                        viewModel.stopRunning() //수정 필요!
//
//                    }) {
//                        ZStack {
//                            Image(systemName: "paperplane")
//                                .resizable()
//                                .frame(width: 75, height: 75)
//                                .padding()
//
//                            if (dataModel.beforeImage == nil) {
//                                Text("Save Before").foregroundColor(.blue).bold()
//                            } else if (dataModel.afterImage == nil) {
//                                Text("Save After").foregroundColor(.blue).bold()
//                            }
//                        }
//                    }
//
//
//
//
//                }
//            }
//            .foregroundColor(.white)
//
//
//
//            //필터 기능 추가 -> 수정 필요
//            if (dataModel.beforeImage == nil) {
//                CameraFilterView()
//            } else {
//                Image(uiImage: dataModel.beforeImage!)
//                    .resizable()
//                    .scaledToFill()
//                    .opacity(0.5)
//                    .ignoresSafeArea()
//            }
//
//        }
//        .fullScreenCover(isPresented: $viewModel.showPreview) {
//            Image(uiImage: viewModel.recentImage ?? UIImage())
//                .resizable()
//                .scaledToFit()
//                .frame(width: UIScreen.main.bounds.width,
//                       height: UIScreen.main.bounds.height)
//                .ignoresSafeArea()
//                .onTapGesture {
//                    viewModel.showPreview = false
//                }
//        }
//        .opacity(viewModel.shutterEffect ? 0 : 1)
//    }
//}
//
//
//struct CameraPreviewView: UIViewRepresentable {
//    class VideoPreviewView: UIView {
//        override class var layerClass: AnyClass {
//            AVCaptureVideoPreviewLayer.self
//        }
//
//        var videoPreviewLayer: AVCaptureVideoPreviewLayer {
//            return layer as! AVCaptureVideoPreviewLayer
//        }
//    }
//
//    let session: AVCaptureSession
//
//    func makeUIView(context: Context) -> VideoPreviewView {
//        let view = VideoPreviewView()
//
//        view.videoPreviewLayer.session = session
//        view.backgroundColor = .black
//        view.videoPreviewLayer.videoGravity = .resizeAspectFill
//        view.videoPreviewLayer.cornerRadius = 0
//        view.videoPreviewLayer.connection?.videoOrientation = .portrait
//
//        return view
//    }
//
//    func updateUIView(_ uiView: VideoPreviewView, context: Context) {
//
//    }
//}
//
//struct CameraView_Previews: PreviewProvider {
//    static var previews: some View {
//        CameraView()
//    }
//}


import SwiftUI
import AVFoundation

struct CameraView: View {
    @EnvironmentObject var data: DataModel
    @EnvironmentObject var viewModel: CameraViewModel
    @EnvironmentObject var router: Router<Path>

    
    var body: some View {
        ZStack {
            viewModel.cameraPreview
                .ignoresSafeArea() //.ignoresSafeArea(): 뷰가 안전 영역 경계를 무시하도록 지시, 뷰가 전체 화면을 차지하고 안전 영역에 있는 내용을 가리는 것을 허용
                .onAppear { viewModel.configure() } //뷰가 나타날 때 ViewModel에서 제공하는 configure() 메서드가 호출됨
                .gesture( MagnificationGesture() //.gesture(): 메서드는 뷰에 제스처 인식기를 추가 //MagnificationGesture(): 확대 / 축소 제스처를 인식
                    .onChanged { val in viewModel.zoom(factor: val) } //.onChanged(): 제스처의 변화가 있을 때 호출 //val 매개변수로 전달된 값에 따라 ViewModel의 zoom() 메서드를 호출
                    .onEnded { _ in viewModel.zoomInitialize() } ) //.onEnded(): 제스처가 종료될 때 호출 //ViewModel의 zoomInitialize() 메서드를 호출하여 제스처를 초기화

            
            CameraFilterView()
            
        }
        .opacity(viewModel.shutterEffect ? 0 : 1)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            if data.isMusicOn {
                data.pauseMusic()
            }
        }
    }
}


struct CameraPreviewView: UIViewRepresentable {
    class VideoPreviewView: UIView {
        override class var layerClass: AnyClass {
            AVCaptureVideoPreviewLayer.self
        }

        var videoPreviewLayer: AVCaptureVideoPreviewLayer {
            return layer as! AVCaptureVideoPreviewLayer
        }
    }

    let session: AVCaptureSession

    func makeUIView(context: Context) -> VideoPreviewView {
        let view = VideoPreviewView()

        view.videoPreviewLayer.session = session
        view.backgroundColor = .black
        view.videoPreviewLayer.videoGravity = .resizeAspectFill
        view.videoPreviewLayer.cornerRadius = 0
        view.videoPreviewLayer.connection?.videoOrientation = .portrait

        return view
    }

    func updateUIView(_ uiView: VideoPreviewView, context: Context) {

    }
}

//struct CameraView_Previews: PreviewProvider {
//    static var previews: some View {
//        CameraView()
//    }
//}
