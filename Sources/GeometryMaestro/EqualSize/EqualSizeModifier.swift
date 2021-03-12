//
//  EqualSizeModifier.swift
//
//
//  Created by Donavon Buchanan on 2/4/21.
//

import SwiftUI

internal struct EqualSizeModifier: ViewModifier {
    // MARK: Internal

    let extent: Extent
    let dimension: Dimension
    let identifier: Int

    func body(content: Content) -> some View {
        content
            .measure(
                to: Binding(
                    get: {
                        size
                    },
                    set: { newValue in
                        bindingSetter(newValue)
                    }
                )
            )
    }

    // MARK: Private

    private let store = EqualSizeStore.shared

    private var size: CGSize {
        store.getSize(id: identifier)
    }

    private func bindingSetter(_ newValue: CGSize) {
        debugPrint(#function)
        switch extent {
        case .least:
            switch dimension {
            case .width:
                if newValue.width < size.width {
                    store.setSize(id: identifier, size: newValue)
                }
            case .height:
                if newValue.height < size.height {
                    store.setSize(id: identifier, size: newValue)
                }
            case .all:
                if newValue.width < size.width || newValue.height < size.height {
                    store.setSize(id: identifier, size: newValue)
                }
            }
        case .greatest:
            switch dimension {
            case .width:
                if newValue.width > size.width {
                    store.setSize(id: identifier, size: newValue)
                }
            case .height:
                if newValue.height > size.height {
                    store.setSize(id: identifier, size: newValue)
                }
            case .all:
                if newValue.width > size.width || newValue.height > size.height {
                    store.setSize(id: identifier, size: newValue)
                }
            }
        }
    }
}
