//
//  GSModifier.swift
//
//
//  Created by Donavon Buchanan on 10/6/20.
//

import SwiftUI

// MARK: - FrameBehavior

public enum FrameBehavior {
    case `default`, fill
}

// MARK: - GSModifier

internal struct GSModifier: ViewModifier {
    // MARK: Lifecycle

    init(
        to gsObject: GSObject
    ) {
        _gsObject = StateObject(wrappedValue: gsObject)
    }

    // MARK: Internal

    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { geometry in
                    Color.clear
                        .preference(
                            key: FrameRectPreferenceKey.self,
                            value: geometry.frame(in: gsObject.coordinateSpace)
                        )
                            .preference(
                                key: SizePreferenceKey.self,
                                value: geometry.size
                            )
                                .onPreferenceChange(FrameRectPreferenceKey.self) { value in
                                    gsObject.rect = value
                                }
                                    .onPreferenceChange(SizePreferenceKey.self) { value in
                                        gsObject.size = value
                                    }
                                        .allowsHitTesting(false)
                }
            )
                .modifier(
                    FilledFrameModifier(
                        behavior: gsObject.behavior,
                        alignment: gsObject.alignment
                    )
                )
    }

    // MARK: Private

    @StateObject
    private var gsObject: GSObject
}
