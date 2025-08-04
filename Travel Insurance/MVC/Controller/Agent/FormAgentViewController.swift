//
//  FormAgentViewController.swift
//  Travel Insurance
//
//  Created by Ankit Gabani on 03/11/23.
//

import UIKit

class FormAgentViewController: UIViewController {

    @IBOutlet weak var txtAgentCode: UITextField!
    @IBOutlet weak var txtEnterName: UITextField!
    @IBOutlet weak var txtEnterEmail: UITextField!
    @IBOutlet weak var txtEnterPassportId: UITextField!
    @IBOutlet weak var imgPassportImage: UIImageView!
    @IBOutlet weak var txtStatus: UITextField!
    @IBOutlet weak var lblNoOfDays: UILabel!
    @IBOutlet weak var lblNationality: UILabel!
    @IBOutlet weak var lblGender: UILabel!
    
    @IBOutlet weak var txtDOB: UITextField!
    @IBOutlet weak var txtPolicy: UITextField!
    
    @IBOutlet weak var viewB: UIView!
    
    let datePickerDOB = UIDatePicker()
    let datePickerPolicy = UIDatePicker()
    
    var strOpenDate = ""

    override func viewDidLoad() {
        super.viewDidLoad()
     
        viewB.layer.applySketchShadow(color: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.06), alpha: 1, x: 0, y: 0, blur: 16, spread: 0)
        
        // Do any additional setup after loading the view.
    }
   
    @IBAction func clickedBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
 
    @IBAction func clickedNotification(_ sender: Any) {
    }
    @IBAction func clickedPassportImage(_ sender: Any) {
    }
    @IBAction func clickedNoOfDay(_ sender: Any) {
    }
    @IBAction func clickedNationality(_ sender: Any) {
    }
    @IBAction func clikedGender(_ sender: Any) {
    }
    @IBAction func clickedProceed(_ sender: Any) {
    }
    
    @IBAction func clickedDOB(_ sender: UITextField) {
        strOpenDate = "1"
        datePickerDOB.datePickerMode = .date
        datePickerDOB.preferredDatePickerStyle = .wheels
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "OK", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "CANCEL", style: .plain, target: self, action: #selector(cancelDatePicker));
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        sender.inputAccessoryView = toolbar
        sender.inputView = datePickerDOB
    }
    @IBAction func clickedPolicy(_ sender: UITextField) {
        strOpenDate = "2"
        datePickerPolicy.datePickerMode = .date
        datePickerPolicy.preferredDatePickerStyle = .wheels
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "OK", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "CANCEL", style: .plain, target: self, action: #selector(cancelDatePicker));
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        sender.inputAccessoryView = toolbar
        sender.inputView = datePickerPolicy
    }
    
    @objc func donedatePicker(){
        if strOpenDate == "1"
        {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy"
            txtDOB.text = formatter.string(from: datePickerDOB.date)
            self.view.endEditing(true)
        }
        else
        {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy"
            txtPolicy.text = formatter.string(from: datePickerPolicy.date)
            self.view.endEditing(true)
        }
    }
    
    @objc func cancelDatePicker() {
        self.view.endEditing(true)
    }

}

