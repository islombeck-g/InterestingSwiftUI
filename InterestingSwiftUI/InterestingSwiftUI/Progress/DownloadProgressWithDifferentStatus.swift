////
////  downloadProgressWithDifferentStatus.swift
////  InterestingSwiftUI
////
////  Created by Islombek Gofurov on 21/05/24.
////
//
//import SwiftUI
//
//#Preview {
////    DownloadProgressWithDifferentStatus()
//////    DownloadProgressWithDifferentStatusViewModel
//}
//
//import SwiftUI
//import Combine
//
//class DownloadProgressWithDifferentStatusViewModel: ObservableObject {
//    @Published var loadProgress = 0.0
//    @Published var backProgress = 0.0
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
//            } else {
//                self.loadProgress = 0.0
//            }
//            
//            if backProgressEnabled {
//                if self.backProgress < self.downloadProgres {
//                    withAnimation {
//                        self.backProgress += 0.01
//                    }
//                } else {
//                    self.backProgress = self.downloadProgres
//                }
//            } else {
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
//
//struct DownloadProgressWithDifferentStatus: View {
//    @State private var loadingState: LoadingState = .preparing
//    @StateObject private var progress = DownloadProgressWithDifferentStatusViewModel()
//    @State private var rotationAngle: Angle = .zero
//    @State var rotationAngle2: Double = 0
//    
//    var body: some View {
//        VStack {
//            ZStack {
//                Circle()
//                    .trim(from: 0, to: CGFloat(progress.downloadProgres))
//                    .stroke(Color.gray.opacity(0.3), style: StrokeStyle(lineWidth: 2, lineCap: .round))
//                    .rotationEffect(.degrees(-90))
//                
//                Circle()
//                    .trim(from: 0, to: CGFloat(progress.loadProgress))
//                    .stroke(Color.yellow, style: StrokeStyle(lineWidth: 2, lineCap: .round))
//                    .rotationEffect(.degrees(-90))
//            }
//        }
//        .frame(height: 130)
//        Grid {
//            GridRow {
//                Button {
//                    progress.increase()
//                } label: {
//                    Image(systemName: "plus")
//                }
//                .buttonStyle(BorderedButtonStyle())
//                Text("\(progress.downloadProgres.formatted())")
//                Button {
//                    progress.decrease()
//                } label: {
//                    Image(systemName: "minus")
//                }
//                .buttonStyle(BorderedButtonStyle())
//            }
//            .frame(width: 40)
//        }
//        .padding(.top, 40)
//        
//        .onAppear {
//            progress.toggleLoading(interval: 0.01, backProgressEnabled: true)
//        }
//        .onTapGesture {
//            toggleLoadingState()
//        }
//    }
//    
//    private func toggleLoadingState() {
//        if loadingState == .preparing {
//            loadingState = .loading
//            progress.stopLoading()
//            progress.toggleLoading(interval: 0.1, backProgressEnabled: true)
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
