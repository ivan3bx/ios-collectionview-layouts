//
//  StackFlowLayout.swift
//  CardStack
//
//  Created by Ivan M on 4/23/16.
//  Copyright © 2016 3bx.co. All rights reserved.
//

import UIKit

class StackFlowLayout: UICollectionViewLayout {
    
    // MARK: Card constants
    let cardSize      = CGSize(width: 250.0, height: 300.0)
    let stackOverhang = CGFloat(12) // points to set back from lower card
    
    // MARK: Center points on screen (one for center-focus, one for top stack)
    var centerScreen:CGPoint!
    var centerStack:CGPoint!
    
    var selectedCardIndex:Int = 0
    var attributes = [UICollectionViewLayoutAttributes]()
    
    override func collectionViewContentSize() -> CGSize {
        return CGSize(
            width: collectionView!.bounds.width,
            height: collectionView!.bounds.height
        )
    }
    
    override func prepareLayout() {
        super.prepareLayout()
        
        centerScreen = CGPoint(
            x: collectionView!.bounds.width / 2,
            y: collectionView!.bounds.height / 2
        )
        
        centerStack = CGPoint(
            // Center the stack in the middle of screen
            x: collectionView!.bounds.width / 2,
            // Calculate y: start at top of the view (y == 0)
            y: collectionView!.bounds.origin.y
                // ..add enough to 'y' to allow an entire card to be shown (top of card at origin.y)
                + (cardSize.height / 2)
                // ..pull back to only show overhang for top cards to be displayed
                - (cardSize.height + (stackOverhang * 3))
        )
        
        if let view = collectionView {
            let endIndex = view.numberOfItemsInSection(0) - 1
            
            attributes = (0...endIndex).map { (idx) -> UICollectionViewLayoutAttributes in
                let attribs = UICollectionViewLayoutAttributes(forCellWithIndexPath: NSIndexPath(forRow: idx, inSection: 0))
                attribs.size   = cardSize
                attribs.center = centerForItem(idx)
                attribs.zIndex = 999 - idx
                return attribs
            }
        }
    }
    
    func centerForItem(index:Int) -> CGPoint {
        if index == selectedCardIndex {
            return CGPoint(x: centerScreen.x, y: centerScreen.y - (stackOverhang * CGFloat(index)))
        } else {
            return CGPoint(x: centerStack.x, y: centerStack.y + (stackOverhang * CGFloat(index)))
        }
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        return attributes[indexPath.row]
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributes
    }
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
}
