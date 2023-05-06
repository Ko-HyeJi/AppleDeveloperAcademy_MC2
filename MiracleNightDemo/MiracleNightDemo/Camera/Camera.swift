import SwiftUI
import AVFoundation
import Photos

class Camera: NSObject, ObservableObject {
    @EnvironmentObject var dataModel: DataModel

    var session = AVCaptureSession() //Input 과 Output 을 연결해주는 파이프 역할, Capture 의 디테일 설정을 관리
    var videoDeviceInput: AVCaptureDeviceInput! //카메라 기기로부터 프로그램에 들어오는 사진이나 동영상 데이터
    let output = AVCapturePhotoOutput() //사진을 찍어서 나온 결과
    var photoData = Data(count: 0)
    var isSilentModeOn = false
    var flashMode: AVCaptureDevice.FlashMode = .off

    @Published var recentImage: UIImage?
    @Published var isCameraBusy = false

    // 카메라 셋업 과정을 담당하는 함수,
    func setUpCamera() {


        if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) {
            do { // 카메라가 사용 가능하면 세션에 input과 output을 연결
                videoDeviceInput = try AVCaptureDeviceInput(device: device)
                if session.canAddInput(videoDeviceInput) {
                    session.addInput(videoDeviceInput)
                }
                if session.canAddOutput(output) {
                    session.addOutput(output)
                    output.isHighResolutionCaptureEnabled = true
                    output.maxPhotoQualityPrioritization = .quality
                }
                session.startRunning() // 세션 시작
            } catch {
                print(error) // 에러 프린트
            }
        }
    }

    func requestAndCheckPermissions() {
        // 카메라 권한 상태 확인
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            // 권한 요청
            AVCaptureDevice.requestAccess(for: .video) { [weak self] authStatus in
                if authStatus {
                    DispatchQueue.main.async {
                        self?.setUpCamera()
                    }
                }
            }
        case .restricted:
            break
        case .authorized:
            // 이미 권한 받은 경우 셋업
            setUpCamera()
        default:
            // 거절했을 경우
            print("Permession declined")
        }
    }

    func capturePhoto() {
        // 사진 옵션 세팅
        let photoSettings = AVCapturePhotoSettings()
        photoSettings.flashMode = self.flashMode

        self.output.capturePhoto(with: photoSettings, delegate: self)
        print("[Camera]: Photo's taken")
    }

    func savePhoto(_ imageData: Data) {
//        let watermark = UIImage(named: "watermark")
        guard let image = UIImage(data: imageData) else { return }

//        let newImage = image.overlayWith(image: watermark ?? UIImage()) //워터마크

        /*
         <수정>
         기존: UIImageWriteToSavedPhotosAlbum(newImage, nil, nil, nil) -> 찍은 사진을 사진 라이브러리에 저장
         수정: saveImageToSpecificAlbum(image: image) -> 사진 라이브러리의 특정 "앨범"에 저장
        */
        saveImageToSpecificAlbum(image: image, albumName: "MiracleNight")

        print("[Camera]: Photo's saved")
    }

    func zoom(_ zoom: CGFloat){
        let factor = zoom < 1 ? 1 : zoom
        let device = self.videoDeviceInput.device

        do {
            try device.lockForConfiguration()
            device.videoZoomFactor = factor
            device.unlockForConfiguration()
        }
        catch {
            print(error.localizedDescription)
        }
    }

    func changeCamera() {
        let currentPosition = self.videoDeviceInput.device.position
        let preferredPosition: AVCaptureDevice.Position

        switch currentPosition {
        case .unspecified, .front:
            print("후면카메라로 전환합니다.")
            preferredPosition = .back

        case .back:
            print("전면카메라로 전환합니다.")
            preferredPosition = .front

        @unknown default:
            print("알 수 없는 포지션. 후면카메라로 전환합니다.")
            preferredPosition = .back
        }

        if let videoDevice = AVCaptureDevice
            .default(.builtInWideAngleCamera,
                     for: .video, position: preferredPosition) {
            do {
                let videoDeviceInput = try AVCaptureDeviceInput(device: videoDevice)
                self.session.beginConfiguration()

                if let inputs = session.inputs as? [AVCaptureDeviceInput] {
                    for input in inputs {
                        session.removeInput(input)
                    }
                }
                if self.session.canAddInput(videoDeviceInput) {
                    self.session.addInput(videoDeviceInput)
                    self.videoDeviceInput = videoDeviceInput
                } else {
                    self.session.addInput(self.videoDeviceInput)
                }

                if let connection =
                    self.output.connection(with: .video) {
                    if connection.isVideoStabilizationSupported {
                        connection.preferredVideoStabilizationMode = .auto
                    }
                }

                output.isHighResolutionCaptureEnabled = true
                output.maxPhotoQualityPrioritization = .quality

                self.session.commitConfiguration()
            } catch {
                print("Error occurred: \(error)")
            }
        }
    }
}

