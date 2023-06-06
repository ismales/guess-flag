//
//  ConfettiView.swift
//  GuessTheFlag
//
//  Created by Сманчос on 02.06.2023.
//

import SwiftUI
import Lottie

struct CofettieView: UIViewRepresentable {
    let name: String
    let loopMode: LottieLoopMode
    let animationSpeed: CGFloat
    let contentMode: UIView.ContentMode
    let animationView: LottieAnimationView

    @Binding var play: Bool

    init(name: String = "confetti",
         loopMode: LottieLoopMode = .playOnce,
         animationSpeed: CGFloat = 1.5,
         contentMode: UIView.ContentMode = .scaleAspectFit,
         play: Binding<Bool> = .constant(true)) {
        self.name = name
        self.animationView = LottieAnimationView(name: name)
        self.loopMode = loopMode
        self.animationSpeed = animationSpeed
        self.contentMode = contentMode
        self._play = play
    }

    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        view.addSubview(animationView)
        animationView.contentMode = contentMode
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        animationView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        animationView.loopMode = loopMode
        animationView.animationSpeed = animationSpeed
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        if play {
            animationView.play { _ in
                play = false
            }
        }
    }
}


struct LottieView_Previews: PreviewProvider {
    static var previews: some View {
        CofettieView()
    }
}
