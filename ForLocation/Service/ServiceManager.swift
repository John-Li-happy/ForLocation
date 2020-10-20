//
//  ServiceManager.swift
//  ForLocation
//
//  Created by Zhaoyang Li on 7/8/20.
//  Copyright © 2020 Zhaoyang Li. All rights reserved.
//

import UIKit

class ServiceManager {
    
    func fetchBasicData() -> [Art]? {
        
        DispatchQueue.global(qos: .userInteractive).async {
            
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
           
        }
        
        
        guard let url = AppConstants.allAnnotationUrl else {
            print("err in url")
            return [Art]()
        }
        do {
            let data = try Data(contentsOf: url)
            let artsJson  = try JSONDecoder().decode([Art].self, from: data)
            return artsJson
        } catch {print("error in fetching", error.localizedDescription)}
        return nil
    }
}

class Example {
    var array = [AnyObject]()
    func modifier() {
        let one: NSNumber = 1
        array.append(one)
    }
}

