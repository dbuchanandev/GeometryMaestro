//
//  GSContainerModifier.swift
//
//
//  Created by Donavon Buchanan on 10/13/20.
//

import SwiftUI

internal struct GSContainerModifier: ViewModifier {
    // MARK: Lifecycle

    init(
        to gsObject: GSObject
    ) {
        _gsObject = StateObject(wrappedValue: gsObject)
    }

    // MARK: Internal

    func body(content: Content) -> some View {
        Rectangle()
            .foregroundColor(.clear)
            .allowsHitTesting(false)
            .readSize(to: gsObject)
            .overlay(content)
    }

    // MARK: Private

    @StateObject
    private var gsObject: GSObject
}
