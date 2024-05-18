//
//  DownloadProgressView.swift
//  InterestingSwiftUI
//
//  Created by Islombek Gofurov on 18/05/24.
//

import SwiftUI

struct DownloadProgressView: View {
    private let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    @State private var scrollViewProxy: ScrollViewProxy? = nil
    @State private var isAtBottom: Bool = false
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView{
                LazyVGrid(columns: columns, spacing: 40) {
                    FocuseView()
                    FocuseView1()
                    FocuseView2()
                    FocuseView3()
                    FocuseView4()
                }
                .onAppear {
                    scrollViewProxy = proxy
                }
                .background(GeometryReader { geo -> Color in
                    let offsetY = geo.frame(in: .global).maxY
                    DispatchQueue.main.async {
                        if !isAtBottom {
                            scrollViewProxy?.scrollTo("bottom", anchor: .bottom)
                            isAtBottom = true
                        }
                    }
                    return Color.clear
                })
                .id("bottom")
            }
        }
    }
}


#Preview {
    DownloadProgressView()
}

struct FocuseView: View {
    @StateObject var progress = ProgressForProgressView()
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .trim(from: 0, to: CGFloat(progress.maxProgress))
                    .stroke(Color.black.opacity(0.09), style: StrokeStyle(lineWidth: 4, lineCap: .round))
                Text("FocuseView")
                Circle()
                    .trim(from: 0, to: CGFloat(progress.loadProgress))
                    .stroke(.black, style: StrokeStyle(lineWidth: 4, lineCap: .round))
                    .rotationEffect(.degrees(progress.isLoading ? 360 : 0))
                    .animation(Animation.linear(duration: 2).repeatForever(autoreverses: false), value: progress.isLoading)
            }
            .padding(.horizontal)
            Text("Time: \(progress.loadProgress, specifier: "%.2f")/\(progress.maxProgress, specifier: "%.0f")")
                .padding(.top)
            Grid {
                GridRow {
                    Button {
                        progress.toggleLoading()
                    } label: {
                        Image(systemName: progress.isLoading ? "pause.fill" : "play.fill")
                    }
                    .buttonStyle(BorderedButtonStyle())
                    Button {
                        progress.loadProgress = 0
                    } label: {
                        Image(systemName: "arrow.counterclockwise")
                    }
                    .buttonStyle(BorderedButtonStyle())
                }
            }
            
        }
        .onAppear {
            progress.toggleLoading()
        }
    }
}

struct FocuseView1: View {
    @StateObject var progress = ProgressForProgressView()
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .trim(from: 0, to: CGFloat(progress.maxProgress))
                    .stroke(Color.black.opacity(0.09), style: StrokeStyle(lineWidth: 4, lineCap: .round))
                Text("FocuseView1")
                Circle()
                    .trim(from: 0, to: CGFloat(progress.loadProgress))
                    .stroke(.black, style: StrokeStyle(lineWidth: 4, lineCap: .round))
            }
            .padding(.horizontal)
            Text("Time: \(progress.loadProgress, specifier: "%.2f")/\(progress.maxProgress, specifier: "%.0f")")
                .padding(.top)
            Grid {
                GridRow {
                    Button {
                        progress.toggleLoading()
                    } label: {
                        Image(systemName: progress.isLoading ? "pause.fill" : "play.fill")
                    }
                    .buttonStyle(BorderedButtonStyle())
                    Button {
                        progress.loadProgress = 0
                    } label: {
                        Image(systemName: "arrow.counterclockwise")
                    }
                    .buttonStyle(BorderedButtonStyle())
                }
            }
        }
        .onAppear {
            progress.toggleLoading()
        }
    }
}

struct FocuseView2: View {
    @StateObject var progress = ProgressForProgressView()
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .stroke(Color.black.opacity(0.09), style: StrokeStyle(lineWidth: 4, lineCap: .round))
                
