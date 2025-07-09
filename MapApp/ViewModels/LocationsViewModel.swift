//
//  LocationsViewModel.swift
//  MapApp
//
//  Created by vishnu nair☁️🍡 on 6/20/25.
//

import Foundation
import MapKit
import SwiftUI

class LocationsViewModel: ObservableObject {
    
//    All loaded locations
    @Published var locations: [Location] // array is all loaded locations
    
//    current location on map
    @Published var mapLocation: Location {
        didSet {
            updateMapCameraPosition(location: mapLocation)
        }
    }
    
//     current region on map
    @Published var mapCameraPosition: MapCameraPosition = .automatic
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
//    show list of locations
    @Published var showLocationsList: Bool = false
//    show location detail view via sheet
    @Published var sheetLocation: Location? = nil
    init() {
        let locations = LocationsDataService.locations // all locations here
        self.locations = locations // sets up array of locations
        self.mapLocation = locations.first!
        
        self.updateMapCameraPosition(location: locations.first!)
        
    }
    
    private func updateMapCameraPosition(location: Location) {
        withAnimation(.easeInOut) {
            mapCameraPosition = .region(MKCoordinateRegion(
                center: location.coordinates,
                span: mapSpan
            ))
        }
    }
    
    func toggleLocationsList() {
        withAnimation(.easeInOut) {
            showLocationsList = !showLocationsList
        }
    }
    
    func showNextLocation(location: Location) {
        withAnimation(.easeInOut) {
            mapLocation = location
            showLocationsList = false
        }
    }
    
    func nextButtonPressed() {
        // get the current index
        guard let currentIndex = locations.firstIndex (where: { $0 == mapLocation }) else {
            print("Could not find current index in locations array! Should never happen")
            return
        }
        // check if the current index is valid
        let nextIndex = currentIndex + 1
        guard locations.indices.contains(nextIndex) else {
            // next index is not valid
            // restart from 0
            let firstLocation = locations.first!
            showNextLocation(location: firstLocation)
            return
        }
        
        // next index is valid
        let nextLocation = locations[nextIndex]
        showNextLocation(location: nextLocation)
    }
}
