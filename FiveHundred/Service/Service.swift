//
//  Service.swift
//  FiveHundred
//
//  Created by John De Guzman on 2019-03-27.
//  Copyright © 2019 John De Guzman. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol PhotoDataProtocol {
    func getData(pagination: Int, onComplete: @escaping ([Photos]) -> Void)
}

class PhotoServiceProvider: PhotoDataProtocol {
    
    func getData(pagination: Int, onComplete: @escaping ([Photos]) -> Void) {
        Alamofire.request(Route.Version().getPhotos(feature: .popular, pagination: pagination, size: 600)).responseJSON(completionHandler: {response in
            let json = JSON(response.result.value)
            var photos: [Photos] = []
            for photoData in json["photos"].arrayValue{
                let photoURL = photoData["image_url"][0].stringValue
                let biggerImageURL = photoData["image_url"][1].stringValue
                let photoId = photoData["id"].stringValue
                let name = photoData["name"].stringValue
                let description = photoData["description"].stringValue
                let photo = Photos(url:photoURL, id: photoId, name: name, description: description, biggerImageURL: biggerImageURL)
    
                photos.append(photo)
            }
            
            onComplete(photos)
        })
    }
}
