//  Created by Dylan  on 3/9/20.
//  Copyright © 2020 DylanMcCarthy. All rights reserved.


import Foundation

/*
    * Generic protocol used to create the graph. 
 */
protocol GraphInterface {
    
    associatedtype Element: Hashable
    var description: CustomStringConvertible { get }
    
    func createVertex(data: Element) -> Vertex<Element>
    func add(_ type: EdgeType, from source: Vertex<Element>, to destination: Vertex<Element>, weight: Double?)
    func weight(from source: Vertex<Element>, to destination: Vertex<Element>) -> Double?
    func edges(from source: Vertex<Element>) -> [Edge<Element>]?
}
