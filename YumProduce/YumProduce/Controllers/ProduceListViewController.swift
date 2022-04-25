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
        
        self.produceService = ProduceService() //assign new Service to new service, how to inject nock service before it gets called?
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) { //here we can inject part of our code, trade out our mock for real service
        guard let confirmedService = self.produceService else { return }
        
        confirmedService.getProduce(completion: { produces, error in
            guard let produces = produces, error == nil else {
                return
            }
            
            switch (produces.count) {
            case 0:
                print("empty json")
                let labelRect = CGRect(x: 80, y: 100, width: 200, height: 100)
                let label = UILabel(frame: labelRect)
                label.textColor = .systemRed
                label.text = "No Produce to show :("
                label.numberOfLines = 2
                self.tableView.addSubview(label)
                
            default:
                self.market = produces
            }
            self.tableView.reloadData()
            
        })
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //  downcast from UIVIew contorler to detail view conteoller, optional return so, if destination is nil
        guard
            let destination = segue.destination as? DetailViewController,
            let selectedIndexPath = self.tableView.indexPathForSelectedRow,
            let confirmedCell = self.tableView.cellForRow(at: selectedIndexPath) as? ProduceCell
            else { return }
            
        let confirmedProduce = confirmedCell.produce
        destination.produce = confirmedProduce
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
            let eatenStatus = confirmedProduce.confirmedEaten
            let title = eatenStatus ?
                NSLocalizedString("Eaten", comment: "Eaten") :
                NSLocalizedString("Not Eaten", comment: "Not Eaten")

            let action = UIContextualAction(style: .normal, title: title, handler: { (action, view, completionHandler) in
                confirmedProduce.confirmedEaten = !confirmedProduce.confirmedEaten
                completionHandler(true)
            
            action.image = eatenStatus ? UIImage(named: "diamond.inset.fill") : .none

                
            })
            
            action.backgroundColor = eatenStatus ? .systemGreen : .systemRed
        
            let configuration = UISwipeActionsConfiguration(actions: [action])
            configuration.performsFirstActionWithFullSwipe = false
            return configuration
        }
        return nil
        
        
    }
}



