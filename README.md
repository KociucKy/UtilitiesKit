# UtilitiesKit

A Swift Package containing lightweight, zero-dependency utilities shared across iOS apps. Three focused libraries with a clear dependency graph:

```
DeviceKitUI → DeviceKit → UtilitiesKit
```

**Requirements:** iOS 18 · Swift 6 · No external dependencies

---

## Libraries

### UtilitiesKit

Pure Swift extensions on standard library and Foundation types. No UIKit or SwiftUI dependency — safe to use in any Swift target.

#### String

```swift
"  ".isBlank                              // true
"  hello  ".trimmed                       // "hello"
"hello world".nilIfBlank                  // "hello world"
"".nilIfBlank                             // nil

"John Doe".initials()                     // "JD"
"John Michael Doe".initials(maxLength: 3) // "JMD"

"Hello, world!".clipped(maxCharacters: 5) // "Hello"
"hello world".replacingSpacesWithUnderscores() // "hello_world"

String.converting(42)        // "42"
String.converting(true)      // "true"
String.converting([3, 1, 2]) // "1,2,3"
String.converting(Date())    // "Feb 27, 2026 at 10:30 AM"
String.converting(Unknown()) // nil
```

#### Collection

```swift
[1, 2, 3].isNotEmpty          // true
[Int]().isNotEmpty             // false

let items = ["a", "b", "c"]
items[safe: 1]                 // "b"
items[safe: 9]                 // nil

[1, 2, 3, 4, 5].first(upTo: 3) // [1, 2, 3]
[1, 2].first(upTo: 10)          // [1, 2]
[1, 2, 3].first(upTo: 0)        // []
```

#### Array

```swift
struct Person { let name: String; let age: Int }
var people = [Person(name: "Zoe", age: 30), Person(name: "Alice", age: 25)]

// Non-mutating
people.sorted(by: \.name)              // [Alice, Zoe]
people.sorted(by: \.age, ascending: false) // [Zoe, Alice]

// Mutating
people.sort(by: \.name)
people.sort(by: \.age, ascending: false)
```

#### Dictionary

```swift
let base  = ["a": 1, "b": 2]
let extra = ["b": 99, "c": 3]

// Non-mutating — existing value wins by default
base.merging(extra)                              // ["a": 1, "b": 2,  "c": 3]
base.merging(extra, conflictTakeExisting: false) // ["a": 1, "b": 99, "c": 3]
base.merging(nil)                                // ["a": 1, "b": 2]  (no-op)

// Mutating
var dict = ["a": 1]
dict.merge(extra)
dict.merge(nil) // no-op
```

#### TimeInterval

```swift
let duration: TimeInterval = 7500   // 2h 5min

duration.hoursAndMinutes   // (hours: 2, minutes: 5)
duration.formattedDuration // "2 hr, 5 min"  (fully localised)
```

#### Date

```swift
let today = Date()

today.startOfDay            // 2026-02-27 00:00:00
today.endOfDay              // 2026-02-27 23:59:59
today.isToday               // true
today.isYesterday           // false

today.formattedRelative()           // "Today"
yesterday.formattedRelative()       // "Yesterday"
someOldDate.formattedRelative()     // "Feb 14, 2026"

Date.randomPast(daysBack: 30)       // random Date within the last 30 days
```

#### DateFormatter

```swift
// Thread-safe NSLock-backed cache — safe to call from any thread
let formatter = DateFormatter.cached(format: "yyyy-MM-dd", locale: .current)
```

---

### DeviceKit

Reads hardware and app environment information. Requires UIKit (iOS only). Depends on `UtilitiesKit`.

```swift
import DeviceKit

// Must be called on the main actor
let info = await MainActor.run { DeviceInfo.current }

info.model             // "iPhone 16 Pro"
info.modelIdentifier   // "iPhone17,2"
info.systemName        // "iOS"
info.systemVersion     // "18.3.1"

info.appVersion        // "1.2.0"
info.buildNumber       // "42"
info.bundleIdentifier  // "com.example.MyApp"

info.isSimulator       // false
info.isDebugBuild      // false
info.isTestFlight      // false

info.preferredLanguage // "en-GB"
info.timezone          // "Europe/London"

info.screenSize        // CGSize(390, 844)
info.screenScale       // 3.0
info.isIPad            // false
```

`DeviceInfo` is a value type (`struct`) and `Sendable` — safe to pass across concurrency boundaries.

**Analytics**

```swift
// Ready-made [String: String] dictionary for any analytics backend
analyticsClient.track("app_launched", properties: info.analyticsProperties)
```

`analyticsProperties` includes: `device_model`, `device_model_id`, `os_name`, `os_version`, `app_version`, `build_number`, `bundle_id`, `is_simulator`, `is_debug`, `is_testflight`, `language`, `timezone`, `screen_width`, `screen_height`, `screen_scale`, `is_ipad`.

**Device model lookup**

`DeviceModelResolver` maps hardware identifiers to marketing names (~80 models, iPhone SE through iPhone 16 Pro Max, iPad Pro M4, iPad mini A17 Pro). Unknown identifiers fall back to the raw identifier string.

---

### DeviceKitUI

A SwiftUI debug view. Depends on `DeviceKit`.

```swift
import DeviceKitUI

// Inside a NavigationStack (e.g. dev settings screen)
DeviceInfoView()
```

Renders a grouped `List` with three sections — **Device**, **App**, and **Runtime**. Tap any row to copy its value to the clipboard; the value label briefly changes to `"Copied!"` as confirmation.

---

## Installation

Add the package in Xcode: **File > Add Package Dependencies**, then enter the repository URL.

Or add it manually to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/your-org/UtilitiesKit", from: "1.0.0")
],
targets: [
    .target(
        name: "MyTarget",
        dependencies: [
            .product(name: "UtilitiesKit", package: "UtilitiesKit"),
            // Add DeviceKit and/or DeviceKitUI as needed
        ]
    )
]
```

Import only what you need — each library is a separate product.

---

## Testing

```bash
swift test
```

84 tests across 7 suites, all runnable on the macOS host. Tests for `DeviceInfo` and `DeviceInfoView` (UIKit-dependent) run via **Cmd+U** in Xcode on an iOS Simulator.

---

## License

MIT
