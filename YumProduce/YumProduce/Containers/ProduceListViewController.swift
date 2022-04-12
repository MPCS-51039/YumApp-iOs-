//
//  ViewController.swift
//  YumProduce
//
//  Created by Mariel Wiechers on 4/10/22.
//

import UIKit

class ProduceListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var market: [Produce] = []
    var produceService: ProduceService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.produceService = ProduceService()
        self.market = self.produceService.getProduce()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
}

extension ProduceListViewController: UITableViewDataSource {
    //    MARK: DataSource

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.market.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "produceCell") as! ProduceCell
        
        let currentProduce = self.market[indexPath.row]
        
        cell.produce = currentProduce
        
        return cell

        }
}

extension ProduceListViewController: UITableViewDelegate {
    //    MARK: Delegate
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if
//            let cell = self.tableView.cellForRow(at: indexPath) as? ProduceCell,
//            let confirmedProduce = cell.produce
//        {
//            confirmedProduce.confirmedEaten = true
//          cell.accessoryType = confirmedProduce.confirmedEaten ? .checkmark : .none
//        }
        
//    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if
            let cell = self.tableView.cellForRow(at: indexPath) as? ProduceCell,
            let confirmedProduce = cell.produce
        {
            let eatenStatus = confirmedProduce.pendingEat
            let title = eatenStatus ?
                NSLocalizedString("Eaten", comment: "Eaten") :
                NSLocalizedString("Not Eaten", comment: "Not Eaten")
            
            let action = UIContextualAction(style: .normal, title: title, handler: { (action, view, completionHandler) in
                confirmedProduce.pendingEat = !confirmedProduce.pendingEat
                completionHandler(true)
            })
                
            action.image = UIImage(named: "diamond.inset.fill")
            action.backgroundColor = eatenStatus ? .systemGreen : .systemRed
            let configuration = UISwipeActionsConfiguration(actions: [action])
            configuration.performsFirstActionWithFullSwipe = false
            return configuration
        }
        return nil
        
        
    }

}

