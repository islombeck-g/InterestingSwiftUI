//
//  ContentView.swift
//  InterestingSwiftUI
//
//  Created by Islombek Gofurov on 17/05/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink {
                    DownloadProgressView()
                } label: {
                    Text("Download progress")
                }
                NavigationLink {
                    GridView_16()
                } label: {
                    Text("GridView")
                }
                NavigationLink {
                    TestView()
                } label: {
                    Text("TestView")
                }
                NavigationLink {
                    ScrollDismissesKeyboardView()
                } label: {
                    Text("ScrollDismissesKeyboardView")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
