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

    // MARK: - clipped

    @Test("clips string to maxCharacters")
    func clipsToMax() {
        #expect("Hello, world!".clipped(maxCharacters: 5) == "Hello")
    }

    @Test("clipping shorter string returns full string")
    func clippingShorterStringReturnsFull() {
        #expect("Hi".clipped(maxCharacters: 10) == "Hi")
    }

    @Test("clipping to zero returns empty string")
    func clippingToZeroReturnsEmpty() {
        #expect("Hello".clipped(maxCharacters: 0) == "")
    }

    @Test("clipping empty string returns empty string")
    func clippingEmptyString() {
        #expect("".clipped(maxCharacters: 5) == "")
    }

    // MARK: - replacingSpacesWithUnderscores

    @Test("replaces spaces with underscores")
    func replacesSpaces() {
        #expect("hello world".replacingSpacesWithUnderscores() == "hello_world")
    }

    @Test("multiple spaces all replaced")
    func replacesMultipleSpaces() {
        #expect("a b c".replacingSpacesWithUnderscores() == "a_b_c")
    }

    @Test("string with no spaces is unchanged")
    func noSpacesUnchanged() {
        #expect("hello".replacingSpacesWithUnderscores() == "hello")
    }

    // MARK: - converting

    @Test("converts String")
    func convertsString() {
        #expect(String.converting("hello") == "hello")
    }

    @Test("converts Int")
    func convertsInt() {
        #expect(String.converting(42) == "42")
    }

    @Test("converts Double")
    func convertsDouble() {
        #expect(String.converting(3.14) == "3.14")
    }

    @Test("converts Bool")
    func convertsBool() {
        #expect(String.converting(true) == "true")
        #expect(String.converting(false) == "false")
    }

    @Test("converts array to sorted comma-joined string")
    func convertsArray() {
        #expect(String.converting([3, 1, 2]) == "1,2,3")
    }

    @Test("converts CustomStringConvertible")
    func convertsCustomStringConvertible() {
        struct Foo: CustomStringConvertible { var description: String { "foo" } }
        #expect(String.converting(Foo()) == "foo")
    }

    @Test("returns nil for unrecognised type")
    func returnsNilForUnknown() {
        struct Unknown {}
        #expect(String.converting(Unknown()) == nil)
    }
}
