//
//  GradientBackgroundView.swift
//  Oshinoko
//
//  Created by 櫻井絵理香 on 2024/11/19.
//

import SwiftUI

import SwiftUI

struct BackgroundModifier: ViewModifier {
    let colors: [Color]
    let blurRadius: CGFloat
    let opacity: Double

    func body(content: Content) -> some View {
        ZStack {
            // グラデーション背景
            LinearGradient(
                gradient: Gradient(colors: colors),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            // 半透明のガラスレイヤー
            Color.white
                .opacity(opacity)
                .blur(radius: blurRadius)
                .ignoresSafeArea()

            content // コンテンツのレイヤー
        }
    }
}

// MARK: - View拡張
extension View {
    func glassmorphismBackground(
        colors: [Color],
        blurRadius: CGFloat = 20,
        opacity: Double = 0.25
    ) -> some View {
        self.modifier(BackgroundModifier(colors: colors, blurRadius: blurRadius, opacity: opacity))
    }
}

// MARK: - Hexカラーコードを使うための便利な拡張
extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.currentIndex = hex.startIndex

        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)

        let red = Double((rgbValue >> 16) & 0xFF) / 255.0
        let green = Double((rgbValue >> 8) & 0xFF) / 255.0
        let blue = Double(rgbValue & 0xFF) / 255.0

        self.init(red: red, green: green, blue: blue)
    }
}

