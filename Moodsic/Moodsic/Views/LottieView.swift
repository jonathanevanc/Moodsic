//
//  LottieView.swift
//  Moodsic
//
//  Created by Jonathan Evan Christian on 22/05/23.
//

import SwiftUI
import Lottie

struct LottieViewComponent: UIViewRepresentable {
        
    let name: String
    let loopMode: LottieLoopMode
    
    func makeUIView(context: UIViewRepresentableContext<LottieViewComponent>) -> UIView {
        
        let view = UIView()
        
        let animationView = LottieAnimationView(name: name)
        animationView.loopMode = loopMode
        animationView.contentMode = .scaleAspectFit
        animationView.animationSpeed = 1
        animationView.contentScaleFactor = 1
        
        animationView.play(fromFrame: 0, toFrame: 120)
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
        
        return view
    }
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieViewComponent>) {}
}


struct LottieView_Previews: PreviewProvider {
    static var previews: some View {
        LottieViewComponent(name: "heartbeat", loopMode: .loop)
    }
}
