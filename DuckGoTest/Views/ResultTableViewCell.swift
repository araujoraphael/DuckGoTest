//
//  ResultTableViewCell.swift
//  DuckGoTest
//
//  Created by Raphael Araújo on 2018-05-16.
//  Copyright © 2018 Raphael Araújo. All rights reserved.
//

import UIKit
import SDWebImage

class ResultTableViewCell: UITableViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var resultTextLabel: UILabel!

    var item: DuckGoResultItem? {
        didSet {
            self.layoutSubviews()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.resultTextLabel?.text = item?.text
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView?.image = nil
    }
    
}
