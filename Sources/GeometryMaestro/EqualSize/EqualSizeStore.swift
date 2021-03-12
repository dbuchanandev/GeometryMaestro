//
//  EqualSizeStore.swift
//
//
//  Created by Donavon Buchanan on 2/4/21.
//

import SwiftUI

internal class EqualSizeStore: ObservableObject {
    // MARK: Internal

    static let shared = EqualSizeStore()

    // MARK: Private

    private var objects: [Int: CGSize] = [:]
    
    func getSize(id: Int) -> CGSize {
        guard let size = EqualSizeStore.shared.objects[id] else {
            objectWillChange.send()
            EqualSizeStore.shared.objects[id] = .zero
            return .zero
        }
        return size
    }
    
    func setSize(id: Int, size: CGSize) {
        objectWillChange.send()
        EqualSizeStore.shared.objects[id] = size
    }
}
