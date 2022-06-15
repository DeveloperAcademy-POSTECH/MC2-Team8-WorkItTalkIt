//
//  SideTableViewCell.swift
//  WorkItTalkIt
//
//  Created by Somin Park on 2022/06/14.
//

import UIKit

class SideTableViewCell: UITableViewCell {

    static let identifier = "SideTableViewCell"
    
    @IBOutlet weak var folderNameLabel: UILabel!
    @IBOutlet weak var folderImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //cell 레이아웃
        self.folderImage.image = UIImage(systemName: "folder")
        self.folderImage.tintColor = UIColor(red: 19/255, green: 90/255, blue: 165/255, alpha: 1)
        
        self.folderNameLabel.tintColor = UIColor.black
        self.backgroundColor = UIColor.clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
