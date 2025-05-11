//
//  SelectedDestinationModal.swift
//  AR Navigation
//
//  Created by Gede Binar on 10/04/25.
//

import SwiftUI

struct SelectedDestinationModal: View {
    @Binding var showModal:Bool
    var onCancel : () -> Void
    var onConfirm : () -> Void
    var destName : String = "OK"
    var distance : String = "OK"
    var time : String = "OK"
    var scale : CGFloat = 45
    
    var body: some View {
        VStack {
            HStack(alignment:.top) {
                Image(destName)
                    .resizable()
                    .scaledToFit()
                    .frame(width:3 * scale,height: 4 * scale)
                VStack(alignment:.leading, spacing: 24){
                    Text(destName)
                        .font(.title2)
                        .bold()
//                        .padding(.bottom,10)
                        .foregroundStyle(Color.black)
//                        .frame(height: 1.3 * scale)
                        .padding(.top, 15)
                    VStack(alignment: .leading,spacing: 16){
                        HStack{
                            Image(systemName: "figure.walk")
                                .foregroundStyle(Color.gray)
                                .frame(width:20,height: 20)
                            Text("\(distance) m")
                                .font(.title3)
                                .bold()
                                .foregroundStyle(Color.gray)
                        }
                        HStack{
                            Image(systemName: "clock")
                                .foregroundStyle(Color.gray)
                                .frame(width:20,height: 20)
                            Text("\(time) min")
                                .font(.title3)
                                .bold()
                                .foregroundStyle(Color.gray)
                        }
                    }
                }
                .padding(.leading, 8)
                Spacer()
            }
            
            HStack(alignment: .bottom, spacing: 13.0){
                Button {
                    showModal = false
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
            .padding(.horizontal, 13.0)
            .padding(.top, 3)
            .padding(.bottom, 15)
        }//MainVstack
        .background(.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
//        .padding()
        
        
        
    }
}

#Preview {
    SelectedDestinationModal(
        showModal: .constant(true),
        onCancel: {},
        onConfirm: {},
        destName: "Kopi Persen The Breeze",
        distance: "600",
        time:"20"
    )
}
