//
//  SearchResult.swift
//  AR Navigation
//
//  Created by Reynard Hansel on 27/03/25.
//

import SwiftUI
import MapKit
import CoreLocation

struct SearchResult: View {
    let destinations: [Destination]
    @Binding var selectedDestination: Destination?
    @StateObject var pathFindingManager : PathfindingManager
    @StateObject var locationDataManager : LocationDataManager
    @Binding var showModal:Bool
    @Binding var fieldText:String
    @Binding var cameraPosition: MapCameraPosition
    @FocusState<Bool>.Binding var isSearchBarFocused: Bool

    //      TESTING PURPOSES
    //    @State var previewSelectedDestination: Destination?

    var body: some View {
        ScrollView {
            VStack {
                if destinations.count == 0 {
                    Text("No Result Found")//No Result Found / No Location/Destination Found
                        .padding(.vertical, 10)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.white)
                        .cornerRadius(15)
                        .padding(.horizontal, 20)
                        .foregroundStyle(Color.black)
                }
                ForEach(destinations) { destination in
                    Button {
//                        selectedDestination = destination
                        fieldText = destination.name
                        pathFindingManager.ResetPathfinder()
                        locationDataManager.ResetPath()
                        let currentLocation : CLLocationCoordinate2D = locationDataManager.locationManager.location?.coordinate ?? CLLocationCoordinate2D(latitude: 0, longitude: 0)
                        pathFindingManager.FindNewPath(
                            userCoordinate: currentLocation,
                            destinationName: destination.name
                        )
//                        print(pathFindingManager.pathCoordinate)
//                        print(pathFindingManager.pathNodes)
//                        print("-----------------")
                        
                        locationDataManager.currentPath = pathFindingManager.pathNodes
                        showModal = true
                        
                        //print(locationDataManager.currentPath)
                        
                        selectedDestination = destination
                        
                        // MARK: Camera Zoom position
                        let zoomCoordinates = [currentLocation, destination.destinationCoordinate]
                        let zoomRegion = calculateRegionToFit(coordinates: zoomCoordinates)
                        cameraPosition = .region(zoomRegion!)
                        
                        isSearchBarFocused = false
                        
                        //                    previewSelectedDestination = destination
                        //                    print("Selected destination:
                        
                    } label: {
                        Text(destination.name)
                            .padding(.vertical, 10)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.white)
                            .cornerRadius(15)
                            .padding(.horizontal, 20)
                            .foregroundStyle(.black)
                    }
                }
            }
            .background(Color.white)
            .cornerRadius(15)
            
        }
        .fixedSize(horizontal: false, vertical: true)

        // TESTING PURPOSES
        // Text("Selected: \(previewSelectedDestination?.name ?? "Not Selected")")
    }
}

//#Preview {
//    SearchResult(
//        destinations: destinationDBnew,
//        selectedDestination: .constant(nil),
//        pathFindingManager: PathfindingManager(),
//        locationDataManager: LocationDataManager(),
//        showModal: .constant(false),
//        fieldText: .constant(""),
//        cameraPosition: .constant(.region(MKCoordinateRegion(
//            center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
//            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
//        )))
//    )
//}

//* NOTE:
//*
//******************** About .constant(nil) *******************
//* In SwiftUI’s #Preview, @Binding must be connected to a real state, but previews don’t maintain state by default.

//* So, instead of passing a real @State variable (which isn't possible in simple previews), we provide a fixed, non-changing value using .constant(nil).
