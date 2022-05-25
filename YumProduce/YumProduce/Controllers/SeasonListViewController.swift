//
//  SeasonListViewController.swift
//  YumProduce
//
//  Created by Mariel Wiechers on 5/24/22.
//

import UIKit

class SeasonListViewController: UIViewController {
    
    var season: Season!
    
    @IBOutlet weak var seasonalTableView: UITableView!
    
    var seasonal: [Produce] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = season.name
        
        self.seasonalTableView.dataSource = self
        self.seasonalTableView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.seasonal = []
        
        for produce in ProduceData.instance.produces {
            if produce.season == season.name {
                self.seasonal.append(produce)
            }
        }
        
        self.seasonalTableView.reloadData()

}
                                    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let destination = segue.destination as? DetailViewController,
            let selectedIndexPath = self.seasonalTableView.indexPathForSelectedRow,
            let selectedCell = self.seasonalTableView.cellForRow(at: selectedIndexPath) as? ProduceCell
            else { return }
            
        let selectedProduce = selectedCell.produce
        destination.produce = selectedProduce
    }
}



extension SeasonListViewController: UITableViewDataSource {
    //    MARK: DataSource

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.seasonal.count
    }
    

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.seasonalTableView.dequeueReusableCell(withIdentifier: "produceCell") as! ProduceCell

        let currentProduce = self.seasonal[indexPath.row]
        
        cell.produce = currentProduce
        
        return cell
    }
}


extension SeasonListViewController: UITableViewDelegate {
    //    MARK: Delegate

    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if
            let cell = self.seasonalTableView.cellForRow(at: indexPath) as? ProduceCell,
            let confirmedProduce = cell.produce
        {
            let title = confirmedProduce.inKitchen ?
                NSLocalizedString("Yum!", comment: "Yum!") :
                NSLocalizedString("Add", comment: "Add")

            let action = UIContextualAction(style: .normal, title: title, handler: { (action, view, completionHandler) in
                confirmedProduce.inKitchen = !confirmedProduce.inKitchen
                
                let kitchen = UIImageView(frame: CGRect(x: 25, y: 65, width: 35, height: 35))
                kitchen.image = UIImage(systemName: "fork.knife.circle")
                kitchen.tintColor = .systemGreen
                
                cell.accessoryView = confirmedProduce.inKitchen ? kitchen : .none
    
                completionHandler(true)
            })
            
            action.backgroundColor = confirmedProduce.inKitchen ? .systemGray2 : .systemGreen
        
            let configuration = UISwipeActionsConfiguration(actions: [action])
            configuration.performsFirstActionWithFullSwipe = false
            return configuration
        }
        return nil
    }
   
}

                                   



