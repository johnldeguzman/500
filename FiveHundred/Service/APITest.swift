//
//  APITest.swift
//  FiveHundredTests
//
//  Created by John De Guzman on 2019-03-28.
//  Copyright © 2019 John De Guzman. All rights reserved.
//

import XCTest
@testable import FiveHundred
class APITest: XCTestCase {

    func testRoutableProtocol() {
        
        struct MockRoutable: Routable {
            init() {
                
            }
            
            var route: String
            var urlParams: String!
        }
        
        let mock = MockRoutable(route: "photos", urlParams: "Cat")
        
        XCTAssert(mock.nestedRouteURL(parent: mock, child: mock) is String, "")
       
    }

    
    

}
