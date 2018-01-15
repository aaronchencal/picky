//
//  RestaurantViewController.swift
//  Picky
//
//  Created by Aaron Chen on 12/31/17.
//  Copyright © 2017 ACDev. All rights reserved.
//

import UIKit

class RestaurantViewController: UIViewController {

    private var yData: YelpData.Restaurant!
    
    @IBOutlet weak var myImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    var myImage : UIImage!
    
    @IBOutlet weak var ratingsView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let myImage = myImage {
            let size = CGSize(width: myImageView.bounds.width * 1.25, height: myImageView.bounds.height * 1.25)
            self.myImage = myImage.resize(newSize: size)
        }
        myImageView.image = myImage
        self.navigationItem.title = yData.name
        titleLabel.text = yData.name
        categoryLabel.text = yData.categories.first?.title ?? "Miscellaneous"
        ratingsView.image = UIImage(named: "\(yData.rating)")
//        tempLabel.text =
//        """
//        name: \(yData.name)\n
//        place: \(yData.location.display_address)\n
//        rating: \(yData.rating)\n
//        distance: \(yData.distance)
//        """
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func receiveData(data: YelpData.Restaurant) {
            yData = data
            print(yData)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
