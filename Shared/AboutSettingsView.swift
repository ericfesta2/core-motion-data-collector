//
//  AboutSettingsView.swift
//  Core Motion Data Collector
//
//  Created by Eric Festa on 9/7/25.
//

import SwiftUI

struct AboutSettingsView: View {
    #if os(watchOS)
    private let madeBySeparatorStr = "\n"
    #else
    private let madeBySeparatorStr = " · "
    #endif

    var body: some View {
        VStack {
            Text("Core Motion Data Collector")
                .bold()

            #if os(watchOS)
            Text("")
            #endif

            Text("Made by Eric Festa\(madeBySeparatorStr)[GitHub](https://github.com/ericfesta2)\n")

            #if os(watchOS)
            Text("")
            #endif

            Text("Copyright &copy; 2025 Eric Festa")
        }
            .multilineTextAlignment(.center)
            #if !os(watchOS)
            .ignoresSafeArea(.all, edges: [.top, .bottom])
            #endif
    }
}
