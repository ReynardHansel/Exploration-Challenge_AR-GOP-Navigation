//
//  Destination.swift
//  AR Navigation
//
//  Created by Reynard Hansel on 26/03/25.
//

import CoreLocation
import DeveloperToolsSupport
import Foundation

// Model
struct Destination: Identifiable {
    let id = UUID()
    let name: String
    let nearestCoordinate: CLLocationCoordinate2D
    let destinationCoordinate: CLLocationCoordinate2D
    let icon: String
    let elementIcon: ElementIconType
    
    let images: [ImageResource]?
    let description: String?
    let address: String?
}

//let destinationDB: [Destination] = [
//    Destination(
//        name: "The Breeze",
//        nearestCoordinate: CLLocationCoordinate2D(
//            latitude: -6.301771, longitude: 106.653436),
//        destinationCoordinate: CLLocationCoordinate2D(
//            latitude: -6.301937, longitude: 106.654244)
//    ),
//    Destination(
//        name: "Harvest Chemical",
//        nearestCoordinate: CLLocationCoordinate2D(
//            latitude: -6.302518, longitude: 106.652247),
//        destinationCoordinate: CLLocationCoordinate2D(
//            latitude: -6.302538, longitude: 106.652161)
//    ),
//    Destination(
//        name: "Ranch 99 Market",
//        nearestCoordinate: CLLocationCoordinate2D(
//            latitude: -6.302271, longitude: 106.652881),
//        destinationCoordinate: CLLocationCoordinate2D(
//            latitude: -6.302270, longitude: 106.653346)
//    ),
//]

//let destinationDBnew: [Destination] = [
//    Destination(
//        name: "Jogging Track The Breeze",
//        nearestCoordinate: CLLocationCoordinate2D(
//            latitude: -6.301771, longitude: 106.653436),
//        destinationCoordinate: CLLocationCoordinate2D(
//            latitude: -6.301937, longitude: 106.654244),
//        icon: "figure.run"
//    ),
//    Destination(
//        name: "BSD Link",
//        nearestCoordinate: CLLocationCoordinate2D(
//            latitude: -6.302518, longitude: 106.652247),
//        destinationCoordinate: CLLocationCoordinate2D(
//            latitude: -6.302538, longitude: 106.652161),
//        icon: "bus.fill"
//    ),
//    Destination(
//        name: "Ranch Market",
//        nearestCoordinate: CLLocationCoordinate2D(
//            latitude: -6.302271, longitude: 106.652881),
//        destinationCoordinate: CLLocationCoordinate2D(
//            latitude: -6.302270, longitude: 106.653346),
//        icon: "cart.fill"
//    ),
//
//
//]
//
//let destinationDBShowcase: [Destination] = [
//    Destination(
//        name: "Collab 04 Lab Apple",
//        nearestCoordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0),
//        destinationCoordinate: CLLocationCoordinate2D(latitude: -6.3020440, longitude: 106.6525108),
//        icon: "chair.lounge.fill"
//    ),
//    Destination(
//        name: "Toilet GOP 9",
//        nearestCoordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0),
//        destinationCoordinate: CLLocationCoordinate2D(latitude: -6.3024286, longitude: 106.6522204),
//        icon: "toilet.fill"
//    ),
//    Destination(
//        name: "Lift Basement GOP 9",
//        nearestCoordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0),
//        destinationCoordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0),
//        icon: "stairs"
//    ),
//    Destination(
//        name: "Kopi Persen The Breeze",
//        nearestCoordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0),
//        destinationCoordinate: CLLocationCoordinate2D(latitude: -6.301725860690979, longitude: 106.65313730957605),
//        icon: "bus.fill"
//    ),

//]

let showcaseDestination = [
    Destination(  // COllab
        name: "Collab 04 Lab Apple",
        nearestCoordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0),
        destinationCoordinate: CLLocationCoordinate2D(
            latitude: -6.302146341750258, longitude: 106.65258037385355),
        icon: "chair.lounge.fill",
        elementIcon: .other,
        images: [.colab41, .colab42, .colab43, .colab44],
        description:
            "A co-working place at the corner of Apple Developer Academy @ BINUS Tangerang. Anyone can book this place and use it as their own or with their team. The place has a TV with an airplay available and a charging port.",
        address:
            """
            Jl. Grand Boulevard, BSD Green Office Park 9 
            BSD City, Sampora, Kec. Cisauk, Kabupaten Tangerang
            Banten 15345
            """
    ),
    Destination(  // LOBBY
        name: "Toilet GOP 9",
        nearestCoordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0),
        destinationCoordinate: CLLocationCoordinate2D(
            latitude: -6.30225186125706, longitude: 106.65222278509515),
        icon: "toilet.fill",
        elementIcon: .toilet,
        images: [.toiletGOP9, .toilet91, .toilet92, .toilet93, .toilet94],
        description:
            "The toilet that is the nearest from the academy. It is located on the ground floor of the building. It's very cozy and clean, although it might be a bit crowded during peak hours, and generally more crowded than the toilet at the basement.",
        address:
            """
            Jl. Grand Boulevard, BSD Green Office Park 9 
            BSD City, Sampora, Kec. Cisauk, Kabupaten Tangerang
            Banten 15345
            """
    ),
    Destination(  // LOBBY
        name: "Stairs to Parking",
        nearestCoordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0),
        destinationCoordinate: CLLocationCoordinate2D(
            latitude: -6.301756786203655, longitude: 106.65200317681277),
        icon: "parkingsign",
        elementIcon: .other,
        images: [.stairsToParking],
        description: "The stairs that lead to the parking lot.",
        address: nil
    ),
    Destination(  // LOBBY
        name: "Kopi Arabica The Breeze",
        nearestCoordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0),
        destinationCoordinate: CLLocationCoordinate2D(
            latitude: -6.301725860690979, longitude: 106.65313730957605),
        icon: "chair.lounge.fill",
        elementIcon: .FnB,
        images: [.kopiArabicaTheBreeze],
        description:
            """
            This café offers a welcoming and versatile space that caters to a wide range of guests—from solo diners to university students and tourists. 
            
            With a casual, cosy, and trendy atmosphere, it's an ideal spot for everything from a quick coffee break to an afternoon of remote work.
            """,
        address:
            """
            BSD, Jl. BSD Green Office Park Jl. BSD Grand Boulevard
            Sampora, Kec. Cisauk, Kabupaten Tangerang
            Banten 15345
            """
    ),
]
