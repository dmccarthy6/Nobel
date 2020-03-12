//  Created by Dylan  on 3/10/20.
//  Copyright © 2020 DylanMcCarthy. All rights reserved.


import Foundation
import CoreLocation

struct CreateGraph: DecodeLaureat {
    //MARK: - Properties
    typealias Element = Laureate
    
    
    
    //MARK: - Helpers
    
    /// Decode the JSON from file and use these values to perform the Grid Search
    func decodeLocalJSON() -> [Laureate] {
        let values = decodeJSONFromFileAndPerformSearch()
        return values
    }
    
    /// Implement the Nobel Laureates graph. This sorts the values by country and groups the nobel laureate events by other events that happened nearby.
    /// Plan here is to initially get the graph created with nearby events linked, then once I have the user enterd Lat/Long values, I can insert that value into my graph and search
    /// For nearby events.
    func implementNobelLaureatesGraph() {
        //Sort the array of Laureate values by country to get the laureates closer to one another
        // Swift .sorted is -> O(n log n)
        let laureatesArray = decodeLocalJSON()
        let countrySorted = laureatesArray.sorted(by: { $0.country < $1.country })
        // Swift .map is -> O(n)
        let verticies = countrySorted.map({ $0.firstname })
        var countriesSet = Set<String>()
        let nobelWeightedGraph = WeightedGraph<String, Double>(verticies: verticies)
        
        // Iterate through sorted array to create the weighted graph. O(n)
        for i in 0..<countrySorted.count - 1 {
            // unwrap optional values
            let currentLaureate = countrySorted[i]
            let nextLaureate = countrySorted[i + 1]
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
        print(nobelWeightedGraph)
    }
    
    /// Use the passed in Graph value to perform Dijkstra Search on the graph to find the closest values to the user entered coordinates.
//    func performDijkstraSearch(graph: WeightedGraph<String, Double>) {
//        let (distances, path) = graph.dijkstra(root: "" , startDistance: 0)
//        var nameDistance: [String : Int] = graph.distanceArrayToVertexDict(distrances: distances)
//        
//        for (key, value) in nameDistance {
//            //
//        }
//    }
    
    /// Get the distance between two CLLocation values and return a Double
    /// - Returns: Distance in Kilometers
    func getDistanceBetween(location1: CLLocation, location2: CLLocation) -> Double {
        let distanceInKilometers = location1.distance(from: location2) / 1000
        return distanceInKilometers
    }
    
    
}
