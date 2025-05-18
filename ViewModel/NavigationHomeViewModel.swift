//
//  NavigationHomeViewModel.swift
//  AR Navigation
//
//  Created by Reynard Hansel on 16/05/25.
//

import SwiftUI
import Combine
import CoreLocation

final class NavigationHomeViewModel: ObservableObject {
    static let shared = NavigationHomeViewModel()
    
//    @Published var sheetDetent: PresentationDetent = .fraction(0.09)
    @Published var resetDetent: PresentationDetent = .fraction(0.09)
    
    /// Sheet State
    @Published var showHomeBottomSheet: Bool = true
    @Published var showLocationBottomSheet: Bool = false
    
    /// Helper:
    /// Use this template to toggle sheet state:
    /// NavigationHomeViewModel.shared.show{X}BottomSheet.toggle()
    
    /// Selected Destination
    @Published var selectedDestination: Destination?
    
    /// Managers:
    let locationDataManager = LocationDataManager()
    let pathFindingManager  = PathfindingManager()
    
    /// Call this whenever you want to select a destination,
    /// compute a new path, and pop open the location sheet
    func select(destination: Destination) {
      // 1) clear old path
      pathFindingManager.ResetPathfinder()
      locationDataManager.ResetPath()

      // 2) grab current user location (or fallback)
      let userCoord = locationDataManager
                       .locationManager
                       .location?
                       .coordinate
                     ?? CLLocationCoordinate2D(latitude: 0, longitude: 0)

      // 3) compute new path
      pathFindingManager.FindNewPath(
        userCoordinate: userCoord,
        destinationName: destination.name
      )
      locationDataManager.currentPath = pathFindingManager.pathNodes

      // 4) update selection & show sheet
      selectedDestination        = destination
      resetDetent                = .fraction(0.09)
      showLocationBottomSheet    = true
    }
    
    /// to print the selected destination whenever it changes
//    private var cancellables = Set<AnyCancellable>()
//    init() {
//            // whenever `selectedDestination` changes, print the new value
//            $selectedDestination
//                .sink { newDestination in
//                    if let dest = newDestination {
//                        print("✅ selectedDestination changed to: \(dest.name) @ \(dest.destinationCoordinate.latitude),\(dest.destinationCoordinate.longitude)")
//                    } else {
//                        print("🟡 selectedDestination was cleared")
//                    }
//                }
//                .store(in: &cancellables)
//        }
    
    
//    private init() {}
    
}
