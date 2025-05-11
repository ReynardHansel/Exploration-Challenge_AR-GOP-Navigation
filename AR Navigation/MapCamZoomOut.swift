//
//  MapCamZoomOut.swift
//  AR Navigation
//
//  Created by Reynard Hansel on 09/04/25.
//

// NOTE:
// The key function for this feature is `calculateRegionToFit`, which computes yhe appropriate MKCoordinateRegion based on an array of coordinates

import MapKit

    func calculateRegionToFit(coordinates: [CLLocationCoordinate2D])
        -> MKCoordinateRegion?
    {
        guard !coordinates.isEmpty else { return nil }

        let latitudes = coordinates.map { $0.latitude }
        let longitudes = coordinates.map { $0.longitude }

        let minLatitude = latitudes.min() ?? 0
        let maxLatitude = latitudes.max() ?? 0
        let minLongitude = longitudes.min() ?? 0
        let maxLongitude = longitudes.max() ?? 0

        let center = CLLocationCoordinate2D(
            latitude: (minLatitude + maxLatitude) / 2,
            longitude: (minLongitude + maxLongitude) / 2
        )

        // Adding a multiplier for padding (e.g., 1.4) so there's some space around the edges
        let span = MKCoordinateSpan(
            latitudeDelta: (maxLatitude - minLatitude) * 1.4,
            longitudeDelta: (maxLongitude - minLongitude) * 1.4
        )

        return MKCoordinateRegion(center: center, span: span)
    }
