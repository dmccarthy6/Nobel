//  Created by Dylan  on 3/11/20.
//  Copyright © 2020 DylanMcCarthy. All rights reserved.


import Foundation

open class WeightedGraph<V: Equatable & Hashable, W: Comparable & Summable>: Graph {
    public var verticies: [V] = [V]()
    public var edges: [[WeightedEdge<W>]] = [[WeightedEdge<W>]]() //Adjacency list
    
    
    //MARK: - Initializer
    public init(verticies: [V]) {
        for vertex in verticies {
            _ = self.addVertex(vertex)
        }
    }
    
    ///
    public func neighborsForIndexWithWeights(_ index: Int) -> [(V, W)] {
        var distanceTuples: [(V, W)] = [(V, W)]()
        for edge in edges[index] {
            distanceTuples += [(verticies[edge.to], edge.weight)]
        }
        return distanceTuples
    }
    
    ///
    public func addEdge(from: Int, to: Int, weight: W) {
        addEdge(WeightedEdge<W>(to: from, from: to, weight: weight))
    }
    
    ///
    public func addEdge(from: V, to: V, weight: W) {
        if let u = indexOfVertex(from) {
            if let v = indexOfVertex(to) {
                addEdge(from: u, to: v, weight: weight)
            }
        }
    }
    
    public var description: String {
        var d: String = ""
        for i in 0..<verticies.count {
            d += "\(verticies[i]) -> \(neighborsForIndexWithWeights(i)) \n"
        }
        return d
    }
}

