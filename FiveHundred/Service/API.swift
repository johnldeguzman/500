//
//  API.swift
//  FiveHundred
//
//  Created by John De Guzman on 2019-03-26.
//  Copyright © 2019 John De Guzman. All rights reserved.
//

import Foundation
import Alamofire

protocol Routable {
    typealias Parameters = [String: Any]
    var route: String {get set}
    var urlParams: String! {get set}
    init()
}

extension Routable {
    
    init(_ arg: String = "") {
        self.init()
        urlParams = arg
    }
    
    func nestedRoute(args: String?, child: RequestConverterProtocol) -> RequestConverter {
        var urlarg = ""
        
        if args != nil {
            urlarg = "\(args!)/"
        }
        
        return RequestConverter(
            method: child.method,
            route: "\(self.route)/\(urlarg)\(child.route)",
            parameters: child.parameters,
            encoding: child.encoding
        )
    }
    
    func nestedRouteURL(parent: Routable, child: Routable) -> String {
        var params = ""
        if parent.urlParams != nil {
            params = "\(parent.urlParams!)/"
        }
        let nestedRoute = "\(parent.route)/\(params)" + child.route
        return nestedRoute
    }
}

protocol Read: Routable {}
protocol Post: Routable {}
protocol Update: Routable {}
protocol Delete: Routable {}

extension Read {
    static func getQuery (params: [String: Any]) -> RequestConverter {
        let temp = Self.init()
        let route = "\(temp.route)"
        let encoding = URLEncoding.default
        return RequestConverter(method: .get, route: route, parameters: params, encoding: encoding)
    }
}

protocol RequestConverterProtocol: URLRequestConvertible {
    var method: HTTPMethod {get set}
    var route: String {get set}
    var parameters: Parameters {get set}
    var encoding: ParameterEncoding {get set}
}


struct RequestConverter: RequestConverterProtocol {
    var method: HTTPMethod
    var route: String
    var parameters: Parameters = [:]
    var encoding: ParameterEncoding
    
    var baseURL: String {
        return "https://api.500px.com/"
    }
    
    init (method: HTTPMethod, route: String, parameters: Parameters = [:], encoding: ParameterEncoding = URLEncoding.default) {
        self.method = method
        self.route = route
        self.parameters = parameters
        self.encoding = encoding
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try baseURL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(route))
        urlRequest.httpMethod = method.rawValue
        return try encoding.encode(urlRequest, with: parameters)
    }
}

protocol hasPhotos {}

enum Feature: String {
    case popular, highest_rated, upcoming, editors, fresh_today, fresh_yesterday, fresh_week
}

extension hasPhotos where Self: Routable {
    func getPhotos(feature: Feature, pagination: Int = 1, size: Int = 2) -> RequestConverterProtocol {
        let path = Bundle.main.path(forResource: "Key", ofType: "plist")
        let key = NSDictionary(contentsOfFile: path ?? "")?["CONSUMER_KEY"] ?? ""
        
        var sizeString = "2"
        
        if size != 2 {
            sizeString = sizeString + ",\(size)"
        }
        
        
        let params = ["feature": feature.rawValue, "page": String(pagination), "consumer_key": key, "image_size":sizeString]
        return nestedRoute(args: urlParams, child: Route.Photos.getQuery(params: params))
    }
}
