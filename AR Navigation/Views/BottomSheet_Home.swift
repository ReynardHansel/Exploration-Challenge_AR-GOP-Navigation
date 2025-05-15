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
            VStack(spacing: 20.0) {
                // MARK: - Search Bar
                TextField(
                    "", text: $searchText,
                    prompt:
                        Text("Search your destination...")
                        .foregroundStyle(Color.customPrimary.opacity(0.5))
                )
                .padding(12)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 6))
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color.customPrimary, lineWidth: 1)
                )
                
                // MARK: - Quick Access Buttons
                VStack(alignment: .leading, spacing: 10.0) {
                    Text("Quick Access Place / Facilities")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(Color.customPrimary)
                    HStack {
                        QuickButton(
                            iconName: "toilet.fill", bgColor: Color.elementBrown)
                        QuickButton(
                            iconName: "parkingsign", bgColor: Color.elementDarkGreen
                        )
                        QuickButton(
                            iconName: "cart.fill", bgColor: Color.elementYellow)
                    }
                }
                
                // MARK: - Recommendedations
                VStack(alignment: .leading) {
                    Text("Recommendations")
                        .fontWeight(.bold)
                        .foregroundColor(Color.customPrimary)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            Image_recommendation(imageName: .collab04LabApple, location: "Lab Collab 4")
                            Image_recommendation(imageName: .toiletGOP9, location: "Toilet GOP 9")
                            Image_recommendation(imageName: .kopiArabicaTheBreeze, location: "Kopi Arabica The Breeze")
                            Image_recommendation(imageName: .stairsToParking, location: "Stairs to Parking")
                        }
                        .padding(.horizontal, 1) // Optional: gives a little breathing room
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                // MARK: - Recents
                VStack(alignment: .leading) {
                    Text("Recents")
                        .fontWeight(.bold)
                        .foregroundColor(Color.customPrimary)
                    
                    VStack(spacing: 7) {
                        ForEach(destinations) { destination in
                            HStack {
                                ElementIcon(type: destination.elementIcon)
                                    .padding(.trailing, 7)
                                Text(destination.name)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .fontWeight(.semibold)
                            }
                            .padding(.vertical, 10)
                            
                            if destination.id != destinations.last?.id {
                                Divider()
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .foregroundStyle(Color.customPrimary)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 6)
//                            .stroke(Color.customPrimary, lineWidth: 1)
//                    )
                }
                
                // MARK: - All Locations
                VStack(alignment: .leading) {
                    Text("All Locations")
                        .fontWeight(.bold)
                        .foregroundColor(Color.customPrimary)
                    
                    VStack(spacing: 7) {
                        ForEach(destinations) { destination in
                            HStack {
                                ElementIcon(type: destination.elementIcon)
                                    .padding(.trailing, 7)
                                Text(destination.name)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .fontWeight(.semibold)
                            }
                            .padding(.vertical, 10)
                            
                            if destination.id != destinations.last?.id {
                                Divider()
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .foregroundStyle(Color.customPrimary)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 6)
//                            .stroke(Color.customPrimary, lineWidth: 1)
//                    )
                }
            }
            .padding(.horizontal, 21.0)
            .padding(.vertical, 25.0)
            .background(Color.background)
        }

    }
}

#Preview {
    BottomSheet_Home()
}

// MARK: Components:
struct QuickButton: View {
    let iconName: String
    let bgColor: Color

    var body: some View {
        Button(action: {
            // handle action
        }) {
            Image(systemName: iconName)
                .font(.system(size: 24))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, minHeight: 60)
                .background(bgColor)
                .cornerRadius(12)
        }
    }
}
