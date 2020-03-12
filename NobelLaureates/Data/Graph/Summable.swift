//  Created by Dylan  on 3/11/20.
//  Copyright © 2020 DylanMcCarthy. All rights reserved.

import Foundation

public protocol Summable {
    
    static func +(lhs: Self, rhs: Self) -> Self
    
}

extension Int: Summable {}
extension Double: Summable {}
extension Float: Summable {}
