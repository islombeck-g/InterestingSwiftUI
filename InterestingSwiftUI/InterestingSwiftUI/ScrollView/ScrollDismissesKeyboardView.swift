//
//  ScrollDismissesKeyboardView.swift
//  InterestingSwiftUI
//
//  Created by Islombek Gofurov on 20/05/24.
//

import SwiftUI

struct ScrollDismissesKeyboardView: View {
    
    @State private var typeText = ""
    @State private var isHide = false
    
    var body: some View {
        ScrollView {
            LazyVStack {
                Toggle(isOn: $isHide, label: {
                    Text("isHide")
                })
                .padding(.horizontal)
                
                ForEach(0..<10000) { _ in
                    TextField("", text: $typeText, prompt: Text("somePrompt"))
                        .padding()
                        .textFieldStyle(.roundedBorder)
                }
            }
        }
        .scrollDismissesKeyboard(isHide ? .immediately: .never)
    }
}

#Preview {
    ScrollDismissesKeyboardView()
}
