import Testing
@testable import UtilitiesKit

@Suite("Collection Extensions")
struct CollectionExtensionsTests {

    // MARK: - isNotEmpty

    @Test("empty array is not 'not empty'")
    func emptyArrayIsNotNotEmpty() {
        #expect(![Int]().isNotEmpty)
    }

    @Test("non-empty array isNotEmpty")
    func nonEmptyArrayIsNotEmpty() {
        #expect([1, 2, 3].isNotEmpty)
    }

    // MARK: - safe subscript

    @Test("valid index returns element")
    func validIndex() {
        let items = ["a", "b", "c"]
        #expect(items[safe: 0] == "a")
        #expect(items[safe: 2] == "c")
    }

    @Test("out-of-bounds index returns nil")
    func outOfBoundsReturnsNil() {
        let items = ["a", "b", "c"]
        #expect(items[safe: 3] == nil)
        #expect(items[safe: -1] == nil)
    }

    @Test("safe subscript on empty array returns nil")
    func emptyArraySafeSubscript() {
        let items = [Int]()
        #expect(items[safe: 0] == nil)
    }
}
