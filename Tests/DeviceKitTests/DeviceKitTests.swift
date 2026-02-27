import Testing
@testable import DeviceKit

// MARK: - DeviceModelResolver Tests

@Suite("DeviceModelResolver")
struct DeviceModelResolverTests {

    @Test("known iPhone identifier resolves to marketing name")
    func knownIphoneIdentifier() {
        #expect(DeviceModelResolver.resolve("iPhone17,2") == "iPhone 16 Pro Max")
        #expect(DeviceModelResolver.resolve("iPhone17,1") == "iPhone 16 Pro")
        #expect(DeviceModelResolver.resolve("iPhone17,3") == "iPhone 16")
    }

    @Test("known iPad identifier resolves to marketing name")
    func knownIpadIdentifier() {
        #expect(DeviceModelResolver.resolve("iPad16,3") == "iPad Pro 11-inch (M4)")
        #expect(DeviceModelResolver.resolve("iPad14,1") == "iPad mini (6th generation)")
    }

    @Test("known SE identifier resolves correctly")
    func knownSEIdentifier() {
        #expect(DeviceModelResolver.resolve("iPhone14,6") == "iPhone SE (3rd generation)")
        #expect(DeviceModelResolver.resolve("iPhone12,8") == "iPhone SE (2nd generation)")
    }

    @Test("simulator identifiers resolve to 'Simulator'")
    func simulatorIdentifiers() {
        #expect(DeviceModelResolver.resolve("i386") == "Simulator")
        #expect(DeviceModelResolver.resolve("x86_64") == "Simulator")
        #expect(DeviceModelResolver.resolve("arm64") == "Simulator")
    }

    @Test("unknown identifier falls back to the identifier itself")
    func unknownIdentifierFallback() {
        let unknown = "iPhone99,9"
        #expect(DeviceModelResolver.resolve(unknown) == unknown)
    }

    @Test("empty identifier falls back to empty string")
    func emptyIdentifierFallback() {
        #expect(DeviceModelResolver.resolve("") == "")
    }
}

// MARK: - DeviceInfo Analytics Tests

#if canImport(UIKit)
@Suite("DeviceInfo")
struct DeviceInfoTests {

    @Test("analyticsProperties contains all expected keys")
    @MainActor
    func analyticsPropertiesKeys() {
        let info = DeviceInfo.current
        let props = info.analyticsProperties

        let expectedKeys = [
            "device_model", "device_model_id", "os_name", "os_version",
            "app_version", "build_number", "bundle_id",
            "is_simulator", "is_debug", "is_testflight",
            "language", "timezone",
            "screen_width", "screen_height", "screen_scale",
            "is_ipad",
        ]

        for key in expectedKeys {
            #expect(props[key] != nil, "Missing key: \(key)")
        }
    }

    @Test("analyticsProperties values are non-empty strings")
    @MainActor
    func analyticsPropertiesNonEmpty() {
        let props = DeviceInfo.current.analyticsProperties
        for (key, value) in props {
            #expect(!value.isEmpty, "Empty value for key: \(key)")
        }
    }

    @Test("isSimulator is true when running in simulator")
    @MainActor
    func isSimulatorInSimulator() {
        #if targetEnvironment(simulator)
        #expect(DeviceInfo.current.isSimulator)
        #else
        #expect(!DeviceInfo.current.isSimulator)
        #endif
    }

    @Test("model is non-empty")
    @MainActor
    func modelNonEmpty() {
        #expect(!DeviceInfo.current.model.isEmpty)
    }

    @Test("systemName is non-empty")
    @MainActor
    func systemNameNonEmpty() {
        #expect(!DeviceInfo.current.systemName.isEmpty)
    }

    @Test("systemVersion is non-empty")
    @MainActor
    func systemVersionNonEmpty() {
        #expect(!DeviceInfo.current.systemVersion.isEmpty)
    }

    @Test("preferredLanguage is non-empty")
    @MainActor
    func preferredLanguageNonEmpty() {
        #expect(!DeviceInfo.current.preferredLanguage.isEmpty)
    }

    @Test("timezone is non-empty")
    @MainActor
    func timezoneNonEmpty() {
        #expect(!DeviceInfo.current.timezone.isEmpty)
    }

    @Test("screenSize has positive dimensions")
    @MainActor
    func screenSizePositive() {
        let size = DeviceInfo.current.screenSize
        #expect(size.width > 0)
        #expect(size.height > 0)
    }

    @Test("screenScale is at least 1.0")
    @MainActor
    func screenScaleAtLeastOne() {
        #expect(DeviceInfo.current.screenScale >= 1.0)
    }
}
#endif
