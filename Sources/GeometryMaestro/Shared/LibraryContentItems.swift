//
//  LibraryContentItems.swift
//
//
//  Created by Donavon Buchanan on 10/2/20.
//

import DeveloperToolsSupport
import SwiftUI

public struct LibraryModifierContent: LibraryContentProvider {
    // MARK: Public

    @LibraryContentBuilder
    public func modifiers(base: AnyView) -> [LibraryItem] {
        LibraryItem(
            base.readSize(to: gsObject),
            visible: true,
            title: "Read Frame",
            category: .layout
        )

        LibraryItem(
            base.readParentSize(to: gsObject),
            visible: true,
            title: "Read Parent Frame",
            category: .layout
        )

        LibraryItem(
            base.measure(to: $size),
            visible: true,
            title: "Measure View",
            category: .layout
        )

        LibraryItem(
            base.measureContainingView(to: $size),
            visible: true,
            title: "Measure Containing View",
            category: .layout
        )
    }

    // MARK: Internal

    @Binding
    var gsObject: GSObject

    @Binding
    var size: CGSize
}
