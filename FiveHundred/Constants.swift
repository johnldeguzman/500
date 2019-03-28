//
//  Constants.swift
//  FiveHundred
//
//  Created by John De Guzman on 2019-03-27.
//  Copyright © 2019 John De Guzman. All rights reserved.
//

import Foundation
import UIKit

enum FontConstants {
    case header, description
    
    func attributesedString(text: String) -> NSAttributedString {
        
        var attributes: [NSAttributedString.Key : Any] = [:]
        
        switch self {
        case .header:
            attributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24)]
        case .description:
            attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
        }
        
        return NSAttributedString(string: text, attributes: attributes)
    }
}
