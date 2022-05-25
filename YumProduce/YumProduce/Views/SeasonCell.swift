//
//  SeasonCell.swift
//  YumProduce
//
//  Created by Mariel Wiechers on 5/25/22.
//

import UIKit

class SeasonCell: UICollectionViewCell {
    
    static let identifier = String(describing: SeasonCell.self)

    @IBOutlet weak var seasonLabel: UILabel!
    @IBOutlet weak var seasonImageView: UIImageView!
    
    var season: Season? {
        didSet {
            self.seasonLabel.text = season?.name
            
            DispatchQueue.global(qos: .userInitiated).async {
                let seasonImageData = NSData(contentsOf: URL(string: self.season!.imageUrl)!)
                
                DispatchQueue.main.async {
                    switch (seasonImageData) {
                    case nil:
                        self.seasonImageView.image = UIImage(named: "diamond")
                    default:
                        self.seasonImageView.image = UIImage(data: seasonImageData! as Data)
                }
                    self.seasonImageView.layer.cornerRadius = self.seasonImageView.frame.width / 2
            }
        }
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

