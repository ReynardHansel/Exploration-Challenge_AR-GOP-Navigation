import Foundation
import CoreLocation

// Use Path Nodes because you don't change the destination name(? name of node (near something) might be added to enhance navigation)
struct PublicFacility{
    var fasulName : String
    var nodeIndex : Int
    var coordinate : CLLocationCoordinate2D
}


class LocationDataManager : NSObject, CLLocationManagerDelegate,ObservableObject {
    var locationManager: CLLocationManager = CLLocationManager()
    @Published var authorizationStatus: CLAuthorizationStatus?
    
    //updateLocationDataManager
    @Published var distanceToTarget : Double = 0
    @Published var userHeadingInDegrees : Double = 0
    @Published var targetDirectionInDegrees : Double = 0
    @Published var userHasToHeadInRadians : Float = 0
    @Published var hasArrived = false
    
    private var targetEstimateLocations : CLLocationCoordinate2D?
    
    //Deprecated Delete Later
    @Published var publicFacilites : [PublicFacility] = [
        PublicFacility(
            fasulName: "Ranch Market",//-6.302250327701575, 106.65306362775476
            nodeIndex: 0,
            coordinate: CLLocationCoordinate2D(latitude: -6.302250327701575, longitude: 106.65306362775476)
        ),
        PublicFacility(
            fasulName: "BSD Link",//-6.301384980170001, 106.65313631678508
            nodeIndex: 1,
            coordinate: CLLocationCoordinate2D(latitude: -6.301384980170001, longitude: 106.65313631678508)
        ),
        PublicFacility(
            fasulName: "Apple Academy",//-6.3018583391480245, 106.65235130605886
            nodeIndex: 2,
            coordinate: CLLocationCoordinate2D(latitude: -6.3018583391480245, longitude: 106.65235130605886)
        ),
    ]
    
    
    @Published var currentPath : [PathNode] = [
        PathNode(
            nodeIndex: 0, nodeConnections: []
        )
    ]
    
    func ResetPath(){
        currentPath = [
            PathNode(
                nodeIndex: 0, nodeConnections: []
            )
        ]
        
        hasArrived = false
        userNodeIndex = 0
    }
    
    var userNodeIndex = 0
    
    
    //timer update Interval
    var time : Double = 0
    var startTime : Date = Date()
    var stopper : Bool = false
    
    
    
    override init() {
        super.init( )
        locationManager.delegate = self
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        updateHeadingData()
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        startTime = Date()
        updateDistanceData()
        if(distanceToTarget < 4.0){
            if(userNodeIndex < currentPath.count - 1 && currentPath.count - 1 > 0){
                userNodeIndex += 1
            } else {
                hasArrived = true
                print("sudah sampai")
            }
        }
        
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print("error: \(error.localizedDescription)")
        }
    
    func cycleLocation(){
        if(userNodeIndex < currentPath.count - 1){
            userNodeIndex += 1
        } else {
            userNodeIndex = 0
            hasArrived = true
            print("sudah sampai")
        }
    }

    // authorization
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:  // Location services are available.
            authorizationStatus = .authorizedWhenInUse
            manager.startUpdatingLocation()
            manager.startUpdatingHeading()
            break
            
        case .restricted, .denied:  // Location services currently unavailable.
            authorizationStatus = .denied
            // Insert code here of what should happen when Location services are NOT authorized
            break
            
        case .notDetermined:        // Authorization not determined yet.
            authorizationStatus = .notDetermined
            manager.requestWhenInUseAuthorization()
            break
            
        default:
            break
        }
    }
    
    func askAuthorization (){
        
        if(locationManager.authorizationStatus != .authorizedWhenInUse){
            locationManager.requestWhenInUseAuthorization()
        }
        
    }
    
    
//    #define degreesToRadians(x) (M_PI * x / 180.0)
//    #define radiansToDegrees(x) (x * 180.0 / M_PI)
    
    func degreesToRadians(x : Double) -> Double {
        return .pi * x / 180
    }
    
    func radiansToDegrees(x:Double) -> Double{
        return x * 180 / .pi
    }

    func getHeadingForDirectionFromCoordinate (fromLoc : CLLocationCoordinate2D,toLoc :CLLocationCoordinate2D) -> Double
    {
        let fLat = degreesToRadians(x:fromLoc.latitude);
        let fLng = degreesToRadians(x:fromLoc.longitude);
        let tLat = degreesToRadians(x:toLoc.latitude);
        let tLng = degreesToRadians(x:toLoc.longitude);

        let degree = radiansToDegrees(x:atan2(sin(tLng-fLng)*cos(tLat), cos(fLat)*sin(tLat)-sin(fLat)*cos(tLat)*cos(tLng-fLng)));
        
        
        if (degree >= 0) {
            return degree;
        } else {
            return 360+degree;
        }
    }
    
    func getLocationDirection (fromLoc : CLLocationCoordinate2D,toLoc :CLLocationCoordinate2D) -> Double
    {
        let fLat = degreesToRadians(x:fromLoc.latitude);
        let fLng = degreesToRadians(x:fromLoc.longitude);
        let tLat = degreesToRadians(x:toLoc.latitude);
        let tLng = degreesToRadians(x:toLoc.longitude);

        let radians = atan2(sin(tLng-fLng)*cos(tLat), cos(fLat)*sin(tLat)-sin(fLat)*cos(tLat)*cos(tLng-fLng))
        
        
        if (radians >= 0) {
            return radians;
        } else {
            return (2 * .pi)+radians;
        }
    }
    
    
    func getDistanceBetweenCoordinate(coordinate1 : CLLocationCoordinate2D, coordinate2:CLLocationCoordinate2D) -> CLLocationDistance{
        // Convert CLLocationCoordinate2D to CLLocation objects
        let location1 = CLLocation(latitude: coordinate1.latitude, longitude: coordinate1.longitude)
        let location2 = CLLocation(latitude: coordinate2.latitude, longitude: coordinate2.longitude)
        
        // Calculate the distance
        return location1.distance(from: location2)
    }
    
    
    func updateHeadingData(){
        let target = currentPath[userNodeIndex].nodeCoordinate
        let origin = locationManager.location?.coordinate ?? CLLocationCoordinate2D(latitude: 0, longitude: 0)
        targetDirectionInDegrees = getHeadingForDirectionFromCoordinate(fromLoc: origin, toLoc: target)
        userHeadingInDegrees = locationManager.heading?.trueHeading ?? 0
        userHasToHeadInRadians = Float(degreesToRadians(x: userHeadingInDegrees - targetDirectionInDegrees))
        
    }
    
    
    func updateDistanceData(){
        let target = currentPath[userNodeIndex].nodeCoordinate
        let origin = locationManager.location?.coordinate ?? CLLocationCoordinate2D(latitude: 0, longitude: 0)
        distanceToTarget = getDistanceBetweenCoordinate(coordinate1: origin, coordinate2: target)
    }
    
    // Deprecated delete Later
    func updateLocationDataManager(){
        

    }
    
}

