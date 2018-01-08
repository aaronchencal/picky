//
//  FoodTableViewController.swift
//  Picky
//
//  Created by Aaron Chen on 12/29/17.
//  Copyright © 2017 ACDev. All rights reserved.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

class FoodTableViewController: UITableViewController {
    
    var fData : FilterData!
    
    @IBAction func logOut(_ sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            GIDSignIn.sharedInstance().signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        self.performSegue(withIdentifier: "logout", sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    //google: drive and $$
    //bill:  walk and $$$ and top two checks
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return fData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "filterCell", for: indexPath)
        let fItem = fData.getFilterItemAt(index: indexPath.row)
        cell.textLabel?.text = fItem.name
        cell.accessoryType = fItem.checked ? .checkmark : .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row < fData.count
        {
            let fItem = fData.getFilterItemAt(index: indexPath.row)
            fItem.checked = !fItem.checked
            tableView.reloadRows(at: [indexPath], with: .none)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dvc = segue.destination as? PickyViewController {
            dvc.receiveData(data: fData)
        }
    }
    

}
