//
//  CardView.swift
//  Flashzilla
//
//  Created by Михаил Тихомиров on 13.09.2023.
//

import SwiftUI

struct CardView: View {
    let card: Card
    
//    var isReinsertWrongAnswers:Bool
    // MARK: Challenge 3.1
    var removal: ((_ correct:Bool) -> Void)? = nil // this thing should be here after let Card !
    
    
    @State private var feedback = UINotificationFeedbackGenerator()
    
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor // to show users right or wrong dirrections
    @Environment (\.accessibilityVoiceOverEnabled) var voiceOverEnabled
    @State private var isShowingAnswer = false
    @State private var offset = CGSize.zero
    
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(
                    differentiateWithoutColor                           // for the color blind people
                    ? .white
                    : .white.opacity(1 - Double(abs(offset.width / 50)))   // that`s a nice effect
                )
                .background(
                    differentiateWithoutColor
                    ? nil
                    : RoundedRectangle(cornerRadius: 25, style: .continuous) //
                        .fill(setColor(for: offset.width))
                )
                .shadow(radius: 10)
            
            VStack {
                if voiceOverEnabled {  // we do so because voice over now can read this correctly instead of two texts bellow
                    Text(isShowingAnswer ? card.answer : card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                } else {
                    Text(card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                    if isShowingAnswer {
                        Text(card.answer)
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding()
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(Double(offset.width / 5)))
        .offset(x: offset.width * 5, y: 0)   // so move our card left or right but not up and down
        .opacity(2 - Double(abs(offset.width / 50))) // this allows the card to stay opaque when it`s being dragged a small way.
        .accessibilityAddTraits(.isButton) // it says for users with voice over that the card is a button
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                    feedback.prepare()
                }
                .onEnded { _ in
                    
                    if abs(offset.width) > 100 {

                        if offset.width > 0 {
                            // here we say if they new the naswer then
                            feedback.notificationOccurred(.success)
                        } else {
                            feedback.notificationOccurred(.error)
                        }
                        // remove the card
                        // MARK: Challenge 3.2
                        removal?(offset.width > 0)
                        
                    } else {
                        offset = .zero
                    }
                }
        )
        .onTapGesture {
            isShowingAnswer.toggle()
        }
        .animation(.spring(), value: offset) // to smooth our drag gesture when we release our card
    
    }
    
    func setColor(for offset: CGFloat) -> Color {
        switch offset {
        case let a where a > 0:
            return .green
        case let b where b < 0:
            return .red
        default:
            return .white
        }
    }
        
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card.example)
    }
}
