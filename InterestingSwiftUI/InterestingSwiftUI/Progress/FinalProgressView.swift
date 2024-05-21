//
//  FinalProgressView.swift
//  InterestingSwiftUI
//
//  Created by Islombek Gofurov on 20/05/24.
//

import SwiftUI
import Combine
//#Preview {
//    //    FinalProgressView()
////    CombinedFocuseView()
//}

struct C: View {
    @State private var moveDown = false
    @State private var opacity: Double = 1.0
    
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "arrow.down")
                .resizable()
                .frame(width: 8, height: 8)
                .foregroundStyle(.yellow)
                .opacity(opacity)
                .offset(y: moveDown ? 5 : -6)
                .onAppear {
                    withAnimation(Animation.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                        self.opacity = 0.0
                        self.moveDown.toggle()
                    }
                }
            
            Spacer()
        }
    }
}
struct FinalProgressView: View {
    @State private var arrowOffset: CGFloat = -8
    @State private var arrowOpacity: Double = 0.0
    
    var body: some View {
        HStack {
            Image("folderTemplate")
            VStack(alignment: .leading, spacing: .zero) {
                Text("Some interesting text")
                C()
                Spacer()
            }
            Spacer()
//            CombinedFocuseView()
//                .frame(width: 30)
        }
        .frame(height: 50)
        .padding(.horizontal)
    }
    
    private func startArrowAnimation() {
        withAnimation(Animation.linear(duration: 1).repeatForever(autoreverses: false)) {
            arrowOffset = 8
            arrowOpacity = 1.0
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation(Animation.linear(duration: 1).repeatForever(autoreverses: false)) {
                arrowOffset = 16
                arrowOpacity = 0.0
            }
        }
    }
}

//-----------------------_





enum LoadingState {
    case preparing
    case loading
}

//------------------------


//test1
//class ProgressViewModel: ObservableObject {
//    @Published var loadProgress = 0.0
//    @Published var backProgress = 1.0
//    @Published var isLoading = false
//    @Published var downloadProgres = 0.0
//
//    let maxProgress = 1.1
//    var timer: Timer?
//
//    func startLoading(interval: TimeInterval = 0.1, backProgressEnabled: Bool = false) {
//        isLoading = true
//        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [weak self] _ in
//            guard let self = self else { return }
//
//            if self.loadProgress < self.maxProgress {
//                withAnimation {
//                    self.loadProgress += 0.01
//                }
//            } else if self.backProgress < self.loadProgress + self.downloadProgres {
//                withAnimation {
//                    self.backProgress += 0.01
//                }
//            } else {
//                self.loadProgress = self.downloadProgres
//                self.backProgress = self.downloadProgres
//            }
//        }
//    }
//
//    func stopLoading() {
//        isLoading = false
//        timer?.invalidate()
//        timer = nil
//    }
//
//    func toggleLoading(interval: TimeInterval = 0.1, backProgressEnabled: Bool = false) {
//        if isLoading {
//            stopLoading()
//        } else {
//            startLoading(interval: interval, backProgressEnabled: backProgressEnabled)
//        }
//    }
//
//    func increase() {
//        if downloadProgres < 0.85 {
//            downloadProgres += 0.15
//        } else {
//            downloadProgres = 1.0
//        }
//        loadProgress = downloadProgres
//        backProgress = downloadProgres
//    }
//
//    func decrease() {
//        if downloadProgres >= 0.15 {
//            downloadProgres -= 0.15
//        } else {
//            downloadProgres = 0.0
//        }
//        loadProgress = downloadProgres
//        backProgress = downloadProgres
//    }
//}


























