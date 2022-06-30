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
        backgroundColor = UIColor(white: 1, alpha: 0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
