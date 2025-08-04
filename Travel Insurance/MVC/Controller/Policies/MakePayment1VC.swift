//
//  MakePayment1VC.swift
//  Hamraa Insurance
//
//  Created by Purv on 19/03/24.
//

import UIKit

class MakePayment1VC: UIViewController {
    
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var viewB: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    
    var arrImg = ["Card1","Card2","Card3"]
    var arrName = ["**** **** **** 1498","**** **** **** 1498","Zain Cash"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblTitle.text = ""
            
        tblView.delegate = self
        tblView.dataSource = self
        
        viewB.layer.applySketchShadow(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.08), alpha: 1, x: 0, y: 0, blur: 18, spread: 0)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func ckickedMackPayment(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PolicyModifiedVC") as! PolicyModifiedVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func clickedBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension MakePayment1VC: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0
        {
            return 2
        }
        else
        {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblView.dequeueReusableCell(withIdentifier: "MakePaymentCell") as! MakePaymentCell
        
        cell.imgCard.image  = UIImage(named: arrImg[indexPath.row])
        cell.lblNumbar.text = arrName[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed("PaymentHeaderView", owner: self, options: [:])?.first as! PaymentHeaderView
        
        if section == 0
        {
            headerView.lblName.text = "Choose payment option"
            headerView.btnAddCard.isHidden = false
        }
        else
        {
            headerView.lblName.text = "Others"
            headerView.btnAddCard.isHidden = true
        }
        
        headerView.btnAddCard.tag = section
        headerView.btnAddCard.addTarget(self, action: #selector(clickedAddNewCard(_:)), for: .touchUpInside)

        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.5
    }
    
    @objc func clickedAddNewCard(_ sender: UIButton)
    {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddNewCardVC") as! AddNewCardVC
        let home = UINavigationController(rootViewController: vc)
        home.navigationController?.navigationBar.isHidden = true
        home.modalPresentationStyle = .overFullScreen
        self.present(home, animated: false)
    }
    
    
}


