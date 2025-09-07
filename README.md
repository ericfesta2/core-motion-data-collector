# Core Motion Data Collector

Core Motion Data Collector makes it easy to obtain Core Motion data from an iPhone or Apple Watch in an accessible CSV format, ideal for analyzing user activity or training ML models. The types of data to include in the CSV output as well as the frequency at which they're collected can be configured within both the iOS and watchOS apps (separately from one another).

**New, September 2025:** iOS support! Core Motion Data Collector can now be run on both watchOS and iOS to collect motion data from either platform.

## Requirements

* Xcode 16.4 (recommended, though the app might also be compatible with other recent versions) and a compatible iPhone
* iOS 15.6+ (theoretically - only tested on the iOS 26.0 betas so far)
* watchOS 10+ (theoretically - only tested on watchOS 11.5 so far)

## Limitations

* The app only prints Core Motion data to Xcode's debug window when run through Xcode, so data can't be collected when the app is run outside of Xcode; CSV export/saving is not supported.
* Magnetometer data is not included in the collected Core Motion data types.
* Collection settings in the iOS and watchOS apps are separate from each other, so preferences from the iOS app won't automatically be reflected in the watchOS app, and vice versa.

## Setup

1. Open this project in Xcode.
2. Ensure that a supported iPhone and/or Apple Watch is registered with Xcode so that Core Motion Data Collector can be run on it through Xcode.
3. Select the desired app (iOS or watchOS) in Xcode's top bar, then click the Run button in Xcode's left sidebar to install and run the app on your device (the first installation may take some time, especially with wireless iPhone connections and Apple Watch).
4. (Optional) In the app, tap the settings button to configure the types of motion data to include in the CSV output and/or the frequency of data collection.
5. On the app's main screen, tap the "Start" button (or double tap on Apple Watch Series 9 or newer running watchOS 10.1 or newer) to begin collecting motion data as soon as you press the button
6. When finished, tap the "Stop" button (or double tap, if supported) to stop collecting motion data
7. Copy the emitted data from Xcode's debug window into an empty text file, and save it as a CSV

