//  Created by Dylan  on 3/9/20.
//  Copyright © 2020 DylanMcCarthy. All rights reserved.


import Foundation
import UIKit

protocol DecodeLaureat {
    associatedtype Element: Decodable
}

extension DecodeLaureat {
    typealias JSONHandler = (Decodable?, JSONDecodingError?) -> Void
    
    /// Decode the JSON data
    func decodeLaureatFromJSON(decodingType: Element.Type, completionHandler completion: @escaping JSONHandler) {
        if let localJsonData = getJSONDataFromLocalFile() {
            do {
                
                let nobelLaureatsModel = try JSONDecoder().decode(decodingType, from: localJsonData)
                completion(nobelLaureatsModel, nil)
            }
            catch {
                completion(nil, .failed)
            }
        }
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
