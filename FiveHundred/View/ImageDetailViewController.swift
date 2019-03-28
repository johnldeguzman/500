//
//  ImageDetailViewController.swift
//  FiveHundred
//
//  Created by John De Guzman on 2019-03-27.
//  Copyright © 2019 John De Guzman. All rights reserved.
//

import AsyncDisplayKit
import Hero

class ImageDetailViewController: ASViewController<ASTableNode> {

    enum Sections {
        case imageHeader, name, description
        
        func cellNode(model: Photos) -> ASCellNode {
            switch self {
            case .imageHeader:
                return ImageCellNode(url: model.biggerImageURL)
            case .name:
                let attributedString = FontConstants.header.attributesedString(text: model.name)
                return LabelCellNode(title: attributedString)
            case .description:
                let attributedString = FontConstants.description.attributesedString(text: model.description)
                print(model.description)
                return LabelCellNode(title: attributedString)
            }
        }
    }
    
    var tableNode: ASTableNode!
    
    var data: Photos!
    
    var sections: [Sections] = []
    
    init(data: Photos) {
        tableNode = ASTableNode()
        
        super.init(node: tableNode)
        
        self.data = data
        
        self.hero.isEnabled = true
        
        sections = [.imageHeader, .name, .description]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableNode.delegate = self
        tableNode.dataSource = self
        
        tableNode.view.tableFooterView = UIView()
        tableNode.view.separatorStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ImageDetailViewController: ASTableDataSource {
    
    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        return sections[indexPath.row].cellNode(model: data)
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return sections.count
    }
    
    func tableNode(_ tableNode: ASTableNode, constrainedSizeForRowAt indexPath: IndexPath) -> ASSizeRange {
        
        let height: CGFloat = indexPath.row == 0 ? 300 : 20
        let min = CGSize(width: UIScreen.main.bounds.size.width, height: height)
        let max = CGSize(width: UIScreen.main.bounds.size.width, height: CGFloat.greatestFiniteMagnitude)
        return ASSizeRange(min: min, max: max)
    }

}

extension ImageDetailViewController: ASTableDelegate {
    
}
