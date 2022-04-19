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
    @IBOutlet weak var produceImageView: UIImageView!
    
    var produce: Produce? {
        didSet {
            self.produceNameLabel.text = produce?.name
            self.produceDescriptionLabel.text = produce?.description
            self.accessoryType = produce!.confirmedEaten ? .checkmark : .none
            
            DispatchQueue.global(qos: .userInitiated).async {
                let produceImageData = NSData(contentsOf: URL(string: self.produce!.imageUrl)!)
                
                DispatchQueue.main.async {
                    self.produceImageView.image = UIImage(data: produceImageData! as Data)
                    self.produceImageView.layer.cornerRadius = self.produceImageView.frame.width / 2
                }
            }
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
