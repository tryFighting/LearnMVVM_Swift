//
//  MVVMCItemTableViewCell.swift
//  MVVM-C
//
//  Created by Scotty on 21/05/2016.
//  Copyright © 2016 Streambyte Limited. All rights reserved.
//

import UIKit

class MVVMCItemTableViewCell: UITableViewCell {

     var nameLabel: UILabel!
    
    var item: DataItem? {
        didSet {
            if let item = item {
                nameLabel.text = item.name
            } else {
                nameLabel.text = "Unknown"
            }
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.nameLabel = UILabel()
        self.nameLabel.frame = CGRect(x: 20, y: 5, width: 100, height: 20)
        self.contentView.addSubview(self.nameLabel)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
