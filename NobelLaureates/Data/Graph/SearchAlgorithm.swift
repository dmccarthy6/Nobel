//  Created by Dylan  on 3/11/20.
//  Copyright © 2020 DylanMcCarthy. All rights reserved.
//

import Foundation


public extension WeightedGraph {
    
    ///This is a node in the Priority Queue that will be used for selecting the next
    struct DijkstraNode: Comparable, Equatable {
        let vertex: Int
        let distance: W
        
        
        /// Finds the shortest paths from some root vertex to every other vertex in the graph
        /// - Parameters:
        ///     - root: The index of the root node to build the shortest path from
        ///     - startDistance: The distance to get to the root node (0 most of the time)
        /// - Returns: Tuple; Array of the distances, and dictionary of the edges to reach each vertex.
        func dijkstraSearch(root: Int, startDistance: W) -> ([W?], [Int: WeightedEdge<W>]) {
            var distances: [W?] = [W?](repeating: nil, count: vertexCount)
            //The 'start distance' is the value of startDistance passed in
            distances[root] = startDistance
            var priortityQueue: PriorityQueue<DijkstraNode> = PriorityQueue<DijkstraNode>(ascending: true)
            var pathDict: [Int : WeightedEdge<W>] = [Int : WeightedEdge<W>]()
            priortityQueue.push(DijkstraNode(vertex: root, distance: startDistance))
            
            while let u = priortityQueue.pop()?.vertex {
                guard let distanceFrom = distances[u] else { continue } //Should have already seen it
                for we in edgesForIndex(u) {
                    //look for every edge/vertex
                    let distV = distances[we.to]//Old distance to this vertex
                    if distV == nil || distV! > we.weight + distU {
                        //update distance to this vertex
                        pathDict[we.v] = we
                        priortityQueue.push(DijkstraNode(vertex: we.u, distance: we.weight + distanceFrom))
                    }
                }
            }
            return (distances, pathDict)
        }
        
        ///Allows you to supply root vertex value instead of the index.
        func dijkstra(root: V, startDistance: W) -> ([W?], [Int : WeightedEdge<W>]) {
            if let safeRoot = indexOfVertex(root) {
                return dijkstra(root: safeRoot, startDistance: startDistance)
            }
            return ([], [:])
            
        }
        
        /// Get easier access to the results
        func distanceArrayToVertexDict(distances: [W?]) -> [V : W?] {
            var distanceDict: [V : W?] = [V : W?]()
            for i in 0..<distances.count {
                distanceDict[vertexAtIndex(i)] = distances[i]
            }
            return distanceDict
        }
        
        
        /// Conforming to Comparable && Equitalble
        public static func < (lhs: DijkstraNode, rhs: DijkstraNode) -> Bool {
            return lhs.distance < rhs.distance
        }
        public static func == (lhs: DijkstraNode, rhs: DijkstraNode) -> Bool {
            return lhs.distance == rhs.distance
        }
    }

    
}


