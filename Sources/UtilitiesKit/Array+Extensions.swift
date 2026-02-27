// MARK: - Array KeyPath Sorting

extension Array {

    /// Sorts the array in place by the value at `keyPath`.
    ///
    /// ```swift
    /// var people = [Person(name: "Zoe"), Person(name: "Alice")]
    /// people.sort(by: \.name)
    /// // [Alice, Zoe]
    /// ```
    ///
    /// - Parameters:
    ///   - keyPath: A key path to a `Comparable` property on the element.
    ///   - ascending: Pass `false` to sort in descending order. Defaults to `true`.
    public mutating func sort<T: Comparable>(by keyPath: KeyPath<Element, T>, ascending: Bool = true) {
        sort { a, b in
            ascending ? a[keyPath: keyPath] < b[keyPath: keyPath]
                      : a[keyPath: keyPath] > b[keyPath: keyPath]
        }
    }

    /// Returns the array sorted by the value at `keyPath`.
    ///
    /// ```swift
    /// let sorted = people.sorted(by: \.name)
    /// ```
    ///
    /// - Parameters:
    ///   - keyPath: A key path to a `Comparable` property on the element.
    ///   - ascending: Pass `false` to sort in descending order. Defaults to `true`.
    /// - Returns: A new array sorted by the given key path.
    public func sorted<T: Comparable>(by keyPath: KeyPath<Element, T>, ascending: Bool = true) -> [Element] {
        sorted { a, b in
            ascending ? a[keyPath: keyPath] < b[keyPath: keyPath]
                      : a[keyPath: keyPath] > b[keyPath: keyPath]
        }
    }
}
