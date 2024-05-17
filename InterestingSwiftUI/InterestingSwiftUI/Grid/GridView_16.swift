//
//  GridView_16.swift
//  InterestingSwiftUI
//
//  Created by Islombek Gofurov on 17/05/24.
//

import SwiftUI

struct GridView_16: View {
    var body: some View {
        Grid(alignment: .leading) {
            GridRow {
                Text("one")
                Text("two")
                    .background(.green)
            }
            .frame(maxWidth: .infinity)
            .background(.red)
        }
        .background(.orange)
    }
}

#Preview {
    GridView_16()
}
