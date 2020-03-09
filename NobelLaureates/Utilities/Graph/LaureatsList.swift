//  Created by Dylan  on 3/9/20.
//  Copyright © 2020 DylanMcCarthy. All rights reserved.


/*
    * The dictionary where we'll store our graph
 */
import Foundation

final class LaureatsList<T: Hashable> {
    //MARK: - Properties
    var agencyDict: [Vertex<T>: [Edge<T>]] = [:]
    
    //MARK: - Initializer
    public init() {}
    
    //MARK: - Private Functions
    private func addDirectedEdge(from source: Vertex<Element>, to destination: Vertex<Element>, weight: Double?) {
        let edge = Edge(source: source, destination: destination, weight: weight)
        agencyDict[source]?.append(edge)
    }
    
    private func addUndirectedEdge(from verticies: (Vertex<Element>, Vertex<Element>), weight: Double?) {
        let (source, destination) = verticies
        addDirectedEdge(from: source, to: destination, weight: weight)
        addDirectedEdge(from: destination, to: source, weight: weight)
    }
    
}

extension LaureatsList: GraphInterface {
    public typealias Element = T
    
    public func createVertex(data: Element) -> Vertex<Element> {
        let vertex = Vertex(data: data)
        if agencyDict[vertex] == nil {
            agencyDict[vertex] = []
        }
        return vertex
    }
    
    /// Add a new Edge to the Graph.
    /// - Parameters:
    ///     - stype: EdgeType enum value (directed edge or undirected edge)
    ///     - Source: Vertex
    ///     - destination: Vertex
    /// - Returns: Double Value of the Weight
    public func add(_ type: EdgeType, from source: Vertex<Element>, to destination: Vertex<Element>, weight: Double?) {
        switch type {
        case .directed:
            addDirectedEdge(from: source, to: destination, weight: weight)
        case .undirected:
            addUndirectedEdge(from: (source, destination), weight: weight)
        }
    }
    
    /// Get the weight between two verticies.
    /// - Parameters:
    ///     - source: Vertex
    ///     - destination: Vertex
    /// - Returns: Double Value of the Weight
    public func weight(from source: Vertex<Element>, to destination: Vertex<Element>) -> Double? {
        guard let edges = agencyDict[source] else {
            return nil
        }
        
        for edge in edges {
            if edge.destination == destination {
                return edge.weight
            }
        }
        return nil
    }
    
    /// Access the dictionary with the passed in vertex and return an array of edges.
    /// - Parameters:
    ///     - source: Vertex passed in to obtain the array of edges.
    /// - Returns: Optional array of Graph edges
    public func edges(from source: Vertex<Element>) -> [Edge<Element>]? {
        return agencyDict[source]
    }
    
    /// Goes through the dictionary and prints every key-value pair in our dictionary. Prints the vertex and
    /// all the verticies it's connected to by an edge.
    public var description: CustomStringConvertible {
        var result = ""
        for (vertex, edges) in agencyDict {
            var edgeString = ""
            
            for (index, edge) in edges.enumerated() {
                if index != edges.count - 1 {
                    edgeString.append("\(edge.destination)")
                }
                else {
                    edgeString.append("\(edge.destination)")
                }
            }
            result.append("\(vertex) ---> [\(edgeString)] \n ")
        }
        return result
    }
}
