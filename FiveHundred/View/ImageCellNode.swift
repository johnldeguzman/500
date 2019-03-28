//
//  ImageCellNode.swift
//  FiveHundred
//
//  Created by John De Guzman on 2019-03-25.
//  Copyright © 2019 John De Guzman. All rights reserved.
//

import AsyncDisplayKit
import Hero

class ImageCellNode: ASCellNode {
    
    var image: ASNetworkImageNode!
    
    init(url: String) {
        
        super.init()
        
        image = ASNetworkImageNode()
        image.url = URL(string: url)
        
        image.style.flexGrow = 1.0
        image.contentMode = .scaleAspectFill
        image.shouldRenderProgressImages = true
        
        addSubnode(image)
        
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let stack = ASStackLayoutSpec()
        stack.direction = .horizontal
        stack.children?.append(image)
        
        
        return stack
    }
    
}
