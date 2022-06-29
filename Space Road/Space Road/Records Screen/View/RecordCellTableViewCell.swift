//
//  RecordCellTableViewCell.swift
//  Space Road
//
//  Created by Kyzu on 29.06.22.
//

import UIKit

class RecordCellTableViewCell: UITableViewCell {

    @IBOutlet weak var queueLabel: UILabel!
    @IBOutlet weak var nickLabel: UILabel!
    @IBOutlet weak var recordLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
