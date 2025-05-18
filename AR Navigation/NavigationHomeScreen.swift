//
//  NavigationHomeScreen.swift
//  AR Navigation
//
//  Created by Reynard Hansel on 24/03/25.
//

import CoreLocation
import MapKit
import SwiftUI

struct NavigationHomeScreen: View {
    // Bottom Sheet State
    @ObservedObject private var navVM = NavigationHomeViewModel.shared

    // Location Manager to track user position
    @Binding var path: NavigationPath

    //@StateObject private var locationManager = LocationManager()

    @StateObject var locationDataManager: LocationDataManager
    @StateObject var pathFindingManager: PathfindingManager

    // Map stuff
    @State private var cameraPosition: MapCameraPosition = .userLocation(
        fallback: .automatic)
    @State private var mapSelection: MKMapItem?

    @State var showModal: Bool = false

    // Access / import destination data (from: Destination.swift)
    let destinations = showcaseDestination  //destinationDBShowcase

    var body: some View {
        // Map as background
        Map(position: $cameraPosition, selection: $mapSelection) {
            UserAnnotation()

            if navVM.selectedDestination != nil {
                MapPolyline(
                    coordinates: navVM.pathFindingManager.pathCoordinate
                )
                .stroke(Color.blue, lineWidth: 5)
            }

            ForEach(destinations) { destination in
                //                    print(destination.name)
                //                    Marker(
                //                        destination.name,
                //                        systemImage: destination.icon,
                //                        coordinate: destination.destinationCoordinate
                //                    )
                Annotation(
                    destination.name,
                    coordinate: destination.destinationCoordinate
                ) {
                    CustomMapAnnotation(location: destination)
                }
            }
        }
        .mapControls {
            MapUserLocationButton()
        }
        .mapStyle(.standard(pointsOfInterest: .all))
        //        .onAppear {
        //            //                locationManager.requestLocation()
        //        }
        //        .onChange(of: mapSelection) { oldValue, newValue in
        //
        //            if mapSelection != nil {
        //                print("Selection: \(newValue)")
        //            }
        //        }
        .sheet(isPresented: $navVM.showHomeBottomSheet) {

            BottomSheet_Home()
                .presentationDetents(
                    [.fraction(0.09), .medium, .large],
                    selection: $navVM.resetDetent
                )
                .presentationDragIndicator(.visible)
                .presentationBackgroundInteraction(.enabled(upThrough: .large))
                .presentationCornerRadius(20)
                .interactiveDismissDisabled()
                .presentationBackground(Color.background)
        }
    }
}

#Preview {
    NavigationHomeScreen(
        path: .constant(NavigationPath()),
        locationDataManager: LocationDataManager(),
        pathFindingManager: PathfindingManager()
    )
}

//* NOTE:

//************* Kenapa di bbrp variable ada ($)?: ****************
//* ($) = binding
//* kl gapake ($): read-only, cmn nampilin data nya aja
//* kl pake ($): bisa read-write, bisa ngubah / update si data nya

//************* Core Location (CLLocationManager): ***************
//* While SwiftUI itself is a modern Swift framework, you're also using CoreLocation through the `CLLocationManager` class. CoreLocation is an older framework that was built with Objective-C, and its delegate protocols (like `CLLocationManagerDelegate`) are Objective-C protocols that require the Objective-C runtime.
//*
//* In Swift, when you want to conform to an Objective-C protocol that inherits from `NSObjectProtocol` (which `CLLocationManagerDelegate` does), your class must inherit from `NSObject`. This is a requirement regardless of whether your UI layer is SwiftUI, UIKit, or something else.
//*
//* The good news is that this inheritance is isolated to just your `LocationManager` class - the rest of your SwiftUI code can remain pure Swift without Objective-C dependencies.
