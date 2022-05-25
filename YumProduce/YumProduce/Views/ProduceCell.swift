//
//  ProduceCell.swift
//  YumProduce
//
//  Created by Mariel Wiechers on 4/10/22.
//

import UIKit

class ProduceCell: UITableViewCell {

    @IBOutlet weak var produceNameLabel: UILabel!
    @IBOutlet weak var produceImageView: UIImageView!
    
    var produce: Produce? {
        didSet {

            self.produceNameLabel.text = produce?.name
            
            let kitchen = UIImageView(frame: CGRect(x: 25, y: 65, width: 35, height: 35))
            kitchen.image = UIImage(systemName: "fork.knife.circle")
            kitchen.tintColor = .systemGreen
            
            self.accessoryView = produce!.inKitchen ? kitchen : .none
            
            DispatchQueue.global(qos: .userInitiated).async {
                let produceImageData = NSData(contentsOf: URL(string: self.produce!.imageUrl)!)
                
                DispatchQueue.main.async {
                    switch (produceImageData) {
                    case nil:
                        self.produceImageView.image = UIImage(named: "diamond")
                    default:
                        self.produceImageView.image = UIImage(data: produceImageData! as Data)
                }
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
