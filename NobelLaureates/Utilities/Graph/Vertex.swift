//  Created by Dylan  on 3/9/20.
//  Copyright © 2020 DylanMcCarthy. All rights reserved.

import Foundation

struct Vertex<T: Hashable> {
    var data: T
    
}


/*
 * Conforming to Hashable Protocol
 */
extension Vertex: Hashable {
    
    //Providing hashValue property to conform to Hashable
    public var hashValue: Int {
        return "\(data)".hashValue
    }
    
    //Since Hashable inherits from Equitable, conforming to Equitable also.
    static public func == (lhs: Vertex, rhs: Vertex) -> Bool {
        return lhs.data == rhs.data
    }
}

/*
 * Use this to verify the Adjacency list
 */
extension Vertex: CustomStringConvertible {
    
    public var description: String {
        return "\(data)"
    }
    
}
