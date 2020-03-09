//  Created by Dylan  on 3/9/20.
//  Copyright © 2020 DylanMcCarthy. All rights reserved.

struct Edge<T: Hashable> {
    
    var source: Vertex<T>
    var destination: Vertex<T>
    let weight: Double?
    
}

/*
 * Hashable Conformance
 */
extension Edge: Hashable {
    var hashValue: Int {
        return "\(source)\(destination)\(weight)".hashValue
    }
    
    static func ==(lhs: Edge<T>, rhs: Edge<T>) -> Bool {
        return lhs.source == rhs.source && lhs.destination == rhs.destination && lhs.weight == rhs.weight
    }
}
