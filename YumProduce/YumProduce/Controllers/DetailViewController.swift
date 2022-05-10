//
//  DetailViewController.swift
//  YumProduce
//
//  Created by Mariel Wiechers on 4/18/22.
//

import UIKit

class DetailViewController: UIViewController {
    var produce: Produce? // set variable in detail view controller, proud e that is of Produce typpe ! = force unwrap, only if Produce present -> there is detail

    
    @IBOutlet weak var produceBannerImage: UIImageView!
    @IBOutlet weak var produceName: UILabel!
   
    @IBOutlet weak var produceSeasonLabel: UILabel!
    @IBOutlet weak var produceStorageDescription: UILabel!
    @IBOutlet weak var produceStatusLabel: UILabel!

    @IBOutlet var starButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.produceName.text = produce?.name
        self.produceStorageDescription.text = produce?.description
        self.produceSeasonLabel.text = produce?.season
        self.produceStatusLabel.text = produce?.status
//        self.ratingDetailLabel.text = produce?.rating
        
        
        DispatchQueue.global(qos: .userInitiated).async {
            let produceImageData = NSData(contentsOf: URL(string: self.produce!.imageUrl)!)
            DispatchQueue.main.async {
                self.produceBannerImage.image = UIImage(data: produceImageData! as Data)
            }
            //        self.produceBannerImage.image = produce?.imageUrl

                    // Do any additional setup after loading the view.

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

        }
}
    
    @IBAction func buttonTapped(_ sender: UIButton) {
            print("Rated \(sender.tag) stars.")
        
        for button in self.starButtons {
            print(button.tag)
            if button.tag <= sender.tag {
                button.setBackgroundImage(UIImage.init(named: "star.fill"), for: .normal)
            } else {
                button.setBackgroundImage(UIImage.init(named: "star"), for: .normal)
        }
    }
        produce?.rating = sender.tag
}
}
