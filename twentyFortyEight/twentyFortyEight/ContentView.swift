//
//  ContentView.swift
//  twentyFortyEight
//
//  Created by Александра on 01.04.2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            GameBoardView()
                .navigationTitle("2048")
        }
    }
}

#Preview {
    ContentView()
}
