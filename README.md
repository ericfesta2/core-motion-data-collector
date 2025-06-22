# Core Motion Data Collector

Core Motion Data Collector makes it easy to obtain Core Motion data from an Apple Watch in an accessible CSV format, ideal for analyzing user activity or training ML models. The types of data to include in the CSV output as well as the frequency at which they're collected can be configured within the watchOS app.

## Requirements

* Xcode 16.4 (recommended, though the app might also be compatible with other recent versions) and a compatible iPhone
* watchOS 10+ (theoretically - only tested on watchOS 11.5 so far)

## Limitations

* Subject to change, this project is designed exclusively for watchOS to collect motion data from an Apple Watch. No iOS app for collecting iPhone motion data is available.
* The app only prints Core Motion data to Xcode's debug window when run through Xcode, so data can't be collected when the app is run outside of Xcode; CSV export/saving is not supported.
* Magnetometer data is not included in the collected Core Motion data types.

## Setup

1. Open this project in Xcode
2. Ensure that a supported Apple Watch is registered with Xcode so that Core Motion Data Collector can be run on it through Xcode
3. Click the Run button in Xcode's left sidebar to install and run the app on your Apple Watch (the first installation may take some time)
4. (Optional) In the app, tap the settings icon to configure the types of motion data to include in the CSV output and/or the frequency of data collection
5. On the app's main screen, tap the "Start" button (or double tap on Apple Watch Series 9 or newer running watchOS 10.1 or newer) to begin collecting motion data as soon as you press the button
6. When finished, tap the "Stop" button (or double tap, if supported) to stop collecting motion data
7. Copy the emitted data from Xcode's debug window into an empty text file, and save it as a CSV

