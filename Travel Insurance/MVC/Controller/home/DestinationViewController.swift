//
//  DestinationViewController.swift
//  Travel Insurance
//
//  Created by Ankit Gabani on 31/10/23.
//

import UIKit

class DestinationViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var tblview: UITableView!
    @IBOutlet weak var viewB: UIView!
    
    var arrname = ["Schengen countries and the United Kingdom","United States of America, Canada, Japan, Australia","All around the world"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblview.delegate = self
        tblview.dataSource = self
        
        viewB.layer.applySketchShadow(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.08), alpha: 1, x: 0, y: 0, blur: 18, spread: 0)
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblview.dequeueReusableCell(withIdentifier: "DestinationTableviewCell") as! DestinationTableviewCell
        cell.lblDestination.text = arrname[indexPath.row]
        return cell
    }
    
    @IBAction func clickedBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func clickedNext(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "OrderDetailViewController") as! OrderDetailViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

class DestinationTableviewCell : UITableViewCell {
        
    @IBOutlet weak var lblDestination: UILabel!
   
}
    

