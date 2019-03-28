//
//  ViewController.swift
//  FiveHundred
//
//  Created by John De Guzman on 2019-03-25.
//  Copyright © 2019 John De Guzman. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import Hero

class ImageViewController: ASViewController<ASDisplayNode> {

    /// Collection Layout
    var flowLayout: UICollectionViewFlowLayout!
    
    /// Collection Node
    var collection: ASCollectionNode!
    
    var dataProvider: PhotoDataProtocol!
    
    var data: [Photos] = []
   
    var page = 1
    
   
    init(dataProvider: PhotoDataProtocol) {
        
        flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: UIWindow().frame.width/4, height: UIWindow().frame.width/4)
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        flowLayout.scrollDirection = .vertical
        
        self.dataProvider = dataProvider
    
        super.init(node: ASDisplayNode())
        
        collection = ASCollectionNode(collectionViewLayout: flowLayout)
        collection.delegate = self
        collection.dataSource = self
        
        node.addSubnode(collection)

        view.backgroundColor = UIColor.white
        
        hero.isEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let display = ASDisplayNode()
        display.backgroundColor = .red
        node.addSubnode(display)
        
        let textNode = ASTextNode()
        textNode.attributedText = NSAttributedString(string: "joe")
        node.addSubnode(textNode)
        
        collection.frame = CGRect(x: 0, y: 0, width: UIWindow().frame.width, height: UIWindow().frame.height)
        
        node.layoutSpecBlock = { _, _ in
            let stack = ASStackLayoutSpec()
            stack.direction = .vertical
            self.collection.style.preferredSize = CGSize(width: UIWindow().frame.width, height: UIWindow().frame.height)
            stack.children?.append(textNode)
            stack.children?.append(display)
            stack.children?.append(self.collection)
            
            let inset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            let insetLayout = ASInsetLayoutSpec(insets: inset, child: stack)
            
            return insetLayout
        }

    }
    
    func getData(pagination: Int = 1, onComplete: @escaping ([Photos]) -> Void) {
        dataProvider.getData(pagination: pagination, onComplete: onComplete)
    }
    
    func fetchNewBatchWithContext(context: ASBatchContext?) {
        getData(pagination: page, onComplete: { [weak self] photos in
            guard let self = self else { return }
            self.page += 1
            let indexes: [IndexPath] = photos.enumerated().map{ index , _ in
                let section = 0
                let row = self.data.count + index
                return IndexPath(row: row, section: section)
            }
            self.data.append(contentsOf: photos)
            print(self.data.count)
            print(indexes.map{$0.row})
            self.collection.insertItems(at: indexes)
            if let context = context {
                context.completeBatchFetching(true)
            }
            
        })
    }
}

extension ImageViewController: ASCollectionDataSource {
    
    func shouldBatchFetch(for collectionNode: ASCollectionNode) -> Bool {
        return true
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, willBeginBatchFetchWith context: ASBatchContext) {
        fetchNewBatchWithContext(context: context)
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
        let url = data[indexPath.row].url
        let cell = ImageCellNode(url: url)
        cell.view.hero.id = url
        
        
        return cell
    }

    func collectionView(collectionView: ASCollectionNode, constrainedSizeForNodeAtIndexPath indexPath: NSIndexPath) -> ASSizeRange {
        let width = UIScreen.main.bounds.width
        return ASSizeRangeMake(CGSize(width: width, height: 100), CGSize(width: width, height: 100))
    }

    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
}

extension ImageViewController: ASCollectionDelegate {

    func collectionNode(_ collectionNode: ASCollectionNode, didSelectItemAt indexPath: IndexPath) {
        let photo = data[indexPath.row]
        let vc = ImageDetailViewController(data: photo)
        navigationController?.pushViewController(vc, animated: true)
    }
}
    

