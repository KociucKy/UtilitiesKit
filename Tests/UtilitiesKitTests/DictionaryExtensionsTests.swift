import Testing
@testable import UtilitiesKit

@Suite("Dictionary Extensions")
struct DictionaryExtensionsTests {

    // MARK: - merging(_:conflictTakeExisting:)

    @Test("merging adds keys from other that don't exist in self")
    func mergingAddsNewKeys() {
        let base = ["a": 1, "b": 2]
        let result = base.merging(["c": 3])
        #expect(result == ["a": 1, "b": 2, "c": 3])
    }

    @Test("merging keeps existing value on conflict by default")
    func mergingKeepsExistingOnConflict() {
        let base = ["a": 1, "b": 2]
        let result = base.merging(["b": 99, "c": 3])
        #expect(result["b"] == 2)
        #expect(result["c"] == 3)
    }

    @Test("merging overwrites when conflictTakeExisting is false")
    func mergingOverwritesOnConflict() {
        let base = ["a": 1, "b": 2]
        let result = base.merging(["b": 99], conflictTakeExisting: false)
        #expect(result["b"] == 99)
    }

    @Test("merging nil returns self unchanged")
    func mergingNilReturnsUnchanged() {
        let base = ["a": 1]
        let result = base.merging(nil)
        #expect(result == base)
    }

    @Test("merging does not mutate original")
    func mergingIsNonMutating() {
        let base = ["a": 1]
        _ = base.merging(["b": 2])
        #expect(base == ["a": 1])
    }

    @Test("merging two empty dictionaries returns empty")
    func mergingBothEmpty() {
        let result = [String: Int]().merging([:])
        #expect(result.isEmpty)
    }

    // MARK: - merge(_:conflictTakeExisting:)

    @Test("merge adds keys from other in place")
    func mergeAddsNewKeys() {
        var base = ["a": 1, "b": 2]
        base.merge(["c": 3])
        #expect(base == ["a": 1, "b": 2, "c": 3])
    }

    @Test("merge keeps existing value on conflict by default")
    func mergeKeepsExistingOnConflict() {
        var base = ["a": 1, "b": 2]
        base.merge(["b": 99])
        #expect(base["b"] == 2)
    }

    @Test("merge overwrites when conflictTakeExisting is false")
    func mergeOverwritesOnConflict() {
        var base = ["a": 1, "b": 2]
        base.merge(["b": 99], conflictTakeExisting: false)
        #expect(base["b"] == 99)
    }

    @Test("merge with nil is a no-op")
    func mergeNilIsNoOp() {
        var base = ["a": 1]
        base.merge(nil)
        #expect(base == ["a": 1])
    }
}
