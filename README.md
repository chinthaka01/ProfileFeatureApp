# ProfileFeatureApp

ProfileFeatureApp is a standalone SwiftUI demo app that embeds the **Profile** micro‑feature. It wires up only the minimum shared dependencies (networking and analytics) required by the profile module so that it can be developed, debugged, and previewed independently.

***

## Purpose

- Run the Profile feature by itself, without other tabs or features from the main app.  
- Quickly test profile UI, networking, and analytics behavior in the simulator.  
- Serve as an example of how to compose a single micro‑feature into a simple host application.

***

## Architecture

ProfileFeatureApp reuses the same platform abstractions as the main Wefriendz shell:

- **PlatformKit**
  - `AnalyticsImpl` for logging analytics events in the demo host.
  - `NetworkingImpl` for making HTTP requests to the demo backend‑for‑frontend (BFF).
- **ProfileFeature**
  - `ProfileFeatureAPIClient` for profile‑specific network calls.
  - `ProfileDependenciesImpl` as the dependency container for the feature.
  - `ProfileFeatureFactory` which creates a `MicroFeature` representing the Profile tab entry point.

### App entry point: `ProfileFeatureApp`

Inside `ProfileFeatureApp`:

- Shared services:
  - `analytics = AnalyticsImpl()`
  - `networking = NetworkingImpl()`
- Profile feature composition:
  - `profileAPI = ProfileFeatureAPIClient(networking: networking)`
  - `profileDependencies = ProfileDependenciesImpl(profileAPI: profileAPI, analytics: analytics)`
  - `profileFactory = ProfileFeatureFactory(dependencies: profileDependencies)`
  - `feature = profileFactory.makeFeature()`  
- Root scene:
  - The `body` uses a `WindowGroup` that renders `ContentView(feature: feature)`, so the app launches directly into the Profile feature’s UI.

### Host view: `ContentView`

- Holds a single property:
  - `let feature: MicroFeature`
- Renders the feature:
  - Returns `feature.makeRootView().padding()` from `body`, giving the Profile feature full control of the screen while adding some outer padding for better presentation.

***

## Usage

1. Open the **ProfileFeatureApp** target in Xcode.  
2. Select an iOS Simulator device.  
3. Run the app:
   - The simulator launches directly into the Profile feature’s root view.
   - All networking and analytics for profile flows use the same PlatformKit implementations as in the main app.

This setup enables rapid iteration on the profile experience while still exercising the real platform and feature wiring.
