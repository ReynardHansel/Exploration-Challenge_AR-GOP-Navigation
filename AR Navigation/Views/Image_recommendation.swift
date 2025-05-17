//
//  Image_recommendation.swift
//  AR Navigation
//
//  Created by Reynard Hansel on 15/05/25.
//

import SwiftUI

struct Image_recommendation: View {
    let location: Destination
    @ObservedObject private var vm = NavigationHomeViewModel.shared

    var body: some View {
        let imgResource = location.images?.first ?? .gopLogo
        
        Button {
//            print("Button tapped 1")
            vm.selectedDestination = location
            vm.showLocationBottomSheet.toggle()
            vm.resetDetent = .fraction(0.09)
//            print("Button tapped 2")
        } label: {
            ZStack(alignment: .bottomLeading) {
                Image(imgResource)
                    .resizable()
                    .frame(width: 120, height: 150)
                    .cornerRadius(12)
                    .overlay(
                        // Gradient overlay
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.black.opacity(0.0),
                                Color.black.opacity(1),
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .cornerRadius(12)
                    )

                // Text content
                VStack(alignment: .leading, spacing: 2) {
                    Text(location.name)
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(.white)
                        .padding(5)
                    //                Text("Some text")
                    //                    .font(.subheadline)
                    //                    .foregroundColor(.white.opacity(0.85))
                }
                .padding(8)
            }
            .frame(width: 120, height: 150)
        }
    }
}

//#Preview {
//    Image_recommendation(location: )
//}
