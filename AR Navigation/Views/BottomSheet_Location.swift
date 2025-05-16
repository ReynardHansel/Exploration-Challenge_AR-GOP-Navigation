//
//  BottomSheet_Location.swift
//  AR Navigation
//
//  Created by Reynard Hansel on 16/05/25.
//

import SwiftUI

struct BottomSheet_Location: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Group {
                    // MARK: - Top Bar
                    HStack {
                        Text("Apple Developer Academy")
                            .font(.title)
                            .fontWeight(.bold)
                        Spacer()
                        Image(systemName: "xmark.circle")
                            .font(.system(size: 27, weight: .medium))
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
                
                
               
            }
            .padding(.horizontal, 21)
            .padding(.vertical, 25)
            .background(Color.background)
        }
    }
}

#Preview {
    BottomSheet_Location()
}
