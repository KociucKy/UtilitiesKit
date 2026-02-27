import Testing
import Foundation
@testable import UtilitiesKit

@Suite("Date Extensions")
struct DateExtensionsTests {

    // MARK: - startOfDay / endOfDay

    @Test("startOfDay has zero time components")
    func startOfDayHasZeroTime() {
        let date = Date()
        let start = date.startOfDay
        let components = Calendar.current.dateComponents([.hour, .minute, .second], from: start)
        #expect(components.hour == 0)
        #expect(components.minute == 0)
        #expect(components.second == 0)
    }

    @Test("endOfDay is after startOfDay")
    func endOfDayAfterStart() {
        let date = Date()
        #expect(date.endOfDay > date.startOfDay)
    }

    @Test("startOfDay and endOfDay fall on the same calendar day")
    func sameDay() {
        let date = Date()
        #expect(Calendar.current.isDate(date.startOfDay, inSameDayAs: date.endOfDay))
    }

    // MARK: - isToday / isYesterday

    @Test("current date isToday")
    func currentDateIsToday() {
        #expect(Date().isToday)
    }

    @Test("yesterday is not today")
    func yesterdayIsNotToday() {
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        #expect(!yesterday.isToday)
    }

    @Test("yesterday isYesterday")
    func yesterdayIsYesterday() {
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        #expect(yesterday.isYesterday)
    }

    @Test("today is not yesterday")
    func todayIsNotYesterday() {
        #expect(!Date().isYesterday)
    }

    // MARK: - formattedRelative

    @Test("today's date produces a non-empty string")
    func todayNonEmpty() {
        #expect(!Date().formattedRelative().isEmpty)
    }

    @Test("old date produces a non-empty string")
    func oldDateNonEmpty() {
        let old = Date(timeIntervalSinceNow: -(86400 * 30))
        #expect(!old.formattedRelative().isEmpty)
    }

    // MARK: - randomPast

    @Test("randomPast is in the past")
    func randomPastIsInThePast() {
        let past = Date.randomPast()
        #expect(past < Date())
    }

    @Test("randomPast respects daysBack bound")
    func randomPastRespectsBound() {
        let daysBack = 10
        let past = Date.randomPast(daysBack: daysBack)
        let earliest = Date(timeIntervalSinceNow: -Double(daysBack * 24 * 60 * 60 + 60))
        #expect(past > earliest)
    }

    // MARK: - DateFormatter.cached

    @Test("cached returns same instance for same key")
    func cachedReturnsSameInstance() {
        let a = DateFormatter.cached(format: "dd/MM/yyyy")
        let b = DateFormatter.cached(format: "dd/MM/yyyy")
        #expect(a === b)
    }

    @Test("cached returns different instances for different formats")
    func cachedDifferentFormats() {
        let a = DateFormatter.cached(format: "dd/MM/yyyy")
        let b = DateFormatter.cached(format: "yyyy-MM-dd")
        #expect(a !== b)
    }

    @Test("cached formatter produces non-empty output")
    func cachedFormatterOutput() {
        let formatter = DateFormatter.cached(format: "yyyy")
        #expect(!formatter.string(from: Date()).isEmpty)
    }
}
