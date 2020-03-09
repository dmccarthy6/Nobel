//  Created by Dylan  on 3/9/20.
//  Copyright © 2020 DylanMcCarthy. All rights reserved.

import Foundation

extension URL {
    
    /// Obtain the json file from the main directory.
    static func jsonFileURL(forResource: JsonDataFile, withExtension: JsonDataFile) -> URL {
        let url = Bundle.main.url(forResource: forResource.description, withExtension: forResource.description)!
        return url
    }
}

/// Enum in URL Extension to give the
/// URL resouce & file extension
enum JsonDataFile {
    case jsonResource
    case fileExtension
    
    var description: String {
        switch self {
        case .jsonResource:     return "nobel-prize-laureates"
        case .fileExtension:    return "json"
        }
    }
}
