//
//  TableViewCell.swift
//  CombineOnUIKit
//
//  Created by Rajesh Kumar Sahil on 14/08/2022.
//

import UIKit
import Combine

class TableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    var deleteButtonClicked = PassthroughSubject<String?, Never>()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func onTapDeleteButton(_ sender: UIButton) {
        deleteButtonClicked.send(titleLabel.text)
    }
    
}
