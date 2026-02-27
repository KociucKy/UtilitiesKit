import Testing
import Foundation
@testable import UtilitiesKit

@Suite("TimeInterval Extensions")
struct TimeIntervalExtensionsTests {

    // MARK: - hoursAndMinutes

    @Test("zero interval")
    func zeroInterval() {
        let result = (0.0).hoursAndMinutes
        #expect(result.hours == 0)
        #expect(result.minutes == 0)
    }

    @Test("minutes only")
    func minutesOnly() {
        let result = (300.0).hoursAndMinutes  // 5 min
        #expect(result.hours == 0)
        #expect(result.minutes == 5)
    }

    @Test("hours only")
    func hoursOnly() {
        let result = (7200.0).hoursAndMinutes  // 2h
        #expect(result.hours == 2)
        #expect(result.minutes == 0)
    }

    @Test("hours and minutes")
    func hoursAndMinutes() {
        let result = (7500.0).hoursAndMinutes  // 2h 5min
        #expect(result.hours == 2)
        #expect(result.minutes == 5)
    }

    @Test("sub-minute intervals are truncated to zero minutes")
    func subMinute() {
        let result = (45.0).hoursAndMinutes  // 45 seconds
        #expect(result.hours == 0)
        #expect(result.minutes == 0)
    }

    // MARK: - formattedDuration

    @Test("zero produces a non-empty string")
    func zeroDurationNonEmpty() {
        #expect(!(0.0).formattedDuration.isEmpty)
    }

    @Test("5 minutes contains '5'")
    func fiveMinutesContainsFive() {
        #expect((300.0).formattedDuration.contains("5"))
    }

    @Test("2 hours contains '2'")
    func twoHoursContainsTwo() {
        #expect((7200.0).formattedDuration.contains("2"))
    }

    @Test("2h 5min contains both '2' and '5'")
    func twoHoursFiveMinContainsBoth() {
        let result = (7500.0).formattedDuration
        #expect(result.contains("2"))
        #expect(result.contains("5"))
    }
}
