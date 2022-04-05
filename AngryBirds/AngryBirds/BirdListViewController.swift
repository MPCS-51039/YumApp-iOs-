//
//  ViewController.swift
//  AngryBirds
//
//  Created by Mariel Wiechers on 4/4/22.
//

import UIKit

class BirdListViewController: UIViewController {


    @IBOutlet weak var tableView: UITableView!
    
    var flock: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.flock = ["Oriole", "Bluebird", "Blackbird", "Oriole", "Bluebird", "Blackbird", "Oriole", "Bluebird", "Blackbird", "Oriole", "Bluebird", "Blackbird", "Oriole", "Bluebird", "Blackbird"]
        
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
            
            cell.birdNameLabel.text = self.flock[indexPath.row]
            cell.birdDescriptionLabel.text = "He angry"
            
            return cell
        }
            
        
    }

extension BirdListViewController: UITableViewDelegate {
//    MARK: Delegate
    
    
}

