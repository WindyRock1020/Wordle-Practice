import SwiftUI

struct wordleGame : View {
    @EnvironmentObject var dm : WordleModel
    @State private var showHelp = false
    @State private var statistic = false
    var body: some View {
        NavigationView {
            ZStack {
                Color.black
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Spacer()
                    VStack(spacing: 3) {
                        ForEach(0...5, id: \.self) { index in
                            GuessView(guess: $dm.guesses[index])     
                        }
                    }
                    .frame(width: 275, height: 320)
                    Keyboard()
                        .scaleEffect(0.8)
                        .padding(.bottom)
                    Spacer()
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        HStack (spacing: 1) {
                            Button {
                                showHelp = true
                            } label : {
                                Image(systemName: "questionmark.circle")
                            }
                        }
                        .foregroundColor(.white)
                    }
                    ToolbarItem(placement: .principal) {
                        Text("Wordle")
                            .font(.title)
                            .bold()
                            .foregroundColor(.white)
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        HStack(spacing: 2) {
                            Button{
                                dm.newGame()
                            }label: {
                                Image(systemName: "gobackward")
                            }
                            Button {
                                statistic = true
                            } label : {
                                Image(systemName: "chart.bar.fill")
                            }
                        }
                        .foregroundColor(.white)
                    }
                }
            }
            .sheet(isPresented: $showHelp) {
                Image("Help")
                    .resizable()
                    .scaledToFit()
            }
            .sheet(isPresented: $statistic){
                StatisticView(stat: dm)
            }
        }
        .alert(isPresented: Binding<Bool>(
            get: {dm.alertType != .none},
            set: {_ in dm.alertType = .none}
        )){
            switch dm.alertType {
            case .win:
                return Alert(
                    title: Text("恭喜你猜中了"),
                    message: Text(dm.gameResultMessage),
                    dismissButton: .default(Text("重新開始")){
                        dm.newGame()
                    }
                )
            case .lose:
                return Alert(
                    title: Text("Game Over"),
                    message: Text(dm.gameResultMessage),
                    dismissButton: .default(Text("重新開始")){
                        dm.newGame()
                    }
                )
            case .none:
                return Alert(title:Text(""))
            }
        }
    }
}
