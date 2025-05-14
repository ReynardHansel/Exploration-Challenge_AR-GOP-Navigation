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
    case FnB = "FnB"
    
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
        case .FnB:
            return "fork.knife"
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
        case .FnB:
            return Color.elementOrange
        case .other:
            return Color.elementBrokenBrown
        }
    }
}

struct ElementIcon: View {
    let type: ElementIconType
    let size: CGFloat = 40
    
    var body: some View {
        Image(systemName: type.systemName)
            .resizable()
            .scaledToFit()
            .frame(width: size * 0.5, height: size * 0.5)
            .foregroundColor(.white)
            .padding(8)
            .background(type.backgroundColor)
            .clipShape(Circle())
    }
}

#Preview {
    LazyVStack(spacing: 24) {
        ElementIcon(type: .building)
        ElementIcon(type: .parking)
        ElementIcon(type: .toilet)
        ElementIcon(type: .grocery)
        ElementIcon(type: .other)
        ElementIcon(type: .FnB)
    }
//    .padding()
//    .background(Color.black)
}
