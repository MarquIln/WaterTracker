//
//  WaterTrackerApp.swift
//  WaterTracker Watch App
//
//  Created by Marcos on 16/10/25.
//

import SwiftUI
import SwiftData

@main
struct WaterTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: WaterDay.self)
    }
}
