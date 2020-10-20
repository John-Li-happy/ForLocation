//
//  CustomAnnotation.swift
//  ForLocation
//
//  Created by Zhaoyang Li on 6/30/20.
//  Copyright © 2020 Zhaoyang Li. All rights reserved.
//

import Foundation
import MapKit

class CustomAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var locationName: String
    var title: String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D, locationName: String) {
        self.coordinate = coordinate
        self.locationName = locationName
    }
}


