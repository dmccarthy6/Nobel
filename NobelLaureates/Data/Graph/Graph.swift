//  Created by Dylan  on 3/9/20.
//  Copyright © 2020 DylanMcCarthy. All rights reserved.


import Foundation

/// Class Protocol
public protocol Graph: class, CustomStringConvertible {
    associatedtype VertexType: Equatable
    associatedtype EdgeType: Edge
    var verticies: [VertexType] { get set }
    var edges: [[EdgeType]] { get set }
}

extension Graph {
    ///Count the verticies in the Graph
    public var vertexCount: Int {
        return verticies.count
    }
    /// Count the edges in the graph
    public var edgesCount: Int {
        return edges.count
    }
    
    /// Get vertex by its index
    public func vertexAtIndex(_ index: Int) -> VertexType {
        return verticies[index]
    }
    
    /// Find first occurrence of the vertex, if it exists
    /// - Parameters:
    ///     - vertex: The vertex you are looking for
    /// - Returns: Optional index of the vertex. Nil if index doesn't exist
    public func indexOfVertex(_ vertex: VertexType) -> Int? {
        if let i = verticies.firstIndex(of: vertex) {
            return i
        }
        return nil
    }
    
    /// Get the neighbors for curent index.
    /// - Parameters:
    ///     - index: Index for the vertex you want neighbors of
    /// - Returns: Array of neighboring verticies
    public func neighborsForIndex(_ index: Int) -> [VertexType] {
        return edges[index].map({ self.verticies[$0.to] })
    }
    
    /// Get the neighbors for curent index.
    /// - Parameters:
    ///     - index: Vertex you want the neighbors of
    /// - Returns: Array of neighboring verticies
    public func neighborsForVertex(_ vertex: VertexType) -> [VertexType]? {
        if let i = indexOfVertex(vertex) {
            return neighborsForIndex(i)
        }
        return nil
    }
    
    ///
    /// - Parameters:
    ///     - index: Index you want the edges for
    /// - Returns: Array of Edges.
    public func edgesForIndex(_ index: Int) -> [EdgeType] {
        return edges[index]
    }
    
    ///Find all the edges for a given vertex.
    /// - Parameters:
    ///     - vertex: Vertex to find the edges of.
    /// - Returns: Optional array of Edges
    public func edgesForVertex(_ vertex: VertexType) -> [EdgeType]? {
        if let i = indexOfVertex(vertex) {
            return edgesForIndex(i)
        }
        return nil
    }
    
    ///Adds a new vertex to the graph
    /// - Parameters
    ///     - v: Vertex to add to the graph
    /// - Returns: Index where the vertes was added.
    public func addVertex(_ v: VertexType) -> Int {
        verticies.append(v)
        edges.append([EdgeType]())
        return verticies.count - 1
    }
    
    ///Add an edge to the graph
    /// - Parameters:
    ///     - e: Edge to add to the graph
    public func addEdge(_ e: EdgeType) {
        //This connects the edge to both the 'to' and 'from' values so its bi-directional.
        edges[e.from].append(e)
        edges[e.to].append(e.reversed as! EdgeType)
    }
    
}
