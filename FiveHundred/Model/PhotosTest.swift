//
//  PhotosTest.swift
//  FiveHundredTests
//
//  Created by John De Guzman on 2019-03-28.
//  Copyright © 2019 John De Guzman. All rights reserved.
//

import XCTest
@testable import FiveHundred
class PhotosTest: XCTestCase {


    func testModelIsEqual() {
        
        let photos = Photos(url: "dog", id: "123", name: "Joe", description: "Desc", biggerImageURL: "biggerImage")
        let photosV2 = Photos(url: "dog", id: "123", name: "Joe", description: "Desc", biggerImageURL: "biggerImage")
        
        XCTAssertEqual(photos, photosV2, "If the data inside the photos are the same, the model should be equal")
        
    }
    
    func testModelIsNotEqual() {
        
        let photos = Photos(url: "dog", id: "123", name: "Joe", description: "Desc", biggerImageURL: "biggerImage")
        let photosV2 = Photos(url: "dog", id: "1234", name: "Joe", description: "Desc", biggerImageURL: "biggerImage")
        
        XCTAssertNotEqual(photos, photosV2, "If one of the data inside the photos model is not the same, the model should be equal")
        
    }

}
