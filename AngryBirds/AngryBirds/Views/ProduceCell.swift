//
//  ProduceCell.swift
//  GoodProduce
//
//  Created by Mariel Wiechers on 4/4/22.
//

import UIKit

class ProduceCell: UITableViewCell {
    
    @IBOutlet weak var birdNameLabel: UILabel!
    @IBOutlet weak var birdDescriptionLabel: UILabel!
    
    var produce: Produce? {
        didSet {
            self.birdNameLabel.text = produce?.name
            self.birdDescriptionLabel.text = produce?.description
            self.accessoryType = produce!.confirmedEaten ? .checkmark : .none
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
