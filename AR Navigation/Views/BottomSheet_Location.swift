//
//  BottomSheet_Location.swift
//  AR Navigation
//
//  Created by Reynard Hansel on 16/05/25.
//

import SwiftUI

struct BottomSheet_Location: View {
    let locData: Destination
    @State private var isAboutExpanded = false
    @ObservedObject private var navVM = NavigationHomeViewModel.shared

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // MARK: - Navigation Area
                Group {
                    // MARK: - Top Bar
                    HStack {
                        Text(locData.name)
                            .font(.title)
                            .fontWeight(.bold)
                            .frame(maxWidth: 280, alignment: .leading)
                        Spacer()
                        
                        Button {
                            navVM.showLocationBottomSheet.toggle()
                        } label: {
                            Image(systemName: "xmark.circle")
                                .font(.system(size: 27, weight: .medium))
                        }
                    }
                    .foregroundStyle(Color.customPrimary)

                    // MARK: - CTA
                    HStack {
                        VStack(alignment: .leading) {
                            Text("8 min")
                                .font(.title2)
                                .fontWeight(.heavy)

                            Text("560 m")
                                .font(.title3)
                                .fontWeight(.medium)
                        }
                        .foregroundStyle(Color.customPrimary)

                        Spacer()

                        Button {
                            // Start Navigation
                        } label: {
                            Text("GO")
                                .font(.headline)
                                .fontWeight(.heavy)
                                .foregroundStyle(Color.white)
                                .padding(.horizontal, 23)
                                .padding(.vertical, 15)
                                .background(Color.elementLightGreen)
                                .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal, 22)
                    .padding(.vertical, 15)
                    .background(Color.customGold)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }

                Divider()
                    .frame(height: 1)
                    .overlay(Color.customPrimary)

                // MARK: - Info Area
                Group {
                    // MARK: - Images
                    //! Read notes about this below all code
                    if let images = locData.images, !images.isEmpty {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                ForEach(images, id: \.self) { imageRes in
                                    Image_normal(imageSrc: imageRes)
                                }
                            }
                        }
                    }

                    // MARK: - About
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text("About")
                                .font(.headline).fontWeight(.bold)
                                .foregroundColor(Color.customPrimary)

                            Spacer()

                            if let about = locData.description,
                                about.count > 100
                            {
                                Button {
                                    withAnimation {
                                        isAboutExpanded.toggle()
                                    }
                                } label: {
                                    Text(
                                        isAboutExpanded
                                            ? "Read Less" : "Read More"
                                    )
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.blue)
                                }
                            }
                        }

                        if let about = locData.description, !about.isEmpty {
                            Text(about)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                                .lineLimit(isAboutExpanded ? nil : 3)
                                .foregroundStyle(.customPrimary)
                                .animation(.easeInOut, value: isAboutExpanded)
                                .background(Color.backgroundOffedWhite)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.customPrimary, lineWidth: 1))
                        }
                    }
                    
                    // MARK: - Address
                    if let address = locData.address {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Address")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(Color.customPrimary)

                            Text(address)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                                .foregroundStyle(.customPrimary)
                                .background(Color.backgroundOffedWhite)
                                .cornerRadius(12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.customPrimary, lineWidth: 1)
                                )
                        }
                    }

                }

            }
            .padding(.horizontal, 21)
            .padding(.vertical, 25)
            .background(Color.background)
        }
    }
}

#Preview {
    let destination = showcaseDestination.last

    BottomSheet_Location(locData: destination!)
}

/// NOTE:
/// 1. locData.images is optional—you can’t hand an optional array to ForEach directly.
/// 2. ForEach needs to know how to identify each element—either your type must conform to Identifiable (or you pass an id:).
///
/// The simplest, clearest way to fix both is to:
///
/// 1. if let images = locData.images unwrap the optional.
/// 2. Use ForEach(images, id: \.self) (requires ImageResource: Hashable—which it presumably is, since it’s an enum).
