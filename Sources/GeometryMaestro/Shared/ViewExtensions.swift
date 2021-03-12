//
//  ViewExtensions.swift
//
//
//  Created by Donavon Buchanan on 10/6/20.
//

import SwiftUI

public extension View {
    // MARK: - Read Size and Position Values

    /// Reads the properties of the modified view into an `gsObject` object.
    /// This object is updated any time the geometric properties of the modified
    /// view are altered.
    ///
    /// In the example below, the `.readSize` modifier returns a visually unaltered
    /// view and updates the values of the `size` property of `viewSize`
    /// to match the size and position of the contents of the outermost`VStack`.
    /// These values are then displayed by the `Text` views.
    ///
    ///     /*
    ///     Create a @StateObject of type gsObject to hold all the
    ///     properties needed for the .readSize modifier.
    ///     */
    ///     @StateObject
    ///     private var viewSize = gsObject()
    ///
    ///     var body: some View {
    ///
    ///         VStack(alignment: .leading, spacing: 20) {
    ///             // X Axis
    ///             VStack(alignment: .leading) {
    ///                 Text("minX: \(viewSize.minX)")
    ///                 Text("midX: \(viewSize.midX)")
    ///                 Text("maxX: \(viewSize.maxX)")
    ///             }
    ///
    ///             // Y Axis
    ///             VStack(alignment: .leading) {
    ///                 Text("minY: \(viewSize.minY)")
    ///                 Text("midY: \(viewSize.midY)")
    ///                 Text("maxY: \(viewSize.maxY)")
    ///             }
    ///
    ///             // View Size
    ///             VStack(alignment: .leading) {
    ///                 Text("Contents Width: \(viewSize.width)")
    ///                 Text("Contents Height: \(viewSize.height)")
    ///             }
    ///         }
    ///         .font(.system(.body, design: .monospaced))
    ///         // Blue border for illustration. This is the size being read.
    ///         .border(Color.blue, width: 2)
    ///         // Read size for contents of the VStack, filling the view
    ///         .readSize(to: viewSize)
    ///     }
    ///
    /// - Important:
    /// A note on FrameBehavior:
    /// Using a FrameBehavior value of `.fill` will still only read the size of the original contents
    /// in the modified view while extending the frame to fill all available space.
    /// If you want to read the size of the container view, use `.readParentSize`
    /// or `.measureContainingView` instead.
    ///
    /// - Parameters:
    ///    - to: An observable object of type `gsObject` to hold all the
    ///    properties necessary for the `.readSize` modifier. The properties within this object
    ///    are Published and can be individually observed.
    ///
    /// - Returns: A modified view which reads its current size and updates this value through
    /// the `size` property of the `gsObject` object passed to the `to:` Parameter.

    func readSize(
        to gsObject: GSObject
    ) -> some View {
        modifier(GSModifier(to: gsObject))
    }

    @available(*, deprecated, renamed: "readSize")
    func readFrame(to _: GSObject) -> some View {
        self
    }

    // MARK: - Read Parent Size and Position Values

    /// Reads the properties of the modified view into an `GSObject` object.
    /// This object is updated any time the geometric properties of the modified
    /// view are altered.
    ///
    /// In the example below, the `.readParentSize` modifier returns a visually unaltered
    /// view and updates the values of the `size` property of `parentSize`
    /// to match the size and position of the contents of the outermost`VStack`.
    /// These values are then displayed by the `Text` views.
    ///
    ///     /*
    ///     Create a @StateObject of type GSObject to hold all the
    ///     properties needed for the .readParentSize modifier.
    ///     */
    ///     @StateObject
    ///     private var parentSize = GSObject()
    ///
    ///     var body: some View {
    ///
    ///         VStack(alignment: .leading, spacing: 20) {
    ///
    ///             // X Axis
    ///             VStack(alignment: .leading) {
    ///                 Text("minX: \(parentSize.minX)")
    ///                 Text("midX: \(parentSize.midX)")
    ///                 Text("maxX: \(parentSize.maxX)")
    ///             }
    ///
    ///             // Y Axis
    ///             VStack(alignment: .leading) {
    ///                 Text("minY: \(parentSize.minY)")
    ///                 Text("midY: \(parentSize.midY)")
    ///                 Text("maxY: \(parentSize.maxY)")
    ///             }
    ///
    ///             // Containing View Size
    ///             VStack(alignment: .leading) {
    ///                 Text("Contents Width: \(parentSize.width)")
    ///                 Text("Contents Height: \(parentSize.height)")
    ///             }
    ///
    ///         }
    ///         .font(.system(.body, design: .monospaced))
    ///         .readParentSize(to: parentSize)
    ///     }
    ///
    /// - Parameters:
    ///    - to: An observable object of type `GSObject` to hold all the
    ///    properties necessary for the `.readParentSize` modifier. The properties
    ///    within this object are Published and can be individually observed.
    ///
    /// - Returns: A modified view which reads its current size and updates this value through
    /// the `size` property of the `GSObject` object passed to the `to:` Parameter.
    func readParentSize(
        to gsObject: GSObject
    ) -> some View {
        modifier(GSContainerModifier(to: gsObject))
    }

    @available(*, deprecated, renamed: "readParentSize")
    func readContainer(to _: GSObject) -> some View {
        self
    }

    // MARK: - Without Geometry Reader

    /// Measures the width and height values of the modified View.
    /// - Parameter size: `CGSize` to store size values. Does not currently support
    /// coordinate spaces other than local.
    /// - Returns: Returns a modified `View`,
    /// binding the size of that view to the `size` Parameter.
    func measure(to size: Binding<CGSize>) -> some View {
        modifier(MeasureViewModifier(size: size))
    }

    /// Measures the width and height values of the modified View's containing View.
    /// - Parameter size: `CGSize` to store size values. Does not currently support
    /// coordinate spaces other than local.
    /// - Returns: Returns a modified `View`,
    /// binding the size of that view to the `size` Parameter.
    func measureContainingView(to size: Binding<CGSize>) -> some View {
        modifier(MeasureContainingViewModifier(size: size))
    }

    // MARK: - Alignment

    func alignment() -> some View {
        self
    }

    // MARK: - Matched Sizing

    func equalWidths<Identifier: Hashable>(_ extent: Extent, _ id: Identifier) -> some View {
        modifier(EqualSizeModifier(extent: extent, dimension: .width, identifier: id.hashValue))
    }

    func equalHeights<Identifier: Hashable>(_ extent: Extent, _ id: Identifier) -> some View {
        modifier(EqualSizeModifier(extent: extent, dimension: .height, identifier: id.hashValue))
    }

    func equalSize<Identifier: Hashable>(_ extent: Extent, _ id: Identifier) -> some View {
        modifier(EqualSizeModifier(extent: extent, dimension: .all, identifier: id.hashValue))
    }
}
