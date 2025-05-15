//
//  Image_recommendation.swift
//  AR Navigation
//
//  Created by Reynard Hansel on 15/05/25.
//

import SwiftUI

struct Image_recommendation: View {
    var imageName: ImageResource
    var location: String
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(imageName)
                .resizable()
                .frame(width: 120, height: 150)
                .cornerRadius(12)
                .overlay(
                    // Gradient overlay
                    LinearGradient(
                        gradient: Gradient(colors: [Color.black.opacity(0.0), Color.black.opacity(1)]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .cornerRadius(12)
                )
            
            // Text content
            VStack(alignment: .leading, spacing: 2) {
                Text(location)
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

#Preview {
    Image_recommendation(imageName: .collab04LabApple, location: "Apple")
}
