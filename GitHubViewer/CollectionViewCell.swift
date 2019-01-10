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

}
