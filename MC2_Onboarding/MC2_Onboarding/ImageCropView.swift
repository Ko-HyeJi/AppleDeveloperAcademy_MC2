//
//  ImageCropView.swift
//  MC2_Onboarding
//
//  Created by 유빈 on 2023/05/10.
//

import SwiftUI

struct ImageCropView: View {
    @State private var location: CGPoint = CGPoint(x: 200, y: 250)
    @GestureState private var fingerLocation: CGPoint? = nil
    @GestureState private var startLocation: CGPoint? = nil
    
    var simpleDrag: some Gesture {
        DragGesture()
            .onChanged { value in
                var newLocation = startLocation ?? location
                newLocation.x += value.translation.width
                newLocation.y += value.translation.height
                self.location = newLocation
            }.updating($startLocation) { (value, startLocation, transaction) in
                startLocation = startLocation ?? location
            }
    }
    
    var fingerDrag: some Gesture {
        DragGesture()
            .updating($fingerLocation) { (value, fingerLocation, transaction) in
                fingerLocation = value.location
            }
    }
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.blue)
                    .frame(width: 200, height: 200)
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.pink)
                    .frame(width: 200, height: 200)
                    .position(location)
                    .gesture(
                        simpleDrag.simultaneously(with: fingerDrag)
                    )
                if let fingerLocation = fingerLocation {
                    Circle()
                        .stroke(Color.white, lineWidth: 4)
                        .frame(width: 80, height: 80)
                        .position(fingerLocation)
                }
            }
            .frame(width: 300, height: 300)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ImageCropView_Previews: PreviewProvider {
    static var previews: some View {
        ImageCropView()
    }
}
