# Design System Notes

SwiftUI extension candidates for a future `FulhamKit` (or similar) design system package.
These were intentionally excluded from `UtilitiesKit` / `DeviceKit` / `DeviceKitUI` because
they carry visual/UX opinions that belong in an app-level design system, not a utility library.

---

## View Modifiers

### `onFirstAppear(perform:)` / `onFirstTask(perform:)`

Fires a closure (or async task) exactly once — on first appearance only.
Backed by a `@State var hasAppeared = false` flag.

```swift
extension View {
    func onFirstAppear(perform action: @escaping () -> Void) -> some View { ... }
    func onFirstTask(perform action: @escaping () async -> Void) -> some View { ... }
}
```

---

### `ifSatisfiedCondition(_:transform:)`

Conditionally applies a view transform. Avoids `if` / `AnyView` wrapping at call sites.

```swift
extension View {
    @ViewBuilder
    func ifSatisfiedCondition<Content: View>(
        _ condition: Bool,
        transform: (Self) -> Content
    ) -> some View { ... }
}
```

---

### `tappableBackground()`

Adds a clear `Color` background so the entire frame (including empty space) is hittable.
Needed whenever a `.onTapGesture` on a `VStack`/`HStack` fails to fire in the gaps.

```swift
extension View {
    func tappableBackground() -> some View {
        background(Color.clear.contentShape(Rectangle()))
    }
}
```

---

### `addingGradientBackgroundForText()`

Overlays a vertical gradient (transparent → black at ~40% opacity) behind text
to improve legibility over image backgrounds.

```swift
extension View {
    func addingGradientBackgroundForText() -> some View {
        background(
            LinearGradient(
                colors: [.clear, .black.opacity(0.4)],
                startPoint: .top,
                endPoint: .bottom
            )
        )
    }
}
```

---

### `badgeStyle(backgroundColor:)`

Wraps content in a compact, pill-shaped badge with a given background colour.

```swift
extension View {
    func badgeStyle(backgroundColor: Color) -> some View {
        padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(backgroundColor)
            .clipShape(Capsule())
    }
}
```

---

### `AnyNotificationListenerViewModifier` / `.onNotificationReceived(name:action:)`

Subscribes to a `NotificationCenter` notification for the lifetime of the view.

```swift
extension View {
    func onNotificationReceived(
        _ name: Notification.Name,
        action: @escaping (Notification) -> Void
    ) -> some View { ... }
}
```

---

## Binding Extensions

### `Binding<Bool>(ifNotNil:)`

Creates a `Binding<Bool>` that is `true` when a given `Binding<T?>` is non-nil,
and sets it back to `nil` when written `false`. Useful for sheet/alert presentation
driven by optional state.

```swift
extension Binding where Value == Bool {
    init<T>(ifNotNil binding: Binding<T?>) { ... }
}
```
