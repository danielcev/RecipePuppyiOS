//
//  ViewController.swift
//  RecipePuppy
//
//  Created by Daniel Plata on 2/8/18.
//  Copyright © 2018 Daniel Plata. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var dataSource:[Results]?

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var notResultsLbl: UILabel!
    
    @IBAction func searchChanged(_ sender: UITextField) {
        loadData(text: sender.text!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }
    
    func loadData(text: String){
        RecipesResponse.getRecipesRequest(search: text) { (recipesResponse, error) in
            
            if !error{
                self.dataSource = recipesResponse!.results
                self.tableView.reloadData()
            }else{
                self.dataSource = nil
                
                self.tableView.isHidden = true
                self.notResultsLbl.isHidden = false
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
    
extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if dataSource != nil{
            
            if (dataSource?.count)! > 0{
                tableView.isHidden = false
                notResultsLbl.isHidden = true
            }else{
                tableView.isHidden = true
                notResultsLbl.isHidden = false
            }
            
            return dataSource!.count
        }else{
            tableView.isHidden = true
            notResultsLbl.isHidden = false
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "mycell")
        
        if dataSource != nil{

            cell.textLabel?.text = dataSource![indexPath.row].title!
             
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Celda pulsada")
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.white
    }
    
}


