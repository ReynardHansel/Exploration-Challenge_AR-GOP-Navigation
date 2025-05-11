//
//  PathNode.swift
//  AR Navigation
//
//  Created by Gede Binar on 07/04/25.
//

import Foundation
import CoreLocation

struct NodeConnection{
    var nodeIndex: Int
    var distance: Float
}

class PathNode {
    var nodeIndex : Int
    var nodeName : String = "Nama"
    var nodeConnections : [NodeConnection] = []
    var nodeCoordinate : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    
    var estimateCumulativeDistance: Float = Float.infinity
    var explored: Bool = false
    var previousNodeIndex : Int = -1
    
    
    init(nodeIndex : Int, nodeConnections :[NodeConnection], nodeName: String = "Name",nodeCoordinate : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)){
        self.nodeIndex = nodeIndex
        self.nodeConnections = nodeConnections
        self.nodeName = nodeName
        self.nodeCoordinate = nodeCoordinate
    }
    
    func ResetNode (){
        explored = false
        estimateCumulativeDistance = 1000
        previousNodeIndex = -1
    }
}
