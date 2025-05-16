//
//  BottomSheet_Home_ViewModel.swift
//  AR Navigation
//
//  Created by Reynard Hansel on 16/05/25.
//

import Foundation
import Combine

final class BottomSheetHomeViewModel: ObservableObject {
    /// The full list of destinations
    @Published var allDestinations: [Destination] = showcaseDestination
    
    /// What the user has typed
    @Published var searchText: String = ""
    
    /// Filtered by `searchText`
    @Published private(set) var filteredDestinations: [Destination] = []
    
    /// Selected Destination
    @Published var selectedDestination: Destination?
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        // any time searchText or destinations change, recompute filtered
        Publishers
            .CombineLatest($searchText, $allDestinations)
            .map { text, all -> [Destination] in
                guard !text.isEmpty else { return all }
                return all.filter {
                    $0.name.localizedCaseInsensitiveContains(text)
                }
            }
            .assign(to: \.filteredDestinations, on: self)
            .store(in: &cancellables)
    }
    
    /// Clear the search field
    func clearSearch() {
        searchText = ""
    }
}
