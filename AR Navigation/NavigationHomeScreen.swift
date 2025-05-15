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
    @State private var isBottomSheetOpen = true
    
    // Location Manager to track user position
    @Binding var path : NavigationPath
    
    
    //@StateObject private var locationManager = LocationManager()

    @StateObject var locationDataManager : LocationDataManager
    @StateObject var pathFindingManager : PathfindingManager
    
    // Map camera position
    @State private var cameraPosition: MapCameraPosition = .userLocation(
        fallback: .automatic)

    // Search State
//    @State private var searchText = ""
    @State private var selectedDestination: Destination? = nil
//    @FocusState private var isSearchBarFocused: Bool
    
    @State var showModal : Bool = false

    // Access / import destination data (from: Destination.swift)
    let destinations = showcaseDestination//destinationDBShowcase

//    var filteredDestinations: [Destination] {
//        if searchText.isEmpty { return destinations }  //* --> returns all list (no filter)
//
//        return destinations.filter {
//            $0.name.localizedCaseInsensitiveContains(searchText)
//        }  //* --> returns filtered list based on search value
//    }
    //* --> This is a computed property. LEARN MORE ABOUT THIS!. Intinya yg gw tangkep: provides a getter and setter (optional)

    var body: some View {
//        ZStack {
            // Map as background
            Map(position: $cameraPosition) {
                UserAnnotation()

                //* NOTE: How the note below works:
                // If selectedDestination && locationManager.lastLocation is not nil (safely unwraps those 2 variables) --> Than the MapPolyline will be made. If not, the code will simply not execute
                MapPolyline(coordinates: pathFindingManager.pathCoordinate)
                .stroke(Color.blue, lineWidth: 5)
                
                ForEach(destinations) { destination in
                    Marker(destination.name, systemImage: destination.icon, coordinate: destination.destinationCoordinate)
                }
                
                // delete later
//                if let destination = selectedDestination,
//                   let currentLocation = locationDataManager.locationManager.location?.coordinate
//                {
//
//                }
                
            }
            .mapControls {
                MapUserLocationButton()
            }
            .mapStyle(.standard(pointsOfInterest: .all))
            .edgesIgnoringSafeArea(.all)
            .onAppear {
//                locationManager.requestLocation()
            }
            .sheet(isPresented: $isBottomSheetOpen) {
//                List(1...10, id: \.self) { n in
//                    Text("Row \(n)")
//                        .listRowBackground(
//                            RoundedRectangle(cornerRadius: 10)
//                                .strokeBorder(.blue, lineWidth: 2)
//                                .padding(.top, n == 1 ? 0 : -15)
//                                .padding(.bottom, n == 10 ? 0 : -15)
//                                .clipShape(Rectangle())
//                        )
//                }
//                .presentationDetents([.fraction(0.1), .medium, .large])
//                .interactiveDismissDisabled()
                BottomSheet_Home()
                    .presentationDetents([.fraction(0.1), .medium, .large])
                    .presentationDragIndicator(.visible)
                    .presentationBackgroundInteraction(.enabled(upThrough: .large))
                    .presentationCornerRadius(15)
                    .interactiveDismissDisabled()
                    .presentationBackground(Color.background)
            }

//            VStack {
//                // Search bar
//                ZStack{
//                    HStack {
//                        Image(systemName: "magnifyingglass")
//                            .foregroundColor(.gray)
//                        TextField(
//                            "Search Destination",
//                            text: $searchText,
//                            prompt: Text("Search Destination")
//                                .foregroundStyle(Color.gray)
//                        )
//                        .focused($isSearchBarFocused)
//                        .onChange(of: searchText, { oldValue, newValue in
//                            
//                            if(selectedDestination != nil && selectedDestination?.name != searchText){
//                                showModal = false
//                                pathFindingManager.ResetPathfinder()
//                            }
//                        })
//                        .foregroundStyle(Color.black)
//                        
//                        if !searchText.isEmpty
//                        {
//                            Button(action:{
//                                self.searchText = ""
//                                showModal = false
//                                pathFindingManager.ResetPathfinder()
//                            })
//                            {
//                                Image(systemName: "multiply.circle")
//                                    .foregroundColor(Color(UIColor.opaqueSeparator))
//                                    .padding(.trailing, 4)
//                                    .padding(.vertical, 0)
//                                    .contentShape(Rectangle())
//                            }
//                        }
//                    }
//                    .padding()
//                    .background(Color.white)
//                    .cornerRadius(50)
//                    .padding(.top, 10)
//                    
//                    
//                }
//                
//                if isSearchBarFocused || !searchText.isEmpty {
//                    SearchResult(
//                        destinations: filteredDestinations,
//                        selectedDestination: $selectedDestination,
//                        pathFindingManager: pathFindingManager,
//                        locationDataManager: locationDataManager,
//                        showModal: $showModal,
//                        fieldText: $searchText,
//                        cameraPosition: $cameraPosition,
//                        isSearchBarFocused: $isSearchBarFocused
//                    )
//                }
//
//                Spacer()
//                
//                // Confirm Destination Modal
//                if showModal {
////                    ConfirmDestinationModal(
////                        showModal: $showModal,
////                        path: $path,
////                        onCancel: {
////                            searchText = ""
////                        },
////                        onConfirm: {
////                            searchText = ""
////                        },
////                        destName: selectedDestination?.name ?? "",
////                        distance: String(format:"%.0f",pathFindingManager.estimateCumulativeDistance),
////                        time: String(format:"%.0f",pathFindingManager.estimateCumulativeDistance * 0.3)
////                        
////                    )
//                    SelectedDestinationModal(
//                        showModal: $showModal,
//                        onCancel: {
//                            pathFindingManager.ResetPathfinder()
//                            searchText = ""
//                            showModal = false
//                        },
//                        onConfirm: {
//                            selectedDestination = nil
//                            searchText = ""
//                            path.append("ARView")
//                        },
//                        destName:selectedDestination?.name ?? "",
//                        distance: String(format:"%.0f",pathFindingManager.estimateCumulativeDistance),
//                        time: String(format:"%.0f",pathFindingManager.estimateCumulativeDistance * 0.3)
//                    )
//                }
//                
//            }
//            .padding(.horizontal)
            
                    
//        }
//        .onTapGesture { isSearchBarFocused = false }
    }
}


// LocationManager Class
//class LocationManager: NSObject, ObservableObject {
//    @Published var lastLocation: CLLocation?
//
//    private let locationManager = CLLocationManager()
//
//    override init() {
//        super.init()
//        locationManager.delegate = self
//    }
//
//    func requestLocation() {
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.startUpdatingLocation()
//    }
//}
//
//extension LocationManager: CLLocationManagerDelegate {
//    func locationManager(
//        _ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]
//    ) {
//        guard let location = locations.first else { return }
//        lastLocation = location
//    }
//
//    func locationManager(
//        _ manager: CLLocationManager, didFailWithError error: Error
//    ) {
//        print("Failed to find user's location: \(error.localizedDescription)")
//    }
//}

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
