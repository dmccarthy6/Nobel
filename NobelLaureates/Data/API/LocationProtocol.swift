//  Created by Dylan  on 3/10/20.
//  Copyright © 2020 DylanMcCarthy. All rights reserved.

import Foundation
import CoreLocation

protocol MapLocation {
    
    var latitude: Double { get }
    var longitude: Double { get }
    var year: String { get }
}

extension MapLocation {
    
    /// Returns a CLLocation based ont he latitude/longitude passed in
    var mapLocation: CLLocation {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        return location
    }
    
    func getDistanceBetween(location1: CLLocation, location2: CLLocation) -> Double {
        let distanceInKilometers = location1.distance(from: location2) / 1000
        return distanceInKilometers
    }
    
}
