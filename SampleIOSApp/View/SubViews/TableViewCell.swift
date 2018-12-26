//
//  TableViewCell.swift
//  SampleIOSApp
//
//  Created by gayan perera on 12/26/18.
//  Copyright © 2018 gayan perera. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    //outlets
    @IBOutlet weak var uiImageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var address: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        CornerRadiusInCircle()
        // Initialization code
    }
    func CornerRadiusInCircle(){
        uiImageView.layer.cornerRadius = 45.0
        uiImageView.clipsToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
