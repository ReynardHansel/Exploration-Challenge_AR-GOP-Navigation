//
//  MainView.swift
//  AR Navigation
//
//  Created by Gede Binar on 08/04/25.
//

import SwiftUI

struct MainView: View {
    @State var path = NavigationPath()
    @StateObject var locationDataManager : LocationDataManager = LocationDataManager()
    @StateObject var pathFindingManager : PathfindingManager = PathfindingManager()
    
    let destination = showcaseDestination.first
    
    var body: some View {
//        NavigationStack(path: $path) {
//            AnimatedLogoSplashView(path: $path)
//            .navigationBarHidden(true)
//            .navigationDestination(for: String.self) { view in
//                if view == "ARView" {
//                    ARNavigationView(
//                        pathfindingManager: pathFindingManager,
//                        locationDataManager: locationDataManager
//                    )
//                    .navigationBarHidden(true)
//                }
//                if(view == "NavHome"){
//                    NavigationHomeScreen(
//                        path: $path,
//                        locationDataManager: locationDataManager,
//                        pathFindingManager: pathFindingManager)
//                    .navigationBarHidden(true)
//                }
//            }
//        }
//        BottomSheet_Home()
        BottomSheet_Location(locData: destination!)
//        NavigationHomeScreen(
//            path: $path,
//            locationDataManager: locationDataManager,
//            pathFindingManager: pathFindingManager
//        )
    }
}

#Preview {
    MainView()
}
