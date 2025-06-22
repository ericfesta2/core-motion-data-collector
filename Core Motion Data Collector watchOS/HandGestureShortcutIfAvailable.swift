//
//  CondHandGestureShortcut.swift
//  Motion Data Collector
//
//  Created by Eric Festa on 6/21/25.
//

import SwiftUI

extension View {
    // Enable Apple Watch double tap on supported watchOS versions
    @ViewBuilder func handGestureShortcutIfAvailable() -> some View {
        if #available(watchOS 11.0, *) {
            self.handGestureShortcut(.primaryAction)
        } else {
            self
        }
    }
}
