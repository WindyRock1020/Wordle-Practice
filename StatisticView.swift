import SwiftUI

struct StatisticView: View {
    @ObservedObject var stat: WordleModel
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Guess Distribution").font(.headline)
            HStack{
                Text("W")
                ProgressBar(value: Float(self.stat.wrongTime), maxValue: 10)
                    .frame(height: 20)
                Text("\(self.stat.wrongTime)")
                    .frame(width: 20, alignment: .trailing)
            }
            ForEach(0..<stat.rightTime.count, id: \.self) { index in
                HStack {
                    Text("\(index + 1)")
                        .frame(width: 20, alignment: .leading)
                    ProgressBar(value: Float(self.stat.rightTime[index]), maxValue: Float(self.stat.rightTime.max() ?? 1))
                        .frame(height: 20)
                    Text("\(self.stat.rightTime[index])")
                        .frame(width: 20, alignment: .trailing)
                }
            }
        }
        .padding()
        .background(Color.black.opacity(0.8))
        .foregroundColor(.white)
        .cornerRadius(10)
    }
}

struct ProgressBar: View {
    var value: Float
    var maxValue: Float
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(Color(UIColor.systemTeal))
                
                Rectangle().frame(width: min(CGFloat(self.value)/CGFloat(self.maxValue) * geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(Color(UIColor.systemGreen))
                    .animation(.linear, value: value)
            }.cornerRadius(45.0)
        }
    }
}

