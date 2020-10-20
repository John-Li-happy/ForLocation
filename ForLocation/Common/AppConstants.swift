//
//  AppConstants.swift
//  ForLocation
//
//  Created by Zhaoyang Li on 7/1/20.
//  Copyright © 2020 Zhaoyang Li. All rights reserved.
//

import Foundation

struct AppConstants {
    static let searchTableViewID: String = "SearchTableViewController"
    
    static let searchTableViewCellID: String = "cell"
    
    static let bestLocationNotificationName = Notification.Name("bestLocationChannal")
    
    static let destinationNotificationName = Notification.Name("destinationChannal")
    
    static let closeNotificationName = Notification.Name("closeChannal")
    
    static let allAnnotationUrl = URL(string: "https://data.honolulu.gov/resource/yef5-h88r.json")
    
    static let nibName: String = "CustomCalloutViewNibs"
}