//struct CombinedFocuseView: View {
//    @State private var loadingState: LoadingState = .preparing
//    @StateObject private var progress = ProgressViewModel()
//    @State private var rotationAngle: Angle = .zero
//
//    var body: some View {
//        VStack {
//            ZStack {
//                Circle()
//                    .trim(from: 0, to: CGFloat(progress.maxProgress))
//                    .stroke(loadingState == .preparing ? .gray : Color.black.opacity(0.09), style: StrokeStyle(lineWidth: 4, lineCap: .round))
//
//                Circle()
//                    .trim(from: 0, to: CGFloat(progress.loadProgress))
//                    .stroke(.yellow, style: StrokeStyle(lineWidth: 4, lineCap: .round))
//                    .rotationEffect(loadingState == .preparing ? .degrees(-90) : rotationAngle)
//
//                if loadingState == .preparing {
//                    Circle()
//                        .trim(from: 0, to: CGFloat(progress.backProgress))
//                        .stroke(.gray, style: StrokeStyle(lineWidth: 4, lineCap: .round))
//                        .rotationEffect(.degrees(-90))
//                }
//            }
//            .padding(.horizontal)
//
//            Text("Time: \(progress.loadProgress, specifier: "%.2f")/\(progress.maxProgress, specifier: "%.0f")")
//                .padding(.top)
//
//            Grid {
//                GridRow {
//                    Button {
//                        progress.toggleLoading(interval: loadingState == .preparing ? 0.02 : 0.1, backProgressEnabled: loadingState == .preparing)
//                        if loadingState == .loading {
//                            startRotating()
//                        }
//                    } label: {
//                        Image(systemName: progress.isLoading ? "pause.fill" : "play.fill")
//                    }
//                    .buttonStyle(BorderedButtonStyle())
//
//                    Button {
//                        progress.resetProgress()
//                    } label: {
//                        Image(systemName: "arrow.counterclockwise")
//                    }
//                    .buttonStyle(BorderedButtonStyle())
//                }
//            }
//
//            Button(action: {
//                toggleLoadingState()
//            }) {
//                Text("Toggle Loading State")
//            }
//            .padding()
//        }
//        .background(.red)
//        .frame(height: 30)
//        .onAppear {
//            progress.toggleLoading(interval: 0.02, backProgressEnabled: true)
//        }
//    }
//
//    private func toggleLoadingState() {
//        if loadingState == .preparing {
//            loadingState = .loading
//            progress.stopLoading()
//            progress.toggleLoading(interval: 0.1, backProgressEnabled: false)
//            startRotating()
//        } else {
//            loadingState = .preparing
//            progress.stopLoading()
//            progress.toggleLoading(interval: 0.02, backProgressEnabled: true)
//        }
//    }
//
//    private func startRotating() {
//        withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)) {
//            rotationAngle = .degrees(360)
//        }
//    }
//}

//class ProgressViewModel1: ObservableObject {
//    @Published var loadProgress = 0.0
//    @Published var backProgress = 1.0
//    @Published var isLoading = false
//    @Published var downloadProgres = 0.0
//
//    let maxProgress = 1.1
//    var timer: Timer?
//
//    func startLoading(interval: TimeInterval = 0.1, backProgressEnabled: Bool = false) {
//        isLoading = true
//        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [weak self] _ in
//            guard let self = self else { return }
//
//            if self.loadProgress < self.maxProgress {
//                withAnimation {
//                    self.loadProgress += 0.01
//                }
//            } else if self.backProgress < self.loadProgress {
//                withAnimation {
//                    self.backProgress += 0.01
//                }
//            } else {
//                self.loadProgress = 0.0
//                self.backProgress = 0.0
//            }
//        }
//    }
//
//    func stopLoading() {
//        isLoading = false
//        timer?.invalidate()
//        timer = nil
//    }
//
//    func toggleLoading(interval: TimeInterval = 0.1, backProgressEnabled: Bool = false) {
//        if isLoading {
//            stopLoading()
//        } else {
//            startLoading(interval: interval, backProgressEnabled: backProgressEnabled)
//        }
//    }
//
//    func increase() {
//        if downloadProgres < 0.85 {
//            downloadProgres += 0.15
//        } else {
//            downloadProgres = 1.0
//        }
//    }
//    func decrease() {
//        if downloadProgres >= 0.15 {
//            downloadProgres -= 0.15
//        } else {
//            downloadProgres = 0.0
//        }
//    }
//}



//            .rotationEffect(.degrees(rotationAngle2))
//            .animation(.linear(duration: 2.0).repeatForever(autoreverses: false), value: rotationAngle2)
//            .task {
//                rotationAngle2 = 360
//            }

