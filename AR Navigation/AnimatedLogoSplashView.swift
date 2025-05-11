//
//  ContentView.swift
//  mybrt
//
//  Created by Camilla Tiara Dewi on 25/03/25.
//

import SwiftUI

struct AnimatedLogoSplashView: View {
    @State private var animate = false
    @State private var showText = false
    @Binding var path : NavigationPath
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            
            VStack(spacing: 10) { // reduced spacing for closer layout
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 800, height: 500)
                    .scaleEffect(animate ? 1.0 : 0.4)
                    .opacity(animate ? 1 : 0.8)
                    .onAppear {
                        withAnimation(.easeOut(duration: 2.0)) {
                            animate = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                            withAnimation(.easeIn(duration: 1.0)) {
                                showText = true
                            }
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0){
                            path.append("NavHome")
                        }
                    }
                
                if showText {
                    Text("Navigate GOP faster and easier with your camera")
                        .italic()
                        .font(.system(size:14))
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .padding(.top,-180)
                        .transition(.opacity)
                    
                }
            }
        }
    }
}

#Preview {
    AnimatedLogoSplashView(
        path: .constant(NavigationPath())
    )
}
