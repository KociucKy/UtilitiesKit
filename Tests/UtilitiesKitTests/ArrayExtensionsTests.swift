import Testing
@testable import UtilitiesKit

@Suite("Array Extensions")
struct ArrayExtensionsTests {

    private struct Person: Equatable {
        let name: String
        let age: Int
    }

    private let people = [
        Person(name: "Zoe", age: 30),
        Person(name: "Alice", age: 25),
        Person(name: "Bob", age: 35),
    ]

    // MARK: - sorted(by:ascending:)

    @Test("sorted ascending by string keyPath")
    func sortedAscendingByName() {
        let result = people.sorted(by: \.name)
        #expect(result.map(\.name) == ["Alice", "Bob", "Zoe"])
    }

    @Test("sorted descending by string keyPath")
    func sortedDescendingByName() {
        let result = people.sorted(by: \.name, ascending: false)
        #expect(result.map(\.name) == ["Zoe", "Bob", "Alice"])
    }

    @Test("sorted ascending by int keyPath")
    func sortedAscendingByAge() {
        let result = people.sorted(by: \.age)
        #expect(result.map(\.age) == [25, 30, 35])
    }

    @Test("sorted descending by int keyPath")
    func sortedDescendingByAge() {
        let result = people.sorted(by: \.age, ascending: false)
        #expect(result.map(\.age) == [35, 30, 25])
    }

    @Test("sorted does not mutate original")
    func sortedIsNonMutating() {
        let original = people
        _ = people.sorted(by: \.name)
        #expect(people == original)
    }

    @Test("sorted on empty array returns empty")
    func sortedEmptyArray() {
        let empty = [Person]()
        #expect(empty.sorted(by: \.name).isEmpty)
    }

    // MARK: - sort(by:ascending:)

    @Test("sort ascending by string keyPath mutates array")
    func sortAscendingByName() {
        var mutable = people
        mutable.sort(by: \.name)
        #expect(mutable.map(\.name) == ["Alice", "Bob", "Zoe"])
    }

    @Test("sort descending by int keyPath mutates array")
    func sortDescendingByAge() {
        var mutable = people
        mutable.sort(by: \.age, ascending: false)
        #expect(mutable.map(\.age) == [35, 30, 25])
    }

    @Test("sort on single-element array is a no-op")
    func sortSingleElement() {
        var single = [Person(name: "Solo", age: 1)]
        single.sort(by: \.name)
        #expect(single.map(\.name) == ["Solo"])
    }
}
