//
//  CustomMapAnnotation.swift
//  AR Navigation
//
//  Created by Reynard Hansel on 18/05/25.
//

import SwiftUI

struct CustomMapAnnotation: View {
    let location: Destination

    // 1) Shared nav VM
    @ObservedObject private var navVM = NavigationHomeViewModel.shared

    // 2) Are we the currently selected pin?
    private var isSelected: Bool {
        navVM.selectedDestination?.id == location.id
    }

    // 3) Bounce state
    @State private var bounceValue: CGFloat = 0

    var body: some View {
        VStack(spacing: 0) {
            // — Info bubble when selected
            if isSelected {
                VStack(alignment: .leading, spacing: 4) {
                    Text(location.description ?? "")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(3)
                        .multilineTextAlignment(.leading)
//                        .fixedSize(horizontal: true, vertical: true)
                        .frame(width: 230, height: 70, alignment: .leading)
                }
                .padding(8)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.white)
                        .shadow(color: Color.black.opacity(0.2), radius: 4)
                )
                .offset(y: -5)
                .padding(.bottom, 5)
                .transition(.scale.combined(with: .opacity))
            }

            ZStack {
                // • Shadow
                Circle()
                    .fill(Color.black.opacity(0.1))
                    .frame(width: 44, height: 44)
                    .offset(y: 2)

                // • Pin
                Circle()
                    .fill(location.color)
                    .frame(width: 40, height: 40)
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    .overlay(
                        Image(systemName: location.icon)
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.white)
                    )
                    .scaleEffect(1 + bounceValue)

                // • Pulse
                Circle()
                    .fill(location.color.opacity(0.3))
                    .frame(width: 40, height: 40)
                    .scaleEffect(isSelected ? 1.5 : 1)
                    .opacity(isSelected ? 0 : 0.3)
                    .animation(
                        isSelected
                            ? Animation.easeOut(duration: 1.2).repeatForever(autoreverses: false)
                            : .default,
                        value: isSelected
                    )
            }
//            .offset(y: -bounceValue * 5)
        }
        .onTapGesture {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
              if navVM.selectedDestination?.id == location.id {
                // tapped the already-selected pin → deselect & hide sheet
                navVM.selectedDestination = nil
                navVM.showLocationBottomSheet = false
              } else {
                // tapped a new pin → select & show sheet
                  navVM.select(destination: location)
//                navVM.selectedDestination = location
//                navVM.showLocationBottomSheet = true
//                navVM.resetDetent = .fraction(0.09)
              }
            }
        }
//        .onChange(of: isSelected) { selected in
//            // when we become selected, do a quick bounce
//            guard selected else { return }
//            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
//                bounceValue = 0.1
//            }
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
//                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
//                    bounceValue = 0
//                }
//            }
//        }
    }
}

#Preview {
    let destination = showcaseDestination.last

    CustomMapAnnotation(location: destination!)
}
