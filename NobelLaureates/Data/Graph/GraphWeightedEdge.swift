//  Created by Dylan  on 3/11/20.
//  Copyright © 2020 DylanMcCarthy. All rights reserved.
//

import Foundation

open class WeightedEdge<W: Comparable & Summable>: Edge, Comparable {
    public var to: Int
    public var from: Int
    public let weight: W
    
    public var reversed: Edge {
        return WeightedEdge(to: from, from: to, weight: weight)
    }
    
    
    //MARK: - Initializer
    public init(to: Int, from: Int, weight: W) {
        self.to = to
        self.from = from
        self.weight = weight
        
    }
    
    public var description: String {
        return "\(from) <\(weight)> \(to)"
    }
    
    static public func == <W>(lhs: WeightedEdge<W>, rhs: WeightedEdge<W>) -> Bool {
        return lhs.to == rhs.to && lhs.from == rhs.from && lhs.weight == rhs.weight
    }
    
    static public func < <W>(lhs: WeightedEdge<W>, rhs: WeightedEdge<W>) -> Bool {
        return lhs.weight < rhs.weight
    }
}
