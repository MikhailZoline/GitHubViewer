//
//  CollectionViewCell.swift
//  GitHubViewer
//
//  Created by Mikhail Zoline on 1/10/19.
//  Copyright © 2019 MZ. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet var name: UILabel!
    
    @IBOutlet var descr: UILabel!
    
    @IBOutlet var license: UILabel!
    
    @IBOutlet var created: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    /*  TO DO: Self adjusting height
    var isHeightCalculated: Bool = false
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        //Exhibit A - We need to cache our calculation to prevent a crash.
        if !isHeightCalculated {
            setNeedsLayout()
            layoutIfNeeded()
            let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
            var newFrame = layoutAttributes.frame
            newFrame.size.height = ceil(size.height)
            layoutAttributes.frame = newFrame
            isHeightCalculated = true
        }
        return layoutAttributes
    }
*/

}
