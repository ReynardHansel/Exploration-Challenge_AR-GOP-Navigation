//
//  ArrivedAtDestinationModal.swift
//  AR Navigation
//
//  Created by Gede Binar on 08/04/25.
//

import SwiftUI

struct ArrivedAtDestinationModal: View {
    @Binding var showModal:Bool
    //@Binding var path : NavigationPath
    @Environment(\.dismiss) var dismiss
    @State var pathFindingManager : PathfindingManager
//    var onCancel: () -> Void
    
    var body: some View {
        HStack{
            Spacer()
            VStack(spacing:24){
                Spacer()
            
                VStack {
                    //Checklist
                    Image(systemName: "checkmark.circle")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.green)
                } .frame(width: 160,height:160)
                   
                    
                Text("You arrived !")
                    .bold()
                    .font(.title)
                    .foregroundStyle(Color.black)
//                    .padding(.bottom,24)
                Button {
                    showModal = false
                    pathFindingManager.ResetPathfinder()
                    dismiss()
                } label: {
                    Text("Return To Map")
                        .font(.subheadline)
                        .bold()
                        .foregroundStyle(.white)
//                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(12)
                }
                Spacer()
            }
            Spacer()
        }.background(Color.white)
  
    }
}
//
#Preview {
    @Previewable @State var showModal = true
    @Previewable @State var path = NavigationPath()
    ArrivedAtDestinationModal(
        showModal: $showModal,
        pathFindingManager: PathfindingManager()
    )
}
