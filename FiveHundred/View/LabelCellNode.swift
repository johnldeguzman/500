//
//  LabelCellNode.swift
//  FiveHundred
//
//  Created by John De Guzman on 2019-03-27.
//  Copyright © 2019 John De Guzman. All rights reserved.
//

import AsyncDisplayKit
import Hero

class LabelCellNode: ASCellNode {
    
    var label: ASTextNode!
    
    init(title: NSAttributedString) {
        
        super.init()
        
        label = ASTextNode()
        label.attributedText = title
        label.maximumNumberOfLines = 0
        label.style.flexGrow = 1.0
        addSubnode(label)
        
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let stack = ASStackLayoutSpec()
        stack.direction = .vertical
        stack.children?.append(label)
        
        
        return stack
    }
    
}
