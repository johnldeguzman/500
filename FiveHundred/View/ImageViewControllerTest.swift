//
//  ImageViewControllerTest.swift
//  FiveHundredTests
//
//  Created by John De Guzman on 2019-03-28.
//  Copyright © 2019 John De Guzman. All rights reserved.
//

import XCTest
@testable import FiveHundred
class ImageViewControllerTest: XCTestCase {
    
    class MockPhotoData: PhotoDataProtocol {
        
        var pages: Int = 0
        
        var mockPhotos = Photos(url: "dog", id: "123", name: "Joe", description: "Desc", biggerImageURL: "biggerImage")
        
        func getData(pagination: Int, onComplete: @escaping ([Photos]) -> Void) {
            pages = pagination
            onComplete([mockPhotos])
        }
    }
    

    func testPhotoDataProtocol() {
        
        let mockData = MockPhotoData()
        let page = 23
        
        mockData.getData(pagination: page, onComplete: { photo in
            XCTAssertEqual(photo.first, mockData.mockPhotos, "onComplete should return the model created inside the class")
        })
        
        XCTAssertEqual(mockData.pages, page, "Pages should equal to the pagination object inputted")
    }
    
    func testPhotoDataProtocolInsideViewController() {
        let mockData = MockPhotoData()
        
        let vc = ImageViewController(dataProvider: mockData)
        vc.loadViewIfNeeded()
        vc.collection.performBatchUpdates(nil, completion: nil)
        
        vc.getData(pagination: 0, onComplete: { response in
            XCTAssertEqual(response.first, mockData.mockPhotos, "This call should respond back with the object inside the mock")
        })

        
    }



}
