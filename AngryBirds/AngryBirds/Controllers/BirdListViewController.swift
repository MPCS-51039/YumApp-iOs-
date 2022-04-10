//
//  ViewController.swift
//  AngryBirds
//
//  Created by Mariel Wiechers on 4/4/22.
//

import UIKit

class BirdListViewController: UIViewController {


    @IBOutlet weak var tableView: UITableView!
    
    var flock: [Produce] = []
    var produceService: ProduceService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        self.produceService = ProduceService()
        self.flock = self.produceService.getProduce()
        
    
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
    }
}
    
extension BirdListViewController: UITableViewDataSource {
        //  MARK: DataSource
    
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.flock.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "birdCell") as! BirdCell
            
            
            let currentProduce = self.flock[indexPath.row]
            cell.birdNameLabel.text = currentProduce.name
            cell.birdDescriptionLabel.text = currentProduce.description
            
            return cell
        }
            
        
    }

extension BirdListViewController: UITableViewDelegate {
//    MARK: Delegate
    
    
}

