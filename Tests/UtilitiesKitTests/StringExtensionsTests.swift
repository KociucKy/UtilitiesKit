import Testing
import Foundation
@testable import UtilitiesKit

@Suite("String Extensions")
struct StringExtensionsTests {

    // MARK: - isBlank

    @Test("empty string is blank")
    func emptyIsBlank() {
        #expect("".isBlank)
    }

    @Test("whitespace-only string is blank")
    func whitespaceIsBlank() {
        #expect("   ".isBlank)
        #expect("\t\n".isBlank)
    }

    @Test("non-empty string is not blank")
    func nonEmptyIsNotBlank() {
        #expect(!"hello".isBlank)
        #expect(!" a ".isBlank)
    }

    // MARK: - nilIfBlank

    @Test("blank string returns nil")
    func blankReturnsNil() {
        #expect("".nilIfBlank == nil)
        #expect("  ".nilIfBlank == nil)
    }

    @Test("non-blank string returns self")
    func nonBlankReturnsSelf() {
        #expect("hello".nilIfBlank == "hello")
    }

    // MARK: - trimmed

    @Test("trims leading and trailing whitespace")
    func trims() {
        #expect("  hello  ".trimmed == "hello")
        #expect("\n hello \n".trimmed == "hello")
    }

    @Test("trimming already-clean string returns same value")
    func trimClean() {
        #expect("hello".trimmed == "hello")
    }

    // MARK: - initials

    @Test("two-word name produces two initials")
    func twoWordInitials() {
        #expect("John Doe".initials() == "JD")
    }

    @Test("single word produces one initial")
    func singleWordInitial() {
        #expect("Alice".initials() == "A")
    }

    @Test("respects maxLength")
    func maxLength() {
        #expect("John Michael Doe".initials(maxLength: 2) == "JM")
        #expect("John Michael Doe".initials(maxLength: 3) == "JMD")
    }

    @Test("empty string produces empty initials")
    func emptyInitials() {
        #expect("".initials() == "")
    }

    @Test("initials are uppercased")
    func initialsUppercased() {
        #expect("john doe".initials() == "JD")
    }
}
