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


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return fData.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "filterCell", for: indexPath) as! FoodTableViewCell
        let fItem = fData.getFilterItemAt(index: indexPath.row)
        cell.myLabel.text = fData.names[fItem.name]
        cell.myImageView.image = fItem.image
        if fItem.checked {
            cell.myLabel.textColor = UIColor.black
            let attritext = NSMutableAttributedString(string: (cell.myLabel?.text)!)
            attritext.addAttribute(.strikethroughStyle, value: 2, range: NSMakeRange(0, attritext.length))
            cell.myLabel.attributedText = attritext
            cell.myImageView.alpha = 0.5
            cell.myLabel.layer.shadowOpacity = 0
        } else {
            cell.myLabel.textColor = UIColor.white
            cell.myImageView.alpha = 1
            cell.myLabel.layer.shadowOpacity = 1
            cell.myLabel.layer.shadowColor = UIColor.black.cgColor
            cell.myLabel.layer.shadowOffset = CGSize(width: 0.7, height: 0.7)
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
        fData.persist()
        if let dvc = segue.destination as? PickyViewController {
            dvc.receiveData(data: fData)
        }
    }
    

}
