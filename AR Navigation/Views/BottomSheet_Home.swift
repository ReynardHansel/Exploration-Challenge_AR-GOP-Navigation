//
//  BottomSheet_Home.swift
//  AR Navigation
//
//  Created by Reynard Hansel on 09/05/25.
//

import SwiftUI

struct BottomSheet_Home: View {
    @StateObject private var vm = BottomSheetHomeViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // — Search Bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(Color.customPrimary.opacity(0.8))
                    
                    TextField(
                        "",
                        text: $vm.searchText,
                        prompt: Text("Search your destination…")
                            .foregroundStyle(Color.customPrimary.opacity(0.5))
                    )
                    
                    if !vm.searchText.isEmpty {
                        Button {
                            vm.clearSearch()
                        } label: {
                            Image(systemName: "xmark.circle")
                                .foregroundStyle(Color.red)
                        }
                    }
                }
                .padding(12)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.customPrimary, lineWidth: 1)
                )
                
                // — Content
                if vm.searchText.isEmpty {
                    HomeContentView(destinations: vm.allDestinations, searchText: $vm.searchText)
                } else {
                    SectionListView(
                        title: "Search Results",
                        items: vm.filteredDestinations,
                        isSearching: true
                    )
                }
            }
            .padding(.horizontal, 21)
            .padding(.vertical, 25)
            .background(Color.background)
        }
    }
}

#Preview {
    BottomSheet_Home()
}

// MARK: Components:
struct SectionListView: View {
    let title: String
    let items: [Destination]
    var isSearching: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .fontWeight(.bold)
                .foregroundColor(Color.customPrimary)

            Group {
                if items.isEmpty {
                Text("No results")
                    .italic()
                    .foregroundColor(Color.customPrimary.opacity(0.6))
                    .frame(maxWidth: .infinity, minHeight: 60)
                } else {
                    VStack(spacing: 7) {
                        ForEach(items) { dest in
                            Button {
                                // action...
                            } label: {
                                if items.count == 0 {
                                    Text("No Result Found")
                                }
                                HStack {
                                    ElementIcon(type: dest.elementIcon)
                                        .padding(.trailing, 7)
                                    Text(dest.name)
                                        .fontWeight(.semibold)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                            }
                            .padding(.vertical, 10)
                            
                            if dest.id != items.last?.id {
                                Divider().overlay(Color.customPrimary.opacity(1))
                            }
                        }
                    }
                    .padding(.horizontal, isSearching ? 0 : 17)
                    .padding(.vertical, 7)
                    .foregroundStyle(Color.customPrimary)
                    // MARK: Background nya ganti ke off white dikit (jgn trll white pkonya)
                    .background(
                        isSearching ? Color.clear : Color(white: 0.95)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                }
            }
        }
    }
}

struct QuickButton: View {
    let iconName: String
    let bgColor: Color

    var body: some View {
        Button {
            // action...
        } label: {
            Image(systemName: iconName)
                .font(.system(size: 24))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, minHeight: 60)
                .background(bgColor)
                .cornerRadius(12)
        }
    }
}


// MARK: View options
struct HomeContentView: View {
    let destinations: [Destination]
    @Binding var searchText: String

    var body: some View {
        VStack(spacing: 20) {
            // Quick Access
            VStack(alignment: .leading, spacing: 10) {
                Text("Quick Access Place / Facilities")
                    .font(.headline).fontWeight(.bold)
                    .foregroundColor(Color.customPrimary)
                HStack(spacing: 12) {
                    QuickButton(iconName: "toilet.fill",    bgColor: Color.elementBrown)
                    QuickButton(iconName: "parkingsign",    bgColor: Color.elementDarkGreen)
                    QuickButton(iconName: "cart.fill",      bgColor: Color.elementYellow)
                }
            }

            // Recommendations
            VStack(alignment: .leading, spacing: 8) {
                Text("Recommendations")
                    .fontWeight(.bold)
                    .foregroundColor(Color.customPrimary)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        Image_recommendation(imageName: .collab04LabApple,     location: "Lab Collab 4")
                        Image_recommendation(imageName: .toiletGOP9,           location: "Toilet GOP 9")
                        Image_recommendation(imageName: .kopiArabicaTheBreeze, location: "Kopi Arabica The Breeze")
                        Image_recommendation(imageName: .stairsToParking,      location: "Stairs to Parking")
                    }
                    .padding(.horizontal, 1)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            // Recents
            SectionListView(title: "Recents", items: destinations)

            // All Locations
            SectionListView(title: "All Locations", items: destinations)
        }
    }
}
