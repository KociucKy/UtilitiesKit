extension Collection {

    /// Returns `true` when the collection contains at least one element.
    ///
    /// Prefer this over `!collection.isEmpty` for readability.
    public var isNotEmpty: Bool {
        !isEmpty
    }

    /// Returns a subsequence containing the first `count` elements.
    ///
    /// If `count` exceeds the number of elements, the entire collection is
    /// returned. If `count` is zero or negative, an empty subsequence is returned.
    ///
    /// ```swift
    /// [1, 2, 3, 4, 5].first(upTo: 3)  // [1, 2, 3]
    /// [1, 2].first(upTo: 10)           // [1, 2]
    /// [1, 2, 3].first(upTo: 0)         // []
    /// ```
    public func first(upTo count: Int) -> SubSequence {
        prefix(Swift.max(0, count))
    }
}

extension Collection where Index == Int {

    /// Returns the element at `index`, or `nil` if the index is out of bounds.
    ///
    /// ```swift
    /// let items = ["a", "b", "c"]
    /// items[safe: 1]  // "b"
    /// items[safe: 9]  // nil
    /// ```
    public subscript(safe index: Int) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
