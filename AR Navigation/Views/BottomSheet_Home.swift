//
//  BottomSheet_Home.swift
//  AR Navigation
//
//  Created by Reynard Hansel on 09/05/25.
//

import SwiftUI

struct BottomSheet_Home: View {
    let destinations = showcaseDestination
    @State private var searchText = ""

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // MARK: - Search Bar
                HStack {
                    // MARK: Magnifying Glass
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(Color.customPrimary.opacity(0.8))

                    // MARK: Input
                    TextField(
                        "",
                        text: $searchText,
                        prompt: Text("Search your destination…")
                            .foregroundStyle(Color.customPrimary.opacity(0.5))
                    )

                    // MARK: Clear Button
                    if !searchText.isEmpty {
                        Button {
                            searchText = ""
                        } label: {
                            Image(systemName: "xmark.circle")
                                .foregroundStyle(Color.red)
                        }
                    }
                }
                .padding(12)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 6))
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color.customPrimary, lineWidth: 1)
                )


                // MARK: Content
                HomeContentView(destinations: destinations, searchText: $searchText)
                
                
            }
            .padding(.horizontal, 21)
            .padding(.vertical, 30)
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

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .fontWeight(.bold)
                .foregroundColor(Color.customPrimary)

            VStack(spacing: 7) {
                ForEach(items) { dest in
                    Button {
                        
                    } label: {
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
                        Divider()
                    }
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            .foregroundStyle(Color.customPrimary)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 6))
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

    // you can filter here if you want
    private var filtered: [Destination] {
        guard !searchText.isEmpty else { return destinations }
        return destinations.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }

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
