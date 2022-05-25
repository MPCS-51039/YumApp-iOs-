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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.produceName.text = produce?.name
        self.produceStorageDescription.text = produce?.description
        self.produceSeasonLabel.text = produce?.season
        
        
        DispatchQueue.global(qos: .userInitiated).async {
            let produceImageData = NSData(contentsOf: URL(string: self.produce!.imageUrl)!)
            DispatchQueue.main.async {
                self.produceBannerImage.image = UIImage(data: produceImageData! as Data)
            }

        }
    }
    
    @IBAction func addToKitchenButton(_ sender: UIButton) {
        produce?.inKitchen = true
        ProduceData.instance.shouldReloadIndex = true
    }
}

