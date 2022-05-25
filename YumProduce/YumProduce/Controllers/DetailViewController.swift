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
    
}

