//
//  TestView.swift
//  InterestingSwiftUI
//
//  Created by Islombek Gofurov on 20/05/24.
//

import SwiftUI

struct TestView: View {
    var body: some View {
        VStack {
            Button {
                
            } label: {
                Text("someText")
                    .padding()
                    .background(.red)
            }
            .padding(54)
            .background(.orange)
        }
    }
}

#Preview {
    TestView()
}

struct some {
    
    
    var me = 10
    
    mutating func somes() {
        me += 1
    }
}
