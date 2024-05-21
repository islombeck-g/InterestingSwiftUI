//
//  ReadyTime1View.swift
//  InterestingSwiftUI
//
//  Created by Islombek Gofurov on 21/05/24.
//

import SwiftUI

#Preview {
    ReadyTime1View()
}

struct ReadyTime1View: View {
    @State private var loadingState: LoadingState = .preparing
    @StateObject private var progress = ReadyTimeViewModel1()
    @State private var rotationAngle: Angle = .zero
    @State var rotationAngle2: Double = 0
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .trim(from: 0.0, to: CGFloat(progress.downloadProgres))
                    .stroke(.yellow, style: StrokeStyle(lineWidth: 2, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                Circle()
                    .trim(from: progress.backProgress, to: CGFloat(progress.loadProgress))
                    .stroke(.yellow, style: StrokeStyle(lineWidth: 2, lineCap: .round))
                    .rotationEffect(.degrees(-90))
            }
            .rotationEffect(.degrees(rotationAngle2))
            .animation(.linear(duration: 2.0).repeatForever(autoreverses: false), value: rotationAngle2)
            .task {
                rotationAngle2 = 360
            }
            Text("ReadyTime1View")
            Grid {
                GridRow {
                    Button {
                        progress.increase()
                    } label: {
                        Image(systemName: "plus")
                    }
                    .buttonStyle(BorderedButtonStyle())
                    Text("\(progress.downloadProgres.formatted())")
                    Button {
                        progress.decrease()
                    } label: {
                        Image(systemName: "minus")
                    }
                    .buttonStyle(BorderedButtonStyle())
                }
                .frame(width: 40)
            }
            .padding(.top, 40)
        }
        .padding(.horizontal)
//        .frame(height: 130)
        
        
        .onAppear {
            progress.toggleLoading(interval: 0.01)
        }
        .onTapGesture {
            toggleLoadingState()
        }
    }
    
    private func toggleLoadingState() {
        if loadingState == .preparing {
            loadingState = .loading
            progress.stopLoading()
            progress.toggleLoading(interval: 0.1)
            startRotating()
        } else {
            loadingState = .preparing
            progress.stopLoading()
            progress.toggleLoading(interval: 0.02)
        }
    }
    
    private func startRotating() {
        withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)) {
            rotationAngle = .degrees(360)
        }
    }
}

class ReadyTimeViewModel1: ObservableObject {
    @Published var loadProgress = 0.0
    @Published var backProgress = 1.0
    @Published var isLoading = false
    @Published var downloadProgres = 0.0
    
    let maxProgress = 1.1
    var timer: Timer?
    private var timeDelay = false
    
    func startLoading(interval: TimeInterval = 0.1, backProgressEnabled: Bool = false) {
        isLoading = true
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            
            if self.loadProgress < self.maxProgress {
                withAnimation(.easeInOut) {
                    self.loadProgress += 0.01
                }
            } else if self.backProgress < self.loadProgress {
                withAnimation(.easeInOut) {
                    self.backProgress += 0.01
                }
            } else {
                let delay = downloadProgres * interval * 100
                DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                    self.loadProgress = 0.0
                    self.backProgress = 0.0
                }
            }
        }
    }
    
    func stopLoading() {
        isLoading = false
        timer?.invalidate()
        timer = nil
    }
    
    func toggleLoading(interval: TimeInterval = 0.1, backProgressEnabled: Bool = false) {
        if isLoading {
            stopLoading()
        } else {
            startLoading(interval: interval, backProgressEnabled: backProgressEnabled)
        }
    }
    
    func increase() {
        if downloadProgres < 0.85 {
            downloadProgres += 0.15
        } else {
            downloadProgres = 1.0
        }
        loadProgress = downloadProgres
        backProgress = downloadProgres
    }
    
    func decrease() {
        if downloadProgres >= 0.15 {
            downloadProgres -= 0.15
        } else {
            downloadProgres = 0.0
        }
        loadProgress = downloadProgres
        backProgress = downloadProgres
    }
}

