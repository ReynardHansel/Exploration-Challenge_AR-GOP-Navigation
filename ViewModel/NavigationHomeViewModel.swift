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
    
    @Published var sheetDetent: PresentationDetent = .fraction(0.09)
    
    private init() {}
    
}
