import SwiftUI

struct Tutorial: View {
    @State private var isOverlayVisible: Bool = true // TutorialOverlayの表示状態を管理

    var body: some View {
        ZStack {
            // メインのTutorial内容
            Text("Hello, World!")
                .font(.largeTitle)
                .padding()

            // オーバーレイ
            if isOverlayVisible {
                TutorialOverlay(isVisible: $isOverlayVisible)
            }
        }
    }
}

struct TutorialOverlay: View {
    @Binding var isVisible: Bool
    @State private var currentStep: Int = 0

    private let messages = [
        "地図の空いてる場所を長押ししてピンを立てられます！",
        "地図のアイコンをタップして観光地の情報を見てみて！",
        "おすすめスポットをピンで共有しよう！"
    ]
    private let images = ["Map_tutorial1", "Map_Tutorial3", "Detail_Tutorail"]

    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .edgesIgnoringSafeArea(.all)

            VStack {
                // 閉じるボタン
                HStack {
                    Spacer()
                    Button(action: {
                        withAnimation {
                            isVisible = false
                        }
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                    }
                    .padding()
                }

                Spacer()

                TabView(selection: $currentStep) {
                    ForEach(0..<messages.count, id: \.self) { index in
                        tutorialPage(index: index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
                .indexViewStyle(.page(backgroundDisplayMode: .always))
                .frame(height: 675)

                Spacer()
            }
        }
    }

    private func tutorialPage(index: Int) -> some View {
        VStack(spacing: 20) {
            ZStack {
                Image(images[index])
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(25)

                if index < 2 {
                    HoldAnimationView(lottieFile: "HoldAnimation")
                        .frame(width: 100, height: 100)
                        .offset(x: -30, y: 20)
                }

                Text(messages[index])
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black.opacity(0.8))
                    .cornerRadius(10)
                    .multilineTextAlignment(.center)
                    .padding()
                    .offset(y: -150)
            }
        }
        .frame(maxWidth: 325, maxHeight: 675)
        .background(Color.white)
        .cornerRadius(30)
        .padding()
    }
}
