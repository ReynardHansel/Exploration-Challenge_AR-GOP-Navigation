//
//  NavigationHomeViewModel.swift
//  AR Navigation
//
//  Created by Reynard Hansel on 16/05/25.
//

import SwiftUI
import Combine

final class NavigationHomeViewModel: ObservableObject {
    static let shared = NavigationHomeViewModel()
    
    /// Selected Destination
    @Published var selectedDestination: Destination?
    
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
    
//    @Published var sheetDetent: PresentationDetent = .fraction(0.09)
    
//    private init() {}
    
}