extension Camera: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, willBeginCaptureFor resolvedSettings: AVCaptureResolvedPhotoSettings) {
        self.isCameraBusy = true
    }

    func photoOutput(_ output: AVCapturePhotoOutput, willCapturePhotoFor resolvedSettings: AVCaptureResolvedPhotoSettings) {
        if isSilentModeOn {
            print("[Camera]: Silent sound activated")
            AudioServicesDisposeSystemSoundID(1108)
        }

    }
    func photoOutput(_ output: AVCapturePhotoOutput, didCapturePhotoFor resolvedSettings: AVCaptureResolvedPhotoSettings) {
        if isSilentModeOn {
            AudioServicesDisposeSystemSoundID(1108)
        }
    }
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let imageData = photo.fileDataRepresentation() else { return }
        print("[CameraModel]: Capture routine's done")

        self.photoData = imageData
        self.recentImage = UIImage(data: imageData)
        self.savePhoto(imageData)
        self.isCameraBusy = false
    }
}

//extension UIImage {
//    // 워터마크 오버레이 헬퍼 함수
//    func overlayWith(image: UIImage) -> UIImage {
//        let newSize = CGSize(width: size.width, height: size.height)
//        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
//
//        draw(in: CGRect(origin: CGPoint.zero, size: size))
//        image.draw(in: CGRect(origin: CGPoint(x: size.width - 200, y: size.height - 100), size: image.size))
//
//        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
//        UIGraphicsEndImageContext()
//
//        return newImage
//    }
//}





/* 추가된 기능 */
/* 사진을 특정 앨범에 저장하기 위한 함수 */
func saveImageToSpecificAlbum(image: UIImage, albumName: String) {
    // Check if album with name "Instagram" exists
    guard let album = getAlbumWithName(albumName) else {
        // If album does not exist, create it
        PHPhotoLibrary.shared().performChanges({
            PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: albumName)
        }, completionHandler: { (success, error) in
            if success {
                // If album is created successfully, save image to album
                if let album = getAlbumWithName(albumName) {
                    saveImageToAlbum(image: image, album: album)
                }
            } else {
                // Handle error
                print("Error creating album: \(error?.localizedDescription ?? "unknown error")")
            }
        })
        return
    }

    // If album already exists, save image to album
    saveImageToAlbum(image: image, album: album)
}

func getAlbumWithName(_ name: String) -> PHAssetCollection? {
    // Search for album with given name
    let fetchOptions = PHFetchOptions()
    fetchOptions.predicate = NSPredicate(format: "title = %@", name)
    let collections = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOptions)

    // Return first matching album
    return collections.firstObject
}

func saveImageToAlbum(image: UIImage, album: PHAssetCollection) {
    PHPhotoLibrary.shared().performChanges({
        let assetChangeRequest = PHAssetChangeRequest.creationRequestForAsset(from: image)
        let assetPlaceholder = assetChangeRequest.placeholderForCreatedAsset
        let albumChangeRequest = PHAssetCollectionChangeRequest(for: album)
        albumChangeRequest?.addAssets([assetPlaceholder] as NSFastEnumeration)
    }, completionHandler: { (success, error) in
        if success {
            // Handle success
            print("Image saved successfully to album: \(album.localizedTitle)")
        } else {
            // Handle error
            print("Error saving image to album: \(error?.localizedDescription ?? "unknown error")")
        }
    })
}

