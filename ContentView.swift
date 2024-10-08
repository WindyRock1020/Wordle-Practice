import SwiftUI
import UIKit

struct ContentView: View {
    @StateObject var wordle = WordleModel()
    var body: some View {
        wordleGame()
            .environmentObject(wordle)
    }
}
