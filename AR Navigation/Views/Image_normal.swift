//
//  Image_normal.swift
//  AR Navigation
//
//  Created by Reynard Hansel on 16/05/25.
//

import SwiftUI

struct Image_normal: View {
    let imageSrc: ImageResource
    
    var body: some View {
        Image(imageSrc)
            .resizable()
            .frame(width: 120, height: 150)
            .cornerRadius(12)
    }
}

#Preview {
    Image_normal(imageSrc: .colab41)
}
