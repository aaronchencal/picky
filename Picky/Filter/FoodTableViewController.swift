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
    
    @IBAction func didPressFinished(_ sender: UIBarButtonItem) {
        sender.title = "ff"
        sender.title = "Done"
        fData.persistRestaurants()
        performSegue(withIdentifier: "foodtofilter", sender: self)
        
    }
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
        if fItem.checked {
            cell.textLabel?.textColor = UIColor.lightGray
            let attritext = NSMutableAttributedString(string: (cell.textLabel?.text)!)
            attritext.addAttribute(.strikethroughStyle, value: 2, range: NSMakeRange(0, attritext.length))
            cell.textLabel?.attributedText = attritext
        } else {
            cell.textLabel?.textColor = UIColor.black
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row < fData.count
        {
            let fItem = fData.getFilterItemAt(index: indexPath.row)
            if fItem.checked || fData.canCheckMore() {
                fItem.checked = !fItem.checked
            }
            tableView.reloadRows(at: [indexPath], with: .none)
        }
    }
    
    func receiveData(filterData: FilterData, goAhead: Bool) {
        fData = filterData
        if goAhead {
             performSegue(withIdentifier: "foodtofilter", sender: self)
        }
    }
    
    //MARK: Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dvc = segue.destination as? PickyViewController {
            dvc.receiveData(data: fData)
        }
    }
    

}
