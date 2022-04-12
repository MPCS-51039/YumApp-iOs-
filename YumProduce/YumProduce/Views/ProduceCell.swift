//
//  ProduceCell.swift
//  YumProduce
//
//  Created by Mariel Wiechers on 4/10/22.
//

import UIKit

class ProduceCell: UITableViewCell {

    @IBOutlet weak var produceNameLabel: UILabel!
    @IBOutlet weak var produceDescriptionLabel: UILabel!
    
    var produce: Produce? {
        didSet {
            self.produceNameLabel.text = produce?.name
            self.produceDescriptionLabel.text = produce?.description
            self.accessoryType = produce!.confirmedEaten ? .checkmark : .none  
//            self.accessoryView = produce!.eaten! ? UIImage(systemName: "flame.fill") : .none
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
