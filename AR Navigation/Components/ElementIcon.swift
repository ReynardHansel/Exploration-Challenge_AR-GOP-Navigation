//
//  ElementComponents.swift
//  AR Navigation
//
//  Created by Reynard Hansel on 12/05/25.
//

import SwiftUI

enum ElementIconType: String {
    case building = "Building"
    case toilet = "Toilet"
    case parking = "Parking"
    case grocery = "Grocery"
    case other = "Other"
    
    var systemName: String {
        switch self {
        case .building:
            return "building.2.fill"
        case .toilet:
            return "toilet.fill"
        case .parking:
            return "parkingsign"
        case .grocery:
            return "cart.fill"
        case .other:
            return "mappin"
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .building:
            return Color.elementLightGreen
        case .toilet:
            return Color.elementBrown
        case .parking:
            return Color.elementDarkGreen
        case .grocery:
            return Color.elementYellow
        case .other:
            return Color.elementBrokenBrown
        }
    }
}

struct ElementIcon: View {
    let type: ElementIconType
    let size: CGFloat = 60
    
    var body: some View {
        Image(systemName: type.systemName)
            .resizable()
            .scaledToFit()
            .frame(width: size * 0.5, height: size * 0.5)
            .foregroundColor(.white)
            .padding()
            .background(type.backgroundColor)
            .clipShape(Circle())
    }
}

#Preview {
    HStack(spacing: 24) {
        ElementIcon(type: .building)
        ElementIcon(type: .parking)
        ElementIcon(type: .toilet)
        ElementIcon(type: .grocery)
        ElementIcon(type: .other)
    }
//    .padding()
//    .background(Color.black)
}
