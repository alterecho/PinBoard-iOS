//
//  ImagePageLayout.swift
//  PinBoard
//
//  Created by echo on 6/12/18.
//  Copyright © 2018 echo. All rights reserved.
//

import UIKit

class ImagePageLayout : UICollectionViewFlowLayout {
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func initialLayoutAttributesForAppearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        if let attr = self.layoutAttributesForItem(at: itemIndexPath), let collectionView = self.collectionView {
            attr.transform = attr.transform.rotated(by: CGFloat(Double.pi))
            attr.center = CGPoint(x: collectionView.bounds.midX, y: collectionView.bounds.maxY);
            return attr
        }
        
        return nil
    }
}

