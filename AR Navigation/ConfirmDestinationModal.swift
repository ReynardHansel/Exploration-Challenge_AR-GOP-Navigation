//
//  ConfirmDestinationModal.swift
//  AR Navigation
//
//  Created by Reynard Hansel on 07/04/25.
//

import SwiftUI

struct ConfirmDestinationModal: View {
    @Binding var showModal:Bool
    @Binding var path : NavigationPath
    var onCancel : () -> Void
    var onConfirm : () -> Void
    var destName : String = "OK"
    var distance : String = "OK"
    var time : String = "OK"
    
    var body: some View {
        
                VStack(spacing: 0) {
                    HStack(alignment:.top){
                        Image(destName)
                            .resizable()
                            .scaledToFit()
                            .frame(
                                width: 120, // 3 (135)
                                height: 160 // 4 (180)
                            )
                            .padding()
                        VStack (alignment: .leading){
                            Text(destName)
                                .font(.title2)
                                .bold()
                                .padding(.bottom,10)
                                .foregroundStyle(Color.black)
                            VStack(alignment: .leading , spacing: 20){
                                HStack {
                                    Image(systemName: "figure.walk")
                                        .foregroundStyle(Color.gray)
                                    Text("\(distance) m")
                                        .font(.headline)
                                        .foregroundStyle(Color.gray)
                                }
                                HStack {
                                    Image(systemName: "clock")
                                        .foregroundStyle(Color.gray)
                                    Text("\(time) min")
                                        .font(.headline)
                                        .foregroundStyle(Color.gray)
                                }
                            }
                            
                        }.padding()
                        Spacer()
                    }
                    HStack(spacing: 12) {
                        

                        Button {
                            showModal = false
                            path.append("ARView")
                            onConfirm()
                            // MARK: Confirm destination
                        } label: {
                            Text("Navigate")
                                .bold()
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(12)
                        }
                        Button {
                            showModal = false
                            // MARK: Close modal
                            onCancel()
                        } label: {
                            Text("Cancel")
                                .bold()
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(12)
                        }
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
    }
}

#Preview {
    
    ConfirmDestinationModal(
        showModal: .constant(true),
        path: .constant(NavigationPath()),
        onCancel: {},
        onConfirm: {},
        destName: "Kopi Persen The Breeze",
        distance: "600",
        time:"20"
    )
}

