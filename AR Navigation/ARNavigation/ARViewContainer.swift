import SwiftUI
import RealityKit
import CoreLocation


struct ARViewContainer: UIViewRepresentable {
    
    let modelName: String
    let axis = normalize(SIMD3<Float>(x: 0, y: 1, z: 0))
    @Binding var angle : Float
    
    
    
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .infinite)
        arView.scene.anchors.removeAll()
        
        let arrow = try! ModelEntity.load(named: "Direction_Arrow.usdz")
        
        let scalingPivot = Entity()
        scalingPivot.name = "arrowPivot"
        scalingPivot.position.y = arrow.visualBounds(relativeTo: nil).center.y
        scalingPivot.addChild(arrow)
        
        // compensating a robot position
        arrow.position.y -= scalingPivot.position.x
        
        let anchor = AnchorEntity(.camera)
        anchor.addChild(scalingPivot)
        arView.scene.addAnchor(anchor)
        
        scalingPivot.position = [0,-0.38,-1.2]
//        scalingPivot.position = [0,-0.4,-1.2]
        scalingPivot.scale = [0.2,0.2,0.2]
        //scalingPivot.orientation = simd_quatf(angle: angel, axis: axis)
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        
        let rotateEntity : Entity = uiView.scene.findEntity(named: "arrowPivot") ?? Entity()
        rotateEntity.position = [0,-0.38,-1.2]
        rotateEntity.orientation = simd_quatf(angle: angle - (.pi / 2 + .pi), axis: axis)
        
    }
}
