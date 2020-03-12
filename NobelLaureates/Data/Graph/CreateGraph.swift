//  Created by Dylan  on 3/10/20.
//  Copyright © 2020 DylanMcCarthy. All rights reserved.


import Foundation
import CoreLocation

struct CreateGraph: DecodeLaureat {
    //MARK: - Properties
    typealias Element = Laureate
    let nobelLaureates: [Laureate?]
    
    
    
    
    //MARK: - Initializer
    init(nobelLaureates: [Laureate?]) {
        self.nobelLaureates = nobelLaureates
    }
    
    
    
    //MARK: - Helpers
    
    /// Implement the Nobel Laureates graph. This sorts the values by country and groups the nobel laureate events by other events that happened nearby.
    /// Plan here is to initially get the graph created with nearby events linked, then once I have the user enterd Lat/Long values, I can insert that value into my graph and search
    /// For nearby events.
    func implementNobelLaureatesGraph() {
        //Sort the array of Laureate values by country to get the laureates closer to one another
        // Swift .sorted is -> O(n log n)
        let countrySorted = nobelLaureates.sorted(by: { $0!.country < $1!.country })
        // Swift .map is -> O(n)
        let verticies = countrySorted.map({ $0!.firstname })
        var countriesSet = Set<String>()
        let nobelWeightedGraph = WeightedGraph<String, Double>(verticies: verticies)
        
        // Iterate through sorted array to create the weighted graph. O(n)
        for i in 0..<countrySorted.count - 1 {
            // unwrap optional values
            if let currentLaureate = countrySorted[i], let nextLaureate = countrySorted[i + 1] {
                let weight = getDistanceBetween(location1: currentLaureate.laureateLocation, location2: nextLaureate.laureateLocation)
                // If the current country isn't the same as the next country, and we haven't seen it already (it's the only event in it's country)
                if currentLaureate.country != nextLaureate.country && !countriesSet.contains(currentLaureate.country) {
                   nobelWeightedGraph.addEdge(from: currentLaureate.firstname, to: nextLaureate.firstname, weight: weight)
                }
                    //If they're in the same country, add edges to link events closer to each other
                else if currentLaureate.country == nextLaureate.country {
                    countriesSet.insert(currentLaureate.country)//Now I've seen this
                    nobelWeightedGraph.addEdge(from: currentLaureate.firstname, to: nextLaureate.firstname, weight: weight)
                } else {
                    //This is the last event in a country that already has events added to the graph
                nobelWeightedGraph.addEdge(from: currentLaureate.firstname, to: nextLaureate.firstname, weight: weight)
                }
            }
        }
//        let (distances, path) = nobelWeightedGraph.dijkstra(root: "", startDistance: 0)
//        var nameDistance: [String : Int] = nobelWeightedGraph.distanceArrayToVertexDict(distances: distances)
//        for (key, value) in nameDistance {
//            print("\(key) : \(value)")
//        }
        print(nobelWeightedGraph)
    }
    
    /// Get the distance between two CLLocation values and return a Double
    /// - Returns: Distance in Kilometers
    func getDistanceBetween(location1: CLLocation, location2: CLLocation) -> Double {
        let distanceInKilometers = location1.distance(from: location2) / 1000
        return distanceInKilometers
    }
    

}




///////DEVELOP -- CLEAN UP
/*
 static func preloadDecodedJSON() {
     let defaults = UserDefaults.standard
     let isPreloaded = defaults.bool(forKey: "preloaded")
     if !isPreloaded {
         defaults.set(true, forKey: "preloaded")
     }
 }
 
 func dictCreate() {
         var dict: [String : Int] = [
             "USSR" : 1,
             "Russia" : 2,
             "Czechoslavakia" : 3,
             "Hungary" : 4,
             "Austria" : 5,
             "Finland" : 6,
             "Sweden" : 7,
             "Norway" : 8,
             "Denmark" : 9,
             "Italy" : 10,
             "Switzerland" : 11,
             "Germany" : 12,
             "Federal Republic of Germany" : 13,
             "Belgium" : 14,
             "the Netherlands" : 15,
             "United Kingdom" : 16,
             "Ireland" : 17,
             "France" : 18,
             "Spain" : 19,
             "Portugal" : 20,
             "Canada" : 21,
             "USA" : 22,
             "Argentina" : 23,
             "Australia" : 24,
             "Japan" : 25,
             "India" : 26,
             "Alsace" : 27
         ]
     }
     
 }
 /*
  Alsace
  
  Australia 1
  Japan 9
  India 1
  
  
  
  
  
  
  

  
  
  //////
  Finland 8
  Sweden 8
  Norway 8
  Denmark 8
  
  USSR 6
  Russia 6
  Czechoslavakia 6
  Hungary 6
  
  Italy 2
  Switzerland 2
  Germany 5
  Federal Republic of Germany 5
  Belgium 2
  the Netherlands 4
  United Kingdom 4
  Ireland 4
  France 2
  Spain 2
  Portugal 2

  Canada 10
  USA 10
  Argentina 10
  */

 */
