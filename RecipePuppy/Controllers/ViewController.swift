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
    
    @IBAction func searchChanged(_ sender: UITextField) {
        
        print("Cambio")
        
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
            return dataSource!.count
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


