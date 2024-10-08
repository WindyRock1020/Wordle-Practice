import SwiftUI

struct LetterButtonView : View {
    @EnvironmentObject var dm : WordleModel
    var letter : String
    var body : some View {
        Button {
            dm.addToCurrentWord(letter)
        } label : {
            Text(letter)
                .font(.system(size: 25))
                .frame(width: 40, height: 55)
                .background(dm.keyColours[letter])
                .foregroundColor(.primary)
                .border(Color.gray)
                .cornerRadius(5.0)
        }
        .buttonStyle(.plain)
    }
}
