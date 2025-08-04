//
//  MyPaymentMethodsViewController.swift
//  Travel Insurance
//
//  Created by Ankit Gabani on 03/11/23.
//

import UIKit

class MyPaymentMethodsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    var arrImg = ["Card1","Card2","Card1","Card2"]
    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tblView.delegate = self
        tblView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblView.dequeueReusableCell(withIdentifier: "MyPaymentMethodsTableviewCell") as! MyPaymentMethodsTableviewCell
        cell.imgCard.image = UIImage(named: arrImg[indexPath.row])
        return cell
    }
    
    @IBAction func clickedBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clickedAddCard(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddNewCardVC") as! AddNewCardVC
        let home = UINavigationController(rootViewController: vc)
        home.navigationController?.navigationBar.isHidden = true
        home.modalPresentationStyle = .overFullScreen
        self.present(home, animated: false)
    }
    
}


class  MyPaymentMethodsTableviewCell : UITableViewCell{
    
    @IBOutlet weak var lblCardDate: UILabel!
    @IBOutlet weak var lblCardNumber: UILabel!
    @IBOutlet weak var imgCard: UIImageView!
}
