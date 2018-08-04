//
//  ViewController.swift
//  RecipePuppy
//
//  Created by Daniel Plata on 2/8/18.
//  Copyright © 2018 Daniel Plata. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var dataSource:[Results] = []

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var notResultsLbl: UILabel!
    
    var nameCell: String = "SimpleCell"
    
    @IBAction func searchChanged(_ sender: UITextField) {
        loadData(text: sender.text!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData(text: "")
        
        tableView.register(UINib(nibName: nameCell, bundle: nil), forCellReuseIdentifier: nameCell)

    }
    
    func loadData(text: String){
        RecipesResponse.getRecipesRequest(search: text) { (recipesResponse, error) in
            
            let didReceivedData: Bool = !(error || recipesResponse!.results!.count <= 0)
            
            self.dataSource = recipesResponse!.results!

            self.setResultsView(resultsExist: didReceivedData)
            
            self.tableView.reloadData()
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setResultsView(resultsExist: Bool){
        self.tableView.isHidden = !resultsExist
        self.notResultsLbl.isHidden = resultsExist
    }
}
    
extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: nameCell, for: indexPath) as? SimpleCell, dataSource.count > 0{

            cell.configureWithData(recipe: dataSource[indexPath.row])
            
            return cell
        }
        
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Celda pulsada")
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.white
    }
    
}
