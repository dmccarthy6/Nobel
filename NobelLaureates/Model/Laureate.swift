//  Created by Dylan  on 3/9/20.
//  Copyright © 2020 DylanMcCarthy. All rights reserved.

/*
 * Model File
 */

import Foundation
import CoreLocation

struct Laureate: Codable {
    let diffableID = UUID().uuidString
    let id: Int
    let category: String
    let died: String
    let diedcity: String
    let borncity: String
    let born: String
    let surname: String
    let firstname: String
    let motivation: String
    let location: [String : Double]
    let city: String
    let borncountry: String
    let year: String
    let diedcountry: String
    let country: String
    let gender: String
    let name: String
    var weight: Double?
}

extension Laureate: MapLocation {
    var latitude: Double {
        guard let validLatitude = location["lat"] else {
            print("Invalid latitude")
            return 0.00
        }
        return validLatitude
    }

    var longitude: Double {
        guard let validLongitude = location["lng"] else {
            print("Invalid longitude")
            return 0.00
        }
        return validLongitude
    }
    
    var laureateLocation: CLLocation {
        return CLLocation(latitude: latitude, longitude: longitude)
    }
}

/// Hashable extension to allow Laureate to be added as a vertex/
extension Laureate: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(diffableID)
    }
    
    static func ==(lhs: Laureate, rhs: Laureate) -> Bool {
        return lhs.id == rhs.id && lhs.category == rhs.category && lhs.died == rhs.died &&
            lhs.diedcity == rhs.diedcity && lhs.borncity == rhs.borncity && lhs.born == rhs.born
            && lhs.surname == rhs.surname && lhs.firstname == rhs.firstname && lhs.motivation == rhs.motivation
            && lhs.location == rhs.location && lhs.city == rhs.city && lhs.borncountry == rhs.borncountry &&
            lhs.year == rhs.year && lhs.diedcountry == rhs.diedcountry && lhs.country == rhs.country
            && lhs.gender == rhs.gender && lhs.name == rhs.name
    }
}

/// Debug Data. Hard codeing model objects to layout CollectionView cell's
extension Laureate {
    static var mylaureates: [Laureate] {
        return [
            Laureate(id: 1, category: "MEdicine", died: "", diedcity: "", borncity: "", born: "", surname: "Mccarthy", firstname: "Dylan", motivation: "for their discovery of the ability of poliomyelitis viruses to grow in cultures of various types of tissue", location: [:], city: "", borncountry: "", year: "", diedcountry: "", country: "", gender: "", name: "", weight: 100),
            Laureate(id: 2, category: "Physics", died: "", diedcity: "", borncity: "", born: "", surname: "Mccarthy", firstname: "Suzanne", motivation: "", location: [:], city: "", borncountry: "", year: "", diedcountry: "", country: "", gender: "", name: "", weight: 200)
        ]
    }
}
