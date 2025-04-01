//
//  TileView.swift
//  twentyFortyEight
//
//  Created by Александра on 01.04.2025.
//

import SwiftUI

struct TileView: View {
    let value: Int
    
    private var backgroundColor: Color {
        switch value {
        //case 0: return Color(.systemGray5)
        case 0: return Color.theme.backgroundGameFrame
        case 2: return Color.colorTwo
        case 4: return Color.theme.colorFour
        case 8: return Color.theme.colorEight
        case 16: return Color.theme.colorSixteen
        case 32: return Color.theme.colorThirtyTwo
        case 64: return Color.theme.colorSixtyFour
        case 128: return Color.theme.colorOneHTwentyEight
        case 256: return Color.theme.colorTwoHFiftySix
        case 512: return Color.theme.colorFiveHTwelve
        case 1024: return Color.theme.colorTenTwentyFour
        case 2048: return Color.theme.colorTwentyFortyEight
        case 4096: return Color.theme.colorFortyNintySix
        case 8192: return Color.theme.colorEightyOneNintyTwo
        default: return Color.theme.colorDefault
        }
    }
    
    private var textColor: Color {
        value <= 4 ? Color.theme.colorTextBlack : Color.theme.colorTextWhite
    }
    
    private var fontSize: CGFloat {
        switch value {
        case 2, 4, 8, 16, 32, 64, 128, 256, 512: return 32
        case 1024, 2048: return 24
        default: return 20
        }
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(backgroundColor)
                .shadow(radius: 2)
            
            if value != 0 {
                Text("\(value)")
                    .font(.system(size: fontSize, weight: .bold))
                    .foregroundColor(textColor)
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .animation(.easeInOut(duration: 0.2), value: value)
    }
}

#Preview {
    TileView(value: 2048)
        .frame(width: 80, height: 80)
        .padding()
} 