                // Left half progress
                Circle()
                    .trim(from: 0.5 - (CGFloat(progress.loadProgress) / CGFloat(progress.maxProgress) / 2), to: 0.5)
                    .stroke(.black, style: StrokeStyle(lineWidth: 4, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                
                // Right half progress
                Circle()
                    .trim(from: 0.5, to: 0.5 + (CGFloat(progress.loadProgress) / CGFloat(progress.maxProgress) / 2))
                    .stroke(.red, style: StrokeStyle(lineWidth: 4, lineCap: .round))
                    .rotationEffect(.degrees(-90))
            }
            .padding(.horizontal)
            
            Text("Time: \(progress.loadProgress, specifier: "%.2f")/\(progress.maxProgress, specifier: "%.0f")")
                .padding(.top)
            
            Grid {
                GridRow {
                    Button {
                        progress.toggleLoading()
                    } label: {
                        Image(systemName: progress.isLoading ? "pause.fill" : "play.fill")
                    }
                    .buttonStyle(BorderedButtonStyle())
                    
                    Button {
                        progress.loadProgress = 0
                    } label: {
                        Image(systemName: "arrow.counterclockwise")
                    }
                    .buttonStyle(BorderedButtonStyle())
                }
            }
        }
        .onAppear {
            progress.toggleLoading()
        }
    }
}

struct FocuseView3: View {
    @StateObject var progress = ProgressForProgressView()
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .trim(from: 0, to: CGFloat(progress.maxProgress))
                    .stroke(Color.black.opacity(0.09), style: StrokeStyle(lineWidth: 4, lineCap: .round))
                Text("FocuseView3")
                Circle()
                    .trim(from: 0, to: CGFloat(progress.loadProgress))
                    .stroke(.black, style: StrokeStyle(lineWidth: 4, lineCap: .round))
                    .rotationEffect(.degrees(-90))
            }
            .padding(.horizontal)
            Text("Time: \(progress.loadProgress, specifier: "%.2f")/\(progress.maxProgress, specifier: "%.0f")")
                .padding(.top)
            Grid {
                GridRow {
                    Button {
                        progress.toggleLoading()
                    } label: {
                        Image(systemName: progress.isLoading ? "pause.fill" : "play.fill")
                    }
                    .buttonStyle(BorderedButtonStyle())
                    Button {
                        progress.loadProgress = 0
                    } label: {
                        Image(systemName: "arrow.counterclockwise")
                    }
                    .buttonStyle(BorderedButtonStyle())
                }
            }
        }
        .onAppear {
            progress.toggleLoading()
        }
    }
}

struct FocuseView4: View {
    @StateObject var progress = ProgressForProgressView()
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .stroke(Color.black.opacity(0.09), style: StrokeStyle(lineWidth: 4, lineCap: .round))
                
                // Основной круг для заполнения
                Circle()
                    .trim(from: 0, to: CGFloat(progress.loadProgress) / CGFloat(progress.maxProgress))
                    .stroke(.black, style: StrokeStyle(lineWidth: 4, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                
                // Круг для создания иллюзии заполнения в обратном направлении
                Circle()
                    .stroke(Color.black.opacity(0), style: StrokeStyle(lineWidth: 4, lineCap: .round)) // Сделаем его невидимым
                    .overlay(
                        Circle()
                            .trim(from: 0, to: CGFloat(progress.loadProgress) / CGFloat(progress.maxProgress))
                            .stroke(.black, style: StrokeStyle(lineWidth: 4, lineCap: .round))
                    )
                    .rotationEffect(.degrees(-90 - (progress.loadProgress / progress.maxProgress) * 180)) // Поворачиваем в обратном направлении
            }
            .padding(.horizontal)
            
            Text("Time: \(progress.loadProgress, specifier: "%.2f")/\(progress.maxProgress, specifier: "%.0f")")
                .padding(.top)
            
            Grid {
                GridRow {
                    Button {
                        progress.toggleLoading()
                    } label: {
                        Image(systemName: progress.isLoading ? "pause.fill" : "play.fill")
                    }
                    .buttonStyle(BorderedButtonStyle())
                    
                    Button {
                        progress.loadProgress = 0
                    } label: {
                        Image(systemName: "arrow.counterclockwise")
                    }
                    .buttonStyle(BorderedButtonStyle())
                }
            }
        }
        .onAppear {
            progress.toggleLoading()
        }
    }
}

class ProgressForProgressView: ObservableObject {
    @Published var loadProgress = 0.0
    @Published var isLoading = false
    
    let maxProgress = 1.1
    var timer: Timer?
    
    func startLoading() {
        isLoading = true
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.loadProgress > self.maxProgress {
                self.loadProgress = 0.0
            } else {
                withAnimation {
                    self.loadProgress += 0.01
                }
                
            }
        }
    }
    
    func stopLoading() {
        isLoading = false
        timer?.invalidate()
        timer = nil
    }
    
    func toggleLoading() {
        if isLoading {
            stopLoading()
        } else {
            startLoading()
        }
    }
}
