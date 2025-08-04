//
//  OrderPlacedViewController.swift
//  Travel Insurance
//
//  Created by Ankit Gabani on 01/11/23.
//

import UIKit
import PDFKit

class OrderPlacedViewController: UIViewController {
    
    @IBOutlet weak var lblDes: UILabel!
    @IBOutlet weak var viewPolicy: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var isOpen = false
    
    var insuranceReports = [String]()
    
    var Invoiceurl = ""
    
    var pdfView = PDFView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//
        collectionView.delegate = self
        collectionView.dataSource = self
        
        if insuranceReports.count > 0 {
            collectionView.isHidden = false
        } else {
            collectionView.isHidden = true
        }
        
//        pdfView = PDFView(frame: self.view.bounds)
//        pdfView.autoScales = true
//        self.view.addSubview(pdfView)
        
        lblDes.text = "Payment receipt has sent to\n'\(appDelegate?.dicCurrentUserData.email ?? "")'"
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func clickedHome(_ sender: Any) {
        if isOpen == true {
            let mainS = UIStoryboard(name: "Main", bundle: nil)
            let vc = mainS.instantiateViewController(withIdentifier: "MyPoliciesViewController") as! MyPoliciesViewController
            self.navigationController?.pushViewController(vc, animated: false)
        } else {
            if appDelegate?.dicCurrentUserData.roleId == 1
            {
                appDelegate?.isBackForm = false
                
                appDelegate?.setUpHomeCustomer()
            }
            else
            {
                appDelegate?.isBackForm = false
                
                appDelegate?.setUpHomeAgent()
            }
        }
        
    }
    
    @IBAction func clickedVoice(_ sender: Any) {
        
        if let url = URL(string: Invoiceurl) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        
    }
    @IBAction func clickedPolicy(_ sender: Any) {
//
//        if let url = URL(string: insuranceReports) {
//            UIApplication.shared.open(url, options: [:], completionHandler: nil)
//        }
//        
    }
    
}

extension OrderPlacedViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if insuranceReports.count > 0 {
            return insuranceReports.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "DownloadPolicyCell", for: indexPath) as! DownloadPolicyCell
        
        cell.lblPolicy.text = "Download Policy_\(indexPath.row+1)"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let url = URL(string: insuranceReports[indexPath.row]) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    
}

class DownloadPolicyCell: UICollectionViewCell {
    
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var lblPolicy: UILabel!
}
