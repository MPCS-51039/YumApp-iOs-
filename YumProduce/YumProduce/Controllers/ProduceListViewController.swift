//
//  ViewController.swift
//  YumProduce
//
//  Created by Mariel Wiechers on 4/10/22.
//

import UIKit

class ProduceListViewController: UIViewController {
    
    @IBOutlet weak var seasonCollectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    var seasons: [Season]!
    var market: [Produce] = []

    var produceService: ProduceService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.seasons = [
            Season(name:"Year-round",imageUrl: "https://thumbs.dreamstime.com/z/graphic-black-flat-vector-all-four-seasons-icon-isolated-winter-spring-summer-autumn-year-round-sign-snow-rain-sun-symbols-eps-137606744.jpg" ),
            Season(name:"Spring", imageUrl: "https://www.creativefabrica.com/wp-content/uploads/2021/08/13/Flower-icon-four-pink-flower-design-art-Graphics-15836070-1.jpg"),
            Season(name: "Summer", imageUrl: "https://icon-library.com/images/summer-icon/summer-icon-9.jpg"),
            Season(name:"Fall", imageUrl: "https://www.downloadclipart.net/large/autumn-fall-leaves-clip-art-png.png"),
            Season(name:"Winter", imageUrl: "https://cdn1.iconfinder.com/data/icons/winter-123/512/snowflake-snow-winter-cold-nature-1024.png") ]
        
        self.seasonCollectionView.dataSource = self
        self.seasonCollectionView.delegate = self
        
        self.produceService = ProduceService()

        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) { //here we can inject part of our code, trade out our mock for real service

        if self.market.isEmpty {
            self.loadTable()
        }
    
        if ProduceData.instance.shouldReloadIndex {
            self.seasonCollectionView.reloadData()
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
        if (segue.identifier != "SeasonalSegue") {
            guard
                let destination = segue.destination as? DetailViewController,
                let selectedIndexPath = self.tableView.indexPathForSelectedRow,
                let confirmedCell = self.tableView.cellForRow(at: selectedIndexPath) as? ProduceCell
                else { return }
            let confirmedProduce = confirmedCell.produce
            destination.produce = confirmedProduce
    }
        else {
            if let cell = sender as? SeasonCell,
               let indexPath = self.seasonCollectionView.indexPath(for: cell) {
                
                let destination = segue.destination as? SeasonListViewController
                destination!.season = seasons[indexPath.row]
            }
    }
}
}


extension ProduceListViewController: UITableViewDataSource, UITableViewDelegate {
    //    MARK: TableView

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.market.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = self.tableView.dequeueReusableCell(withIdentifier: "produceCell") as! ProduceCell
           let currentProduce = self.market[indexPath.row]
           cell.produce = currentProduce
           
           return cell
       }
    
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

//    MARK: Collection View
extension ProduceListViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.seasons.count
        }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
  
        let cell = self.seasonCollectionView.dequeueReusableCell(withReuseIdentifier: "seasonCell", for: indexPath) as! SeasonCell
        let selectedSeason = self.seasons[indexPath.row]
        cell.season = selectedSeason
        return cell
       }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        
//        self.performSegue(withIdentifier: "SeasonalSegue", sender: indexPath)
//    }
    
}



