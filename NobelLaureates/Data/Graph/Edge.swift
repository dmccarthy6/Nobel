//  Created by Dylan  on 3/9/20.
//  Copyright © 2020 DylanMcCarthy. All rights reserved.

//Edge - Connection between the two verticies
public protocol Edge: CustomStringConvertible {
    var from: Int { get set }
    var to: Int { get set }
    var reversed: Edge { get }
}
