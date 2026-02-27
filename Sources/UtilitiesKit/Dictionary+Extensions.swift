// MARK: - Dictionary Merging

extension Dictionary {

    /// Returns a new dictionary by merging `other` into `self`.
    ///
    /// When the same key exists in both dictionaries the `conflictTakeExisting`
    /// flag decides which value wins:
    /// - `true` (default) — keep the value already in `self`
    /// - `false` — overwrite with the value from `other`
    ///
    /// Passing `nil` for `other` is a no-op and returns `self` unchanged.
    ///
    /// ```swift
    /// let base = ["a": 1, "b": 2]
    /// let extra = ["b": 99, "c": 3]
    ///
    /// base.merging(extra)                          // ["a": 1, "b": 2,  "c": 3]
    /// base.merging(extra, conflictTakeExisting: false)  // ["a": 1, "b": 99, "c": 3]
    /// ```
    ///
    /// - Parameters:
    ///   - other: The dictionary to merge in. If `nil`, `self` is returned unchanged.
    ///   - conflictTakeExisting: When `true`, existing values take priority. Defaults to `true`.
    /// - Returns: A new merged dictionary.
    public func merging(_ other: Dictionary?, conflictTakeExisting: Bool = true) -> Dictionary {
        guard let other else { return self }
        return merging(other) { existing, new in
            conflictTakeExisting ? existing : new
        }
    }

    /// Merges `other` into `self` in place.
    ///
    /// - Parameters:
    ///   - other: The dictionary to merge in. If `nil`, nothing happens.
    ///   - conflictTakeExisting: When `true`, existing values are kept. Defaults to `true`.
    public mutating func merge(_ other: Dictionary?, conflictTakeExisting: Bool = true) {
        guard let other else { return }
        merge(other) { existing, new in
            conflictTakeExisting ? existing : new
        }
    }
}
