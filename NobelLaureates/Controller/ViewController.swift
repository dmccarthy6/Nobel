//  Created by Dylan  on 3/9/20.
//  Copyright © 2020 DylanMcCarthy. All rights reserved.


import UIKit

class ViewController: UIViewController, DecodeLaureat {
    typealias Element = Laureate
    let adjacencyList = LaureatsList<String>()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        createDummyData()
    }


    //DEVELOP
    func createDummyData() {
        let first = adjacencyList.createVertex(data: "Albert Einstein")
        let second = adjacencyList.createVertex(data: "Soemone really cool")
        let third = adjacencyList.createVertex(data: "Mark Zukerberg")
        
        adjacencyList.add(.undirected, from: first, to: second, weight: 150)
        adjacencyList.add(.undirected, from: second, to: third, weight: 1000)
        
        print(adjacencyList.description)
    }
}

