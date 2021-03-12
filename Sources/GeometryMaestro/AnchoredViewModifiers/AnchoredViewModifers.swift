//
//  AnchoredViewModifier.swift
//
//
//  Created by Donavon Buchanan on 10/14/20.
//

import SwiftUI

internal struct AnchoredViewModifier: ViewModifier {
    @StateObject
    private var gsObject: GSObject

    init(alignment: Alignment) {
        _gsObject = StateObject(wrappedValue: GSObject(alignment: alignment, behavior: .fill))
    }

    func body(content: Content) -> some View {
        content
            .readSize(to: gsObject)
    }
}
