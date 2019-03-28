//
//  Route.swift
//  FiveHundred
//
//  Created by John De Guzman on 2019-03-26.
//  Copyright © 2019 John De Guzman. All rights reserved.
//

import Foundation

struct Route {
    
    struct Version: Read, hasPhotos {
        var route: String = RouteConstants.version
        var urlParams: String!
    }
    
    struct Photos: Read {
        var route: String = RouteConstants.photos
        var urlParams: String!
    }
}
