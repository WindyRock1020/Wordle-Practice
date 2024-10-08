import SwiftUI

enum Global {
    static var screenWidth : CGFloat {
        UIScreen.main.bounds.size.width
    }
    static var screenHeight : CGFloat {
        UIScreen.main.bounds.size.height
    }   
    static var minDimensions : CGFloat {
        min(screenWidth, screenHeight)
    }
}
extension Color {
    static var wrong : Color {.black}
    static var misplaced : Color {.orange}
    static var correct : Color {.green}    
    static var unsued : Color {.gray}
    static var background : Color {.yellow}
}

enum AlertType {
    case win
    case lose
    case none
}
