//
//  ViewController.swift
//  CardStack
//
//  Created by Ivan M on 4/23/16.
//  Copyright © 2016 3bx.co. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {
    
    let items = ["Bob", "Sally", "Chris", "Steve", "Crystal", "George", "Clara", "Buddy"]
    let colors = [
        UIColor.yellowColor(),
        UIColor.blueColor(),
        UIColor.lightGrayColor(),
        UIColor.brownColor(),
        UIColor.orangeColor(),
        UIColor.redColor(),
        UIColor.greenColor(),
        UIColor.cyanColor()
    ]
    
    var selectedIndex = 0
    
    // Generates a random color
    var randomColor:UIColor {
        let randomRed:CGFloat = CGFloat(drand48())
        let randomGreen:CGFloat = CGFloat(drand48())
        let randomBlue:CGFloat = CGFloat(drand48())
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
    
    var stackLayout:StackFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stackLayout = collectionView?.collectionViewLayout as! StackFlowLayout
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // TODO: transition / animation
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("Selected item at index: \(indexPath.row)")
        selectedIndex = indexPath.row
        collectionView.collectionViewLayout.invalidateLayout()
    }
}

// MARK: - Data Source methods
extension ViewController {
    override func collectionView(collectionView: UICollectionView,
                                 cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! CardCellCollectionViewCell
        
        cell.name.text = items[indexPath.row]
        cell.layer.cornerRadius = 5.0
        cell.layer.masksToBounds = true
        cell.backgroundColor = colors[indexPath.row]
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
}