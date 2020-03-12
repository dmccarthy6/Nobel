//  Created by Dylan  on 3/9/20.
//  Copyright © 2020 DylanMcCarthy. All rights reserved.


import Foundation
import UIKit

protocol DecodeLaureat {
    associatedtype Element: Decodable

}

extension DecodeLaureat {
    typealias JSONHandler = (Decodable?, JSONDecodingError?) -> Void
    
    /// Use JSONDecoder() to decode the local JSON file into Laureate model objects.
    /// - Returns: Array of optional Laureate objects.
    func decodeJSONFromFileAndPerformSearch(userData: Laureate?) -> [Laureate] {
        guard let localJSONData = getJSONDataFromLocalFile() else { return [] }
        
        do {
            let decodedJSON = try JSONDecoder().decode([Laureate].self, from: localJSONData)
            return decodedJSON
        }
        catch let error as NSError {
            print("ERROR DECODING JSON: \(error.localizedDescription)")
        }
        return []
    }
    
    /// Helper function to get Data object from the local json file provided.
    private func getJSONDataFromLocalFile() -> Data? {
        let jsonFileURL = URL.jsonFileURL(forResource: .jsonResource, withExtension: .fileExtension)
        
        do {
            let data = try Data(contentsOf: jsonFileURL)
            return data
        }
        catch let error as NSError {
            print("Error \(error.localizedDescription)")
        }
        return nil
    }
    
}
