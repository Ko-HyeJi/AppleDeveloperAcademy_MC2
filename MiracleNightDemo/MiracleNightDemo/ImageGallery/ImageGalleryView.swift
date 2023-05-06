//
//  ImageGalleryView.swift
//  MiracleNightDemo
//
//  Created by 고혜지 on 2023/05/04.
//

import SwiftUI
import Photos

struct PhotoGridView: View {
    
    @State private var photos = [PHAsset]()
    
    var body: some View {
        let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
//            GridItem(.flexible())
        ]
        
        ScrollView {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(photos, id: \.self) { photo in
                    Image(uiImage: loadImage(for: photo))
                        .resizable()
                        .frame(width: 170, height: 170)
                        .scaledToFill()
//                        .scaledToFit()
//                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(10)
                        .rotationEffect(.init(degrees: 270))
                }
            }
            .padding()
        }
        .onAppear(perform: fetchPhotos)
    }
    
//    // 사진 정렬 Old -> New
//    private func fetchPhotos() {
//        let albumName = "MiracleNight" // 가져올 앨범 이름
//        let options = PHFetchOptions()
//        options.predicate = NSPredicate(format: "title = %@", albumName)
//        let albums = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: options)
//        if let album = albums.firstObject {
//            let assets = PHAsset.fetchAssets(in: album, options: nil)
//            assets.enumerateObjects { (object, count, stop) in
//                self.photos.append(object)
//            }
//        }
//    }

    //  사진 정렬 New -> Old
    private func fetchPhotos() {
        let albumName = "MiracleNight" // 가져올 앨범 이름
        let options = PHFetchOptions()
        options.predicate = NSPredicate(format: "title = %@", albumName)
        let albums = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: options)
        if let album = albums.firstObject {
            let assets = PHAsset.fetchAssets(in: album, options: nil)
            assets.enumerateObjects { (object, count, stop) in
                self.photos.insert(object, at: 0) // insert를 사용하여 배열의 맨 앞에 추가
            }
        }
    }
    
    private func loadImage(for asset: PHAsset) -> UIImage {
        let manager = PHImageManager.default()
        let options = PHImageRequestOptions()
        var thumbnail = UIImage()
        options.isSynchronous = true
        manager.requestImage(for: asset, targetSize: CGSize(width: 300, height: 300), contentMode: .aspectFit, options: options, resultHandler: {(result, info) -> Void in
            if let image = result {
                thumbnail = image
            }
        })
        return thumbnail
    }
}

extension PHAsset {
    
    private struct AssociatedKeys {
        static var image = "image"
    }
    
    var isPortrait: Bool {
        return self.pixelHeight > self.pixelWidth
    }
    
    var isLandscape: Bool {
        return self.pixelWidth > self.pixelHeight
    }
    
    var aspectRatio: CGFloat {
        return CGFloat(self.pixelWidth) / CGFloat(self.pixelHeight)
    }
    
    override open func isEqual(_ object: Any?) -> Bool {
        guard let asset = object as? PHAsset else {
            return false
        }
        return self.localIdentifier == asset.localIdentifier
    }
}
//
//struct ImageGalleryView_Preview: PreviewProvider {
//    static var previews: some View {
//        PhotoGridView()
//    }
//}
