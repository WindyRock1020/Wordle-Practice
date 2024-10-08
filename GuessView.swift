import SwiftUI

struct Guess { 
    let index:Int
    var word = "     "
    var bgColors = [Color](repeating: .black, count: 5)
    var letterFlipped = [Bool](repeating: false, count: 5)
    var guessLetters : [String] {
        word.map{String($0)}
    }
}

struct GuessView : View {
    @Binding var guess : Guess
    var body : some View {
        HStack (spacing: 3) { 
            ForEach(0...4, id: \.self) { index in
                Text(guess.guessLetters[index])
                    .foregroundColor(.primary)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                    .font(.system(size: 35, weight: .heavy))
                    .background(guess.bgColors[index])
                    .border(Color.secondary)
            }
        }
    }
}
