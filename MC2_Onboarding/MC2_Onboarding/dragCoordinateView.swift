//
//  dragCoordinateView.swift
//  MC2_Onboarding
//
//  Created by 유빈 on 2023/05/10.
//

import SwiftUI

struct dragCoordinateView: View {
    @State private var cardPosition = CGPoint(x: 100, y: 100)
        @State private var cardCoordString = "100, 100"
        
        // drag gesture props
        @State private var touchLocation = CGPoint(x: 0, y: 0)
        @State private var translationValue = CGSize(width: 0, height: 0)
        @State private var startLocationValue = CGPoint(x: 0, y: 0)
        @State private var predictedEndLocationValue = CGPoint(x: 0, y: 0)
        @State private var predictedEndTranslation = CGSize(width: 0, height: 0)
        
        var body: some View {
            ZStack(alignment: .bottomTrailing) {
                VStack {
                    Text("현재 위치")
                        .font(.largeTitle)
                    Text("\(cardCoordString)")
                }
                .frame(width: 200, height: 100)
                .background(Color.orange, in: RoundedRectangle(cornerRadius: 10))
                .position(cardPosition)
                .gesture(DragGesture().onChanged({ newValue in
                    self.cardPosition = newValue.location
                    self.cardCoordString = "\(Int(newValue.location.x)), \(Int(newValue.location.y))"
                    
                    // drag gesture prop
                    touchLocation = newValue.location
                    translationValue = newValue.translation
                    startLocationValue = newValue.startLocation
                    predictedEndLocationValue = newValue.predictedEndLocation
                    predictedEndTranslation = newValue.predictedEndTranslation
                }))
                
                VStack(alignment: .leading) {
                    Text("TouchLocation: \(touchLocation.x), \(touchLocation.y)")
                    Text("TranslationValue: \(translationValue.width), \(translationValue.height)")
                    Text("StartLocationValue: \(startLocationValue.x), \(startLocationValue.y)")
                    Text("PredictedEndLocationValye: \(predictedEndLocationValue.x), \(predictedEndLocationValue.y)")
                    Text("PredictedEndTranslation: \(predictedEndTranslation.width), \(predictedEndTranslation.height)")
                }
                .font(.callout)
            }
        }
}

struct dragCoordinateView_Previews: PreviewProvider {
    static var previews: some View {
        dragCoordinateView()
    }
}
