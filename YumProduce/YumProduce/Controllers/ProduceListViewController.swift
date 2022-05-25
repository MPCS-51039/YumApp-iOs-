//
//  ViewController.swift
//  YumProduce
//
//  Created by Mariel Wiechers on 4/10/22.
//

import UIKit

class ProduceListViewController: UIViewController {
    
    @IBOutlet weak var spinnerView: UIView! {
           didSet {
               spinnerView.layer.cornerRadius = 6
           }
       }
    
    
    @IBOutlet weak var spinnerIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var seasons: [ProduceSeason] = []
    var market: [Produce] = [] {
        didSet {
            self.tableView.reloadData()
        }}
    var produceService: ProduceService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        func showSpinner() {
            spinnerIndicator.startAnimating()
            spinnerView.isHidden = false
        }

        func hideSpinner() {
            spinnerIndicator.stopAnimating()
            spinnerView.isHidden = true
        }
//
//        // Do any additional setup after loading the view.
//
//        showSpinner()
        
        self.produceService = ProduceService()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            hideSpinner()
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) { //here we can inject part of our code, trade out our mock for real service

        if self.market.isEmpty {
            self.loadTable()
        }
    
        if ProduceData.instance.shouldReloadIndex {
            self.tableView.reloadData()
            ProduceData.instance.shouldReloadIndex = false
        }
    }
    
    
    @objc func loadTable() {
        
        guard let confirmedService = self.produceService else { return }
        
        confirmedService.getProduce(completion: { produces, error in
            guard let produces = produces, error == nil else {
                let alert = UIAlertController(title: "Error", message: "Unable to fetch instances from API. Try again later", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {_ in }))
                
            self.present(alert, animated: true, completion: nil)
                
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
            let produces = produces.sorted(by: { $0.name < $1.name })
            self.market = produces
            
            ProduceData.instance.produces = produces
            
            self.tableView.reloadData()
        }
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



