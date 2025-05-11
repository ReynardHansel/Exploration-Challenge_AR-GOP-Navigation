//
//  ARNavigationView.swift
//  AR Navigation
//
//  Created by Gede Binar on 07/04/25.
//

import SwiftUI
import RealityKit
import CoreLocation

struct ARNavigationView: View {
    @StateObject var pathfindingManager : PathfindingManager
    @StateObject var locationDataManager : LocationDataManager
    
    @State var showEasterEgg: Bool = false
    @State var showAlert:Bool = false
    
    @ViewBuilder func ShowStat() -> some View{
        VStack{
            Text("Destination : \(locationDataManager.currentPath[locationDataManager.userNodeIndex].nodeName)")
            Divider()
            Text("Target heading \(String(format:"%.2f",locationDataManager.targetDirectionInDegrees))")
            Text("User heading :\(String(format:"%.2f",locationDataManager.userHeadingInDegrees))")
            Divider()
            Text("Rotate Towards : \(String(format: "%.2f",locationDataManager.targetDirectionInDegrees - locationDataManager.userHeadingInDegrees))")
            Divider()
            Text("Distance to target : \(String(format: "%.2f",locationDataManager.distanceToTarget))")
        }.padding()
    }
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ARViewContainer(
            modelName: "Direction_Arrow",
            angle: $locationDataManager.userHasToHeadInRadians
        )
        
        .overlay(alignment: .bottom, content: {
            NavigationToolbarView(
                onCancel: {
                    showAlert = true
                },
                destinationName: pathfindingManager.destinationName,
                distance: String(format:"%.0f",pathfindingManager.destinationName),
                time: String(format:"%.0f",pathfindingManager.estimateCumulativeDistance * 0.3),
                onEgg: {
                    showEasterEgg.toggle()
                }
            )
        })
        .overlay{
            VStack{
                if showEasterEgg {
                    ShowStat()
                    ZStack{
                        Button("Change Destination"){
                            locationDataManager.cycleLocation()
                        }
                    }
                }
               
            }
            
        }
        .overlay{
            if locationDataManager.hasArrived{
                ArrivedAtDestinationModal(
                    showModal: $locationDataManager.hasArrived ,
                    pathFindingManager: pathfindingManager)
            }
        }
        .alert(
            "Exit Navigation?",
            isPresented: $showAlert
        ){
            Button(role: .destructive) {
                // Handle the deletion.
                pathfindingManager.ResetPathfinder()
                dismiss()
            } label: {
                Text("Exit Navigation")
            }
            Button(role: .cancel) {
                showAlert = false
            } label: {
                Text("Cancel")
            }
        } message: {
            Text("Are you sure you want to stop navigation? Your current route will be lost.")
        }
//        .alert(isPresented: $showAlert) {
//            Alert(
//                title: Text("Exit Navigation?"),
//                message: Text("Are you sure you want to stop navigation? Your current route will be lost."),
//                primaryButton: .default(
//                    Text("Return Home"),
//                    action: {
//                        pathfindingManager.ResetPathfinder()
//                        dismiss()
//                    }
//                ),
//                secondaryButton: .cancel(
//                    Text("Cancel"),
//                    action: {
//                        showAlert
//                        = true                        }
//                )
//            )
//        }
    }
}

struct NavigationToolbarView : View {
    var onCancel : () -> Void
    var destinationName : String
    var distance : String
    var time :String
    var onEgg : () -> Void
    
    var body: some View {
        VStack{
            HStack(spacing:30){
                Button{
                    onCancel()
                    
                } label: {
                    Image(systemName: "multiply.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32,height: 32)
                        .foregroundStyle(Color.red)
                }
                VStack{
                    Text("\(destinationName)")
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(Color.black)
                        .bold()
                    HStack(spacing:20) {
                        
                        Image(systemName: "figure.walk")
                            .resizable()
                            .scaledToFit()
                            .padding(.trailing,-10)
                            .foregroundStyle(Color.gray)
                        Text("\(distance) m")
                            .font(.subheadline)
                            .foregroundStyle(Color.gray)
                            .bold()
                        Image(systemName: "clock")
                            .resizable()
                            .scaledToFit()
                            .padding(.trailing,-10)
                            .foregroundStyle(Color.gray)
                        Text("\(time) min")
                            .font(.subheadline)
                            .foregroundStyle(Color.gray)
                            .bold()
                    }.frame(height: 24)
                }

                Spacer()
                Button("egg"){
                    onEgg()
                }
                .foregroundStyle(.white)
                .frame(width: 10,height: 10)
            }
            .padding()
        }
        .frame(height: 100 ) //88
        .background(Color.white)
        .clipShape(
            .rect(
                topLeadingRadius: 24,
                bottomLeadingRadius: 0,
                bottomTrailingRadius: 0,
                topTrailingRadius: 24
            )
        )
    }
}

#Preview {
    ARNavigationView(
        pathfindingManager: PathfindingManager(), locationDataManager: LocationDataManager()
    )
}
