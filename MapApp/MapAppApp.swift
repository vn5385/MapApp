//
//  MapAppApp.swift
//  MapApp
//
//  Created by vishnu nair☁️🍡 on 6/20/25.
//

import SwiftUI

@main
struct MapAppApp: App {
    
    @StateObject private var vm = LocationsViewModel()
    
    var body: some Scene {
        WindowGroup {
            LocationsView()
                .environmentObject(vm)
        }
    }
}
