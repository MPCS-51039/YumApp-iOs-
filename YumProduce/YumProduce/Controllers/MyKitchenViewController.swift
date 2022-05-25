//
//  MyKitchenViewController.swift
//  YumProduce
//
//  Created by Mariel Wiechers on 5/24/22.
//

import UIKit

class KitchenListViewController: UIViewController {

    @IBOutlet weak var kitchenTableView: UITableView!
    
    var kitchen: [Produce] = []
    var produceService: ProduceService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "My Kitchen"
        
        self.kitchenTableView.dataSource = self
        self.kitchenTableView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) { //here we can inject part of our code, trade out our mock for real service
        self.kitchen = []
        
        for produce in ProduceData.instance.produces {
            if produce.inKitchen {
                self.kitchen.append(produce)
            }
        }
        self.kitchenTableView.reloadData()

}
                                    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //  downcast from UIVIew contorler to detail view conteoller, optional return so, if destination is nil
        guard
            let destination = segue.destination as? DetailViewController,
            let selectedIndexPath = self.kitchenTableView.indexPathForSelectedRow,
            let selectedCell = self.kitchenTableView.cellForRow(at: selectedIndexPath) as? ProduceCell
            else { return }
            
        let selectedProduce = selectedCell.produce
        destination.produce = selectedProduce
    }
}



extension KitchenListViewController: UITableViewDataSource {
    //    MARK: DataSource

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.kitchen.count
    }
    

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.kitchenTableView.dequeueReusableCell(withIdentifier: "produceCell") as! ProduceCell

        let currentProduce = self.kitchen[indexPath.row]
        
        cell.produce = currentProduce
        
        return cell
    }
}


extension KitchenListViewController: UITableViewDelegate {
    //    MARK: Delegate

    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if
            let cell = self.kitchenTableView.cellForRow(at: indexPath) as? ProduceCell,
            let selectedProduce = cell.produce
        {
            let title = selectedProduce.inKitchen ?
                NSLocalizedString("Yum!", comment: "Yum!") :
                NSLocalizedString("Add", comment: "Add")

            let delete = UIContextualAction(style: .destructive, title: title, handler: { (action, view, completionHandler) in
                
                selectedProduce.inKitchen = !selectedProduce.inKitchen
                
                print(selectedProduce.name, selectedProduce.inKitchen)
                
                
                self.kitchen.remove(at: indexPath.row)

                // delete the table view row
                self.kitchenTableView.deleteRows(at: [indexPath], with: .fade)
    
                completionHandler(true)
                
            })
        
            let configuration = UISwipeActionsConfiguration(actions: [delete])
            configuration.performsFirstActionWithFullSwipe = false
            
            print(selectedProduce.name, selectedProduce.inKitchen)
            return configuration
        }
        return nil
    }
   
}

                                   


