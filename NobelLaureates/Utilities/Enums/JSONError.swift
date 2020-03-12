//  Created by Dylan  on 3/9/20.
//  Copyright © 2020 DylanMcCarthy. All rights reserved.


import Foundation

enum JSONDecodingError: Error {
    case failed
    case noData
    
    var localizedDescription: String {
        switch self {
            case .failed:   return "JSON Decoding Failed"
            case .noData:   return "No Data Passed In"
        }
    }
}
