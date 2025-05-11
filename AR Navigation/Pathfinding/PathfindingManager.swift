//
//  PathfindingManager.swift
//  AR Navigation
//
//  Created by Gede Binar on 07/04/25.
//

import Foundation
import CoreLocation

class PathfindingManager : ObservableObject {
    
    let nodes = PathNodeContainer.testingShowcaseNodes
    @Published var pathNodes : [PathNode] = []
    @Published var pathCoordinate : [CLLocationCoordinate2D] = []
    @Published var estimateDistances :[Float] = []
    @Published var estimateCumulativeDistance : Float = 0
    @Published var destinationName : String = "Destination"
    
    func ResetPathfinder(){
        for node in nodes {
            node.ResetNode()
        }
        pathNodes = []
        pathCoordinate = []
        estimateDistances = []
        destinationName = "Destination"
    }
    
    func FindNewPath (userCoordinate : CLLocationCoordinate2D, destinationName:String){
        // Search for target and origin nodes
        var targetNode : PathNode = PathNode(nodeIndex: -1, nodeConnections: [])
        self.destinationName = destinationName
        var minDis : Double = 1000000
        var minNode = -1
        
        for nd in nodes {
            if(nd.nodeName == destinationName){
                targetNode = nd
            }
            let dis = getDistanceBetweenCoordinate(coordinate1: userCoordinate, coordinate2: nd.nodeCoordinate)
            if(dis < minDis){
                minDis = dis
                minNode = nd.nodeIndex
            }
        }
        // Safety
        if(targetNode.nodeIndex == -1 || minNode == -1){
            print("error")
            return
        }
        let originNode : PathNode = nodes[minNode]
        
        originNode.estimateCumulativeDistance = 0
        originNode.previousNodeIndex = 0
        EstimateAndExplore(currentNode: originNode, originNode: originNode)
        
        var pathNodeCoordinate : [CLLocationCoordinate2D] = []
        var prevNode = targetNode
        estimateCumulativeDistance = targetNode.estimateCumulativeDistance
        pathNodes.append(prevNode)
        pathNodeCoordinate.append(prevNode.nodeCoordinate)
        while prevNode.nodeIndex != originNode.nodeIndex {
            for nd in prevNode.nodeConnections{
                if nd.nodeIndex == prevNode.nodeIndex {
                    estimateDistances.insert(nd.distance, at: 0)
                    break
                }
            }
            prevNode = nodes[prevNode.previousNodeIndex]
//            pathNodes.append(prevNode)
//            path.append(prevNode.nodeCoordinate)
            pathNodes.insert(prevNode, at: 0)
            pathNodeCoordinate.insert(prevNode.nodeCoordinate, at: 0)
        }
        pathNodeCoordinate.insert(userCoordinate, at: 0)
        pathCoordinate = pathNodeCoordinate
        
    }
    
    func getDistanceBetweenCoordinate(coordinate1 : CLLocationCoordinate2D, coordinate2:CLLocationCoordinate2D) -> CLLocationDistance{
        let location1 = CLLocation(latitude: coordinate1.latitude, longitude: coordinate1.longitude)
        let location2 = CLLocation(latitude: coordinate2.latitude, longitude: coordinate2.longitude)
        return location1.distance(from: location2)
    }
    
    func FindPath (originNodeIdx : Int, targetNodeIdx : Int){
        print("ou")
        pathNodes = []
        let originNode = nodes[originNodeIdx]
        //let targetNode = nodes[targetNodeIdx]
        
        originNode.estimateCumulativeDistance = 0
        originNode.previousNodeIndex = 0
        EstimateAndExplore(currentNode: originNode, originNode: originNode)
        
        var path : [CLLocationCoordinate2D] = []
        var prev = targetNodeIdx
        pathNodes.append(nodes[prev])
        path.append(nodes[prev].nodeCoordinate)
        while prev != originNodeIdx {
            prev = nodes[prev].previousNodeIndex
            pathNodes.append(nodes[prev])
            path.append(nodes[prev].nodeCoordinate)
        }
        //print("pathCoordinate : \(path)")
        pathCoordinate = path
        
    }
        
    func getPathTest (){
        var coorPath : [CLLocationCoordinate2D] = []
        for nd in PathNodeContainer.testingNodes3{
            coorPath.append(nd.nodeCoordinate)
        }
        pathCoordinate = coorPath
        
    }
    
    func EstimateAndExplore (currentNode : PathNode, originNode :PathNode){
        currentNode.explored = true
        
        // Update Estimate Distance
        for nodeConnection in currentNode.nodeConnections {
            let targetNode = nodes[nodeConnection.nodeIndex]
            let cumulDistance = currentNode.estimateCumulativeDistance + nodeConnection.distance
            if(cumulDistance < targetNode.estimateCumulativeDistance ){
                targetNode.estimateCumulativeDistance = cumulDistance
                targetNode.previousNodeIndex = currentNode.nodeIndex
            }
            
        }
        
        // Exploration
        var minDistance : Float = 10000
        var idxToBeExplored : Int = -1
        
        for node in nodes{
            if(!node.explored && node.estimateCumulativeDistance < minDistance){
                minDistance = node.estimateCumulativeDistance
                idxToBeExplored = node.nodeIndex
            }
        }
        
        //Check path of exploration
        if(idxToBeExplored > -1){
            //print("Explore : \(nodes[idxToBeExplored].nodeName)")
            EstimateAndExplore(currentNode: nodes[idxToBeExplored], originNode: originNode)
        }
    }
}
