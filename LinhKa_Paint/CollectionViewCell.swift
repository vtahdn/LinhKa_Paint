//
//  CollectionViewCell.swift
//  LinhKa_Paint
//
//  Created by macbook on 10/13/18.
//  Copyright © 2018 Viet. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    let cellWidth: CGFloat = 44
    // Cell images
    var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addSubviews()
    }
    
    func addSubviews() {
        if imageView == nil {
            imageView = UIImageView(frame: CGRectMake(0, 0, cellWidth, cellWidth))
            imageView.layer.borderColor = tintColor.CGColor
            contentView.addSubview(imageView)
        }
    }
    
    override var selected: Bool {
        didSet {
            imageView.layer.borderWidth = selected ? 2 : 0
        }
    }
}
