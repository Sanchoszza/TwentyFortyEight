//
//  Color.swift
//  twentyFortyEight
//
//  Created by Александра Згонникова on 01.04.2025.
//

import Foundation
import SwiftUI

extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme {
    /// color for background game frame
    let backgroundGameFrame = Color("backgroundGameFrame")
    
    /// colors for items 2..8192
    let colorEmpty = Color("colorEmpty")
    let colorDefault = Color("colorDefault")
    let colorEight = Color("colorEight")
    let colorEightyOneNintyTwo = Color("colorEightyOneNintyTwo")
    let colorFiveHTwelve = Color("colorFiveHTwelve")
    let colorFortyNintySix = Color("colorFortyNintySix")
    let colorFour = Color("colorFour")
    let colorOneHTwentyEight = Color("colorOneHTwentyEight")
    let colorSixteen = Color("colorSixteen")
    let colorSixtyFour = Color("colorSixtyFour")
    let colorTenTwentyFour = Color("colorTenTwentyFour")
    let colorThirtyTwo = Color("colorThirtyTwo")
    let colorTwentyFortyEight = Color("colorTwentyFortyEight")
    let colorTwo = Color("colorTwo")
    let colorTwoHFiftySix = Color("colorTwoHFiftySix")
    
    /// colors for button and text
    let colorButtonBg = Color("colorButtonBg")
    let colorTextBlack = Color("colorTextBlack")
    let colorTextWhite = Color("colorTextWhite")
}
