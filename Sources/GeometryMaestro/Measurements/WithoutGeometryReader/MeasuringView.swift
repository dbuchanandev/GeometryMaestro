//
//  MeasuringView.swift
//
//
//  Created by Donavon Buchanan on 10/13/20.
//

import SwiftUI

internal struct MeasuringView: View {
    @Binding
    var size: CGSize

    var body: some View {
        MeasuringShape(size: $size)
            .foregroundColor(.clear)
            .allowsHitTesting(false)
    }
}
