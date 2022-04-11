//
//  ViewController.swift
//  YumProduce
//
//  Created by Mariel Wiechers on 4/10/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var market: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.market = ["brocolli", "Aspaaraguss", "Cocos",
                       "brocolli", "Aspaaraguss", "Cocos",
                       "brocolli", "Aspaaraguss", "Cocos",
                       "brocolli", "Aspaaraguss", "Cocos",
                       "brocolli", "Aspaaraguss", "Cocos",
                       "brocolli", "Aspaaraguss", "Cocos",
                       "brocolli", "Aspaaraguss", "Cocos"]
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
//    MARK: DataSource

func tableView(_ tableView: UITableView, numberOfRowsInSection
    section: Int) -> Int {
    return self.market.count
    
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = self.tableView.dequeueReusableCell(withIdentifier: "produceCell")!
    
    cell.textLabel?.text = self.market[indexPath.row]
    
    return cell


    }

}
