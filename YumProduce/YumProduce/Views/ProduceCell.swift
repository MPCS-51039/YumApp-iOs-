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
    @IBOutlet weak var ratingImageView: UIImageView!
    
    var produce: Produce? {
        didSet {

            self.produceNameLabel.text = produce?.name
            self.ratingImageView.image = image(forRating: produce!.rating )
//            self.accessoryType = produce!.confirmedEaten ? .checkmark : .none
            
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
    private func image(forRating rating: Int) -> UIImage? {
        let imageName = "\(rating)StarsSmall"
        return UIImage(named: imageName)
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
