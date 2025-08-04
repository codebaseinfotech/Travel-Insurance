//
//  MyProfileViewController.swift
//  Travel Insurance
//
//  Created by Ankit Gabani on 02/11/23.
//

import UIKit
import ADCountryPicker
import MobileCoreServices
import libPhoneNumber_iOS
import UIKit
import AVFoundation

struct Country: Codable {
    let country: String
    let countryCode: String
    let dialCode: String
}

class MyProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imgProfile: UIImageView!
    
    @IBOutlet weak var txtFName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtMobile: UITextField!
    @IBOutlet weak var txtDOB: UITextField!
    
    @IBOutlet weak var txtCounty: UITextField!
    @IBOutlet weak var lblFlag: UILabel!
    @IBOutlet weak var btnEdit: UIButton!
    
    var imagePickerNew = UIImagePickerController()
    
    var selectedImg: String?
    var imagePicker: ImagePicker!
    let picker = ADCountryPicker()
    
    let datePikerSDate = UIDatePicker()
    
    var strDOB = ""
    
    var isImgUpload = false
    
    let countriesData = [
        [
            "country": "Afghanistan",
            "countryCode": "AF",
            "dialCode": "+93"
        ],
        [
            "country": "Albania",
            "countryCode": "AL",
            "dialCode": "+355"
        ],
        [
            "country": "Algeria",
            "countryCode": "DZ",
            "dialCode": "+213"
        ],
        [
            "country": "Andorra",
            "countryCode": "AD",
            "dialCode": "+376"
        ],
        [
            "country": "Angola",
            "countryCode": "AO",
            "dialCode": "+244"
        ],
        [
            "country": "Argentina",
            "countryCode": "AR",
            "dialCode": "+54"
        ],
        [
            "country": "Armenia",
            "countryCode": "AM",
            "dialCode": "+374"
        ],
        [
            "country": "Australia",
            "countryCode": "AU",
            "dialCode": "+61"
        ],
        [
            "country": "Austria",
            "countryCode": "AT",
            "dialCode": "+43"
        ],
        [
            "country": "Azerbaijan",
            "countryCode": "AZ",
            "dialCode": "+994"
        ],
        [
            "country": "Bahamas",
            "countryCode": "BS",
            "dialCode": "+1-242"
        ],
        [
            "country": "Bahrain",
            "countryCode": "BH",
            "dialCode": "+973"
        ],
        [
            "country": "Bangladesh",
            "countryCode": "BD",
            "dialCode": "+880"
        ],
        [
            "country": "Barbados",
            "countryCode": "BB",
            "dialCode": "+1-246"
        ],
        [
            "country": "Belarus",
            "countryCode": "BY",
            "dialCode": "+375"
        ],
        [
            "country": "Belgium",
            "countryCode": "BE",
            "dialCode": "+32"
        ],
        [
            "country": "Belize",
            "countryCode": "BZ",
            "dialCode": "+501"
        ],
        [
            "country": "Benin",
            "countryCode": "BJ",
            "dialCode": "+229"
        ],
        [
            "country": "Bhutan",
            "countryCode": "BT",
            "dialCode": "+975"
        ],
        [
            "country": "Bolivia",
            "countryCode": "BO",
            "dialCode": "+591"
        ],
        [
            "country": "Bosnia and Herzegovina",
            "countryCode": "BA",
            "dialCode": "+387"
        ],
        [
            "country": "Botswana",
            "countryCode": "BW",
            "dialCode": "+267"
        ],
        [
            "country": "Brazil",
            "countryCode": "BR",
            "dialCode": "+55"
        ],
        [
            "country": "Brunei",
            "countryCode": "BN",
            "dialCode": "+673"
        ],
        [
            "country": "Bulgaria",
            "countryCode": "BG",
            "dialCode": "+359"
        ],
        [
            "country": "Burkina Faso",
            "countryCode": "BF",
            "dialCode": "+226"
        ],
        [
            "country": "Burundi",
            "countryCode": "BI",
            "dialCode": "+257"
        ],
        [
            "country": "Cabo Verde",
            "countryCode": "CV",
            "dialCode": "+238"
        ],
        [
            "country": "Cambodia",
            "countryCode": "KH",
            "dialCode": "+855"
        ],
        [
            "country": "Cameroon",
            "countryCode": "CM",
            "dialCode": "+237"
        ],
        [
            "country": "Canada",
            "countryCode": "CA",
            "dialCode": "+1"
        ],
        [
            "country": "Central African Republic",
            "countryCode": "CF",
            "dialCode": "+236"
        ],
        [
            "country": "Chad",
            "countryCode": "TD",
            "dialCode": "+235"
        ],
        [
            "country": "Chile",
            "countryCode": "CL",
            "dialCode": "+56"
        ],
        [
            "country": "China",
            "countryCode": "CN",
            "dialCode": "+86"
        ],
        [
            "country": "Colombia",
            "countryCode": "CO",
            "dialCode": "+57"
        ],
        [
            "country": "Comoros",
            "countryCode": "KM",
            "dialCode": "+269"
        ],
        [
            "country": "Congo (Congo-Brazzaville)",
            "countryCode": "CG",
            "dialCode": "+242"
        ],
        [
            "country": "Congo (Democratic Republic of the)",
            "countryCode": "CD",
            "dialCode": "+243"
        ],
        [
            "country": "Costa Rica",
            "countryCode": "CR",
            "dialCode": "+506"
        ],
        [
            "country": "Croatia",
            "countryCode": "HR",
            "dialCode": "+385"
        ],
        [
            "country": "Cuba",
            "countryCode": "CU",
            "dialCode": "+53"
        ],
        [
            "country": "Cyprus",
            "countryCode": "CY",
            "dialCode": "+357"
        ],
        [
            "country": "Czechia",
            "countryCode": "CZ",
            "dialCode": "+420"
        ],
        [
            "country": "Denmark",
            "countryCode": "DK",
            "dialCode": "+45"
        ],
        [
            "country": "Djibouti",
            "countryCode": "DJ",
            "dialCode": "+253"
        ],
        [
            "country": "Dominica",
            "countryCode": "DM",
            "dialCode": "+1-767"
        ],
        [
            "country": "Dominican Republic",
            "countryCode": "DO",
            "dialCode": "+1-809"
        ],
        [
            "country": "Ecuador",
            "countryCode": "EC",
            "dialCode": "+593"
        ],
        [
            "country": "Egypt",
            "countryCode": "EG",
            "dialCode": "+20"
        ],
        [
            "country": "El Salvador",
            "countryCode": "SV",
            "dialCode": "+503"
        ],
        [
            "country": "Equatorial Guinea",
            "countryCode": "GQ",
            "dialCode": "+240"
        ],
        [
            "country": "Eritrea",
            "countryCode": "ER",
            "dialCode": "+291"
        ],
        [
            "country": "Estonia",
            "countryCode": "EE",
            "dialCode": "+372"
        ],
        [
            "country": "Eswatini",
            "countryCode": "SZ",
            "dialCode": "+268"
        ],
        [
            "country": "Ethiopia",
            "countryCode": "ET",
            "dialCode": "+251"
        ],
        [
            "country": "Fiji",
            "countryCode": "FJ",
            "dialCode": "+679"
        ],
        [
            "country": "Finland",
            "countryCode": "FI",
            "dialCode": "+358"
        ],
        [
            "country": "France",
            "countryCode": "FR",
            "dialCode": "+33"
        ],
        [
            "country": "Gabon",
            "countryCode": "GA",
            "dialCode": "+241"
        ],
        [
            "country": "Gambia",
            "countryCode": "GM",
            "dialCode": "+220"
        ],
        [
            "country": "Georgia",
            "countryCode": "GE",
            "dialCode": "+995"
        ],
        [
            "country": "Germany",
            "countryCode": "DE",
            "dialCode": "+49"
        ],
        [
            "country": "Ghana",
            "countryCode": "GH",
            "dialCode": "+233"
        ],
        [
            "country": "Greece",
            "countryCode": "GR",
            "dialCode": "+30"
        ],
        [
            "country": "Grenada",
            "countryCode": "GD",
            "dialCode": "+1-473"
        ],
        [
            "country": "Guatemala",
            "countryCode": "GT",
            "dialCode": "+502"
        ],
        [
            "country": "Guinea",
            "countryCode": "GN",
            "dialCode": "+224"
        ],
        [
            "country": "Guinea-Bissau",
            "countryCode": "GW",
            "dialCode": "+245"
        ],
        [
            "country": "Guyana",
            "countryCode": "GY",
            "dialCode": "+592"
        ],
        [
            "country": "Haiti",
            "countryCode": "HT",
            "dialCode": "+509"
        ],
        [
            "country": "Honduras",
            "countryCode": "HN",
            "dialCode": "+504"
        ],
        [
            "country": "Hungary",
            "countryCode": "HU",
            "dialCode": "+36"
        ],
        [
            "country": "Iceland",
            "countryCode": "IS",
            "dialCode": "+354"
        ],
        [
            "country": "India",
            "countryCode": "IN",
            "dialCode": "+91"
        ],
        [
            "country": "Indonesia",
            "countryCode": "ID",
            "dialCode": "+62"
        ],
        [
            "country": "Iran",
            "countryCode": "IR",
            "dialCode": "+98"
        ],
        [
            "country": "Iraq",
            "countryCode": "IQ",
            "dialCode": "+964"
        ],
        [
            "country": "Ireland",
            "countryCode": "IE",
            "dialCode": "+353"
        ],
        [
            "country": "Israel",
            "countryCode": "IL",
            "dialCode": "+972"
        ],
        [
            "country": "Italy",
            "countryCode": "IT",
            "dialCode": "+39"
        ],
        [
            "country": "Jamaica",
            "countryCode": "JM",
            "dialCode": "+1-876"
        ],
        [
            "country": "Japan",
            "countryCode": "JP",
            "dialCode": "+81"
        ],
        [
            "country": "Jordan",
            "countryCode": "JO",
            "dialCode": "+962"
        ],
        [
            "country": "Kazakhstan",
            "countryCode": "KZ",
            "dialCode": "+7"
        ],
        [
            "country": "Kenya",
            "countryCode": "KE",
            "dialCode": "+254"
        ],
        [
            "country": "Kiribati",
            "countryCode": "KI",
            "dialCode": "+686"
        ],
        [
            "country": "Kuwait",
            "countryCode": "KW",
            "dialCode": "+965"
        ],
        [
            "country": "Kyrgyzstan",
            "countryCode": "KG",
            "dialCode": "+996"
        ],
        [
            "country": "Laos",
            "countryCode": "LA",
            "dialCode": "+856"
        ],
        [
            "country": "Latvia",
            "countryCode": "LV",
            "dialCode": "+371"
        ],
        [
            "country": "Lebanon",
            "countryCode": "LB",
            "dialCode": "+961"
        ],
        [
            "country": "Lesotho",
            "countryCode": "LS",
            "dialCode": "+266"
        ],
        [
            "country": "Liberia",
            "countryCode": "LR",
            "dialCode": "+231"
        ],
        [
            "country": "Libya",
            "countryCode": "LY",
            "dialCode": "+218"
        ],
        [
            "country": "Liechtenstein",
            "countryCode": "LI",
            "dialCode": "+423"
        ],
        [
            "country": "Lithuania",
            "countryCode": "LT",
            "dialCode": "+370"
        ],
        [
            "country": "Luxembourg",
            "countryCode": "LU",
            "dialCode": "+352"
        ],
        [
            "country": "Madagascar",
            "countryCode": "MG",
            "dialCode": "+261"
        ],
        [
            "country": "Malawi",
            "countryCode": "MW",
            "dialCode": "+265"
        ],
        [
            "country": "Malaysia",
            "countryCode": "MY",
            "dialCode": "+60"
        ],
        [
            "country": "Maldives",
            "countryCode": "MV",
            "dialCode": "+960"
        ],
        [
            "country": "Mali",
            "countryCode": "ML",
            "dialCode": "+223"
        ],
        [
            "country": "Malta",
            "countryCode": "MT",
            "dialCode": "+356"
        ],
        [
            "country": "Marshall Islands",
            "countryCode": "MH",
            "dialCode": "+692"
        ],
        [
            "country": "Mauritania",
            "countryCode": "MR",
            "dialCode": "+222"
        ],
        [
            "country": "Mauritius",
            "countryCode": "MU",
            "dialCode": "+230"
        ],
        [
            "country": "Mexico",
            "countryCode": "MX",
            "dialCode": "+52"
        ],
        [
            "country": "Micronesia",
            "countryCode": "FM",
            "dialCode": "+691"
        ],
        [
            "country": "Moldova",
            "countryCode": "MD",
            "dialCode": "+373"
        ],
        [
            "country": "Monaco",
            "countryCode": "MC",
            "dialCode": "+377"
        ],
        [
            "country": "Mongolia",
            "countryCode": "MN",
            "dialCode": "+976"
        ],
        [
            "country": "Montenegro",
            "countryCode": "ME",
            "dialCode": "+382"
        ],
        [
            "country": "Morocco",
            "countryCode": "MA",
            "dialCode": "+212"
        ],
        [
            "country": "Mozambique",
            "countryCode": "MZ",
            "dialCode": "+258"
        ],
        [
            "country": "Myanmar",
            "countryCode": "MM",
            "dialCode": "+95"
        ],
        [
            "country": "Namibia",
            "countryCode": "NA",
            "dialCode": "+264"
        ],
        [
            "country": "Nauru",
            "countryCode": "NR",
            "dialCode": "+674"
        ],
        [
            "country": "Nepal",
            "countryCode": "NP",
            "dialCode": "+977"
        ],
        [
            "country": "Netherlands",
            "countryCode": "NL",
            "dialCode": "+31"
        ],
        [
            "country": "New Zealand",
            "countryCode": "NZ",
            "dialCode": "+64"
        ],
        [
            "country": "Nicaragua",
            "countryCode": "NI",
            "dialCode": "+505"
        ],
        [
            "country": "Niger",
            "countryCode": "NE",
            "dialCode": "+227"
        ],
        [
            "country": "Nigeria",
            "countryCode": "NG",
            "dialCode": "+234"
        ],
        [
            "country": "North Macedonia",
            "countryCode": "MK",
            "dialCode": "+389"
        ],
        [
            "country": "Norway",
            "countryCode": "NO",
            "dialCode": "+47"
        ],
        [
            "country": "Oman",
            "countryCode": "OM",
            "dialCode": "+968"
        ],
        [
            "country": "Pakistan",
            "countryCode": "PK",
            "dialCode": "+92"
        ],
        [
            "country": "Palau",
            "countryCode": "PW",
            "dialCode": "+680"
        ],
        [
            "country": "Palestine",
            "countryCode": "PS",
            "dialCode": "+970"
        ],
        [
            "country": "Panama",
            "countryCode": "PA",
            "dialCode": "+507"
        ],
        [
            "country": "Papua New Guinea",
            "countryCode": "PG",
            "dialCode": "+675"
        ],
        [
            "country": "Paraguay",
            "countryCode": "PY",
            "dialCode": "+595"
        ],
        [
            "country": "Peru",
            "countryCode": "PE",
            "dialCode": "+51"
        ],
        [
            "country": "Philippines",
            "countryCode": "PH",
            "dialCode": "+63"
        ],
        [
            "country": "Poland",
            "countryCode": "PL",
            "dialCode": "+48"
        ],
        [
            "country": "Portugal",
            "countryCode": "PT",
            "dialCode": "+351"
        ],
        [
            "country": "Qatar",
            "countryCode": "QA",
            "dialCode": "+974"
        ],
        [
            "country": "Romania",
            "countryCode": "RO",
            "dialCode": "+40"
        ],
        [
            "country": "Russia",
            "countryCode": "RU",
            "dialCode": "+7"
        ],
        [
            "country": "Rwanda",
            "countryCode": "RW",
            "dialCode": "+250"
        ],
        [
            "country": "Saint Kitts and Nevis",
            "countryCode": "KN",
            "dialCode": "+1-869"
        ],
        [
            "country": "Saint Lucia",
            "countryCode": "LC",
            "dialCode": "+1-758"
        ],
        [
            "country": "Saint Vincent and the Grenadines",
            "countryCode": "VC",
            "dialCode": "+1-784"
        ],
        [
            "country": "Samoa",
            "countryCode": "WS",
            "dialCode": "+685"
        ],
        [
            "country": "San Marino",
            "countryCode": "SM",
            "dialCode": "+378"
        ],
        [
            "country": "Sao Tome and Principe",
            "countryCode": "ST",
            "dialCode": "+239"
        ],
        [
            "country": "Saudi Arabia",
            "countryCode": "SA",
            "dialCode": "+966"
        ],
        [
            "country": "Senegal",
            "countryCode": "SN",
            "dialCode": "+221"
        ],
        [
            "country": "Serbia",
            "countryCode": "RS",
            "dialCode": "+381"
        ],
        [
            "country": "Seychelles",
            "countryCode": "SC",
            "dialCode": "+248"
        ],
        [
            "country": "Sierra Leone",
            "countryCode": "SL",
            "dialCode": "+232"
        ],
        [
            "country": "Singapore",
            "countryCode": "SG",
            "dialCode": "+65"
        ],
        [
            "country": "Slovakia",
            "countryCode": "SK",
            "dialCode": "+421"
        ],
        [
            "country": "Slovenia",
            "countryCode": "SI",
            "dialCode": "+386"
        ],
        [
            "country": "Solomon Islands",
            "countryCode": "SB",
            "dialCode": "+677"
        ],
        [
            "country": "Somalia",
            "countryCode": "SO",
            "dialCode": "+252"
        ],
        [
            "country": "South Africa",
            "countryCode": "ZA",
            "dialCode": "+27"
        ],
        [
            "country": "South Korea",
            "countryCode": "KR",
            "dialCode": "+82"
        ],
        [
            "country": "South Sudan",
            "countryCode": "SS",
            "dialCode": "+211"
        ],
        [
            "country": "Spain",
            "countryCode": "ES",
            "dialCode": "+34"
        ],
        [
            "country": "Sri Lanka",
            "countryCode": "LK",
            "dialCode": "+94"
        ],
        [
            "country": "Sudan",
            "countryCode": "SD",
            "dialCode": "+249"
        ],
        [
            "country": "Suriname",
            "countryCode": "SR",
            "dialCode": "+597"
        ],
        [
            "country": "Sweden",
            "countryCode": "SE",
            "dialCode": "+46"
        ],
        [
            "country": "Switzerland",
            "countryCode": "CH",
            "dialCode": "+41"
        ],
        [
            "country": "Syria",
            "countryCode": "SY",
            "dialCode": "+963"
        ],
        [
            "country": "Taiwan",
            "countryCode": "TW",
            "dialCode": "+886"
        ],
        [
            "country": "Tajikistan",
            "countryCode": "TJ",
            "dialCode": "+992"
        ],
        [
            "country": "Tanzania",
            "countryCode": "TZ",
            "dialCode": "+255"
        ],
        [
            "country": "Thailand",
            "countryCode": "TH",
            "dialCode": "+66"
        ],
        [
            "country": "Togo",
            "countryCode": "TG",
            "dialCode": "+228"
        ],
        [
            "country": "Tonga",
            "countryCode": "TO",
            "dialCode": "+676"
        ],
        [
            "country": "Trinidad and Tobago",
            "countryCode": "TT",
            "dialCode": "+1-868"
        ],
        [
            "country": "Tunisia",
            "countryCode": "TN",
            "dialCode": "+216"
        ],
        [
            "country": "Turkey",
            "countryCode": "TR",
            "dialCode": "+90"
        ],
        [
            "country": "Turkmenistan",
            "countryCode": "TM",
            "dialCode": "+993"
        ],
        [
            "country": "Tuvalu",
            "countryCode": "TV",
            "dialCode": "+688"
        ],
        [
            "country": "Uganda",
            "countryCode": "UG",
            "dialCode": "+256"
        ],
        [
            "country": "Ukraine",
            "countryCode": "UA",
            "dialCode": "+380"
        ],
        [
            "country": "United Arab Emirates",
            "countryCode": "AE",
            "dialCode": "+971"
        ],
        [
            "country": "United Kingdom",
            "countryCode": "GB",
            "dialCode": "+44"
        ],
        [
            "country": "United States",
            "countryCode": "US",
            "dialCode": "+1"
        ],
        [
            "country": "Uruguay",
            "countryCode": "UY",
            "dialCode": "+598"
        ],
        [
            "country": "Uzbekistan",
            "countryCode": "UZ",
            "dialCode": "+998"
        ],
        [
            "country": "Vanuatu",
            "countryCode": "VU",
            "dialCode": "+678"
        ],
        [
            "country": "Vatican City",
            "countryCode": "VA",
            "dialCode": "+39"
        ],
        [
            "country": "Venezuela",
            "countryCode": "VE",
            "dialCode": "+58"
        ],
        [
            "country": "Vietnam",
            "countryCode": "VN",
            "dialCode": "+84"
        ],
        [
            "country": "Yemen",
            "countryCode": "YE",
            "dialCode": "+967"
        ],
        [
            "country": "Zambia",
            "countryCode": "ZM",
            "dialCode": "+260"
        ],
        [
            "country": "Zimbabwe",
            "countryCode": "ZW",
            "dialCode": "+263"
        ]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for obj in countriesData {
            
            let countryCode = obj["countryCode"] ?? ""
            let dialCode = obj["dialCode"] ?? ""
            
            if appDelegate?.dicCurrentUserData.countryCode == dialCode {
                // Create an array of country flags
                let countryFlags = self.flag(from: countryCode)
                // Print all country flags
                
                self.lblFlag.text = countryFlags
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
 
        self.txtFName.text = appDelegate?.dicCurrentUserData.name ?? ""
        self.txtEmail.text = appDelegate?.dicCurrentUserData.email ?? ""
        self.txtDOB.text = appDelegate?.dicCurrentUserData.dateOfBirth ?? ""
        
        self.txtCounty.text = appDelegate?.dicCurrentUserData.countryCode ?? ""
        
        self.btnEdit.setTitle(appDelegate?.dicCurrentUserData.name ?? "", for: .normal)
        
        if let arrSpit = appDelegate?.dicCurrentUserData.mobileNumber.components(separatedBy: " ")
        {
            if arrSpit.count > 0
            {
                if arrSpit.count == 1
                {
                    self.txtMobile.text = arrSpit[0] as? String
                }
                else if arrSpit.count == 2
                {
                    self.txtCounty.text = arrSpit[0] as? String
                    
                    self.txtMobile.text = arrSpit[1] as? String
                }
            }
            
        }
      
        var media_link_url = appDelegate?.dicCurrentUserData.imagePath ?? ""
        media_link_url = (media_link_url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!
        imgProfile.sd_setImage(with: URL.init(string: media_link_url), placeholderImage: UIImage(named: "app_logo"), options: [], completed: nil)
    }
    
    func flag(from countryCode: String) -> String {
        let base: UInt32 = 127397
        var scalarView = String.UnicodeScalarView()
        for i in countryCode.utf16 {
            if let scalar = UnicodeScalar(base + UInt32(i)) {
                scalarView.append(scalar)
            }
        }
        return String(scalarView)
    }

    
    func countryCodeDemo(forCountry country: String) -> String? {
        let locale = Locale(identifier: "en_US")
        let countries = Locale.isoRegionCodes.compactMap { locale.localizedString(forRegionCode: $0) }
        let countryDict = Dictionary(uniqueKeysWithValues: zip(countries.map { $0.uppercased() }, Locale.isoRegionCodes))
        let countryCode = countryDict[country.uppercased()]
        return countryCode
    }
     
    @IBAction func clickedEdit(_ sender: Any) {
        let mainS = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainS.instantiateViewController(withIdentifier: "EditProfileViewController") as! EditProfileViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func clickedBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func clickedCamrea(_ sender: Any) {
        let alert1 = UIAlertController(title: nil , message: nil, preferredStyle: .actionSheet)
        
        alert1.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert1.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        
        alert1.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert1, animated: true, completion: nil)
    }
    
    @IBAction func clickedSaveChange(_ sender: Any) {
        self.setUpHideMakeToast()
        if txtFName.text == ""
        {
            self.setUpMakeToast(msg: "Please enter name")
        }
        else if txtEmail.text == ""
        {
            self.setUpMakeToast(msg: "Please enter email")
        }
        else if txtMobile.text == ""
        {
            self.setUpMakeToast(msg: "Please enter mobile Nnumber")
        }
        else if (txtMobile.text?.count ?? 0) < 8
        {
            self.setUpMakeToast(msg: "Please Enter minimum 8 digit mobile number")
        }
        else
        {
            if self.isImgUpload == true
            {
                self.myImageUploadRequest(imageToUpload: imgProfile.image!, imgKey: "image_path")
            }
            else
            {
                self.callProfileAPI()
            }
           
        }
    }
    @IBAction func clickedCountry(_ sender: Any) {
        let picker = ADCountryPicker()
        // delegate
        picker.delegate = self
        
        // Display calling codes
        picker.showCallingCodes = true
        
        // or closure
        picker.didSelectCountryClosure = { name, code in
            _ = picker.navigationController?.popToRootViewController(animated: true)
            print(code)
        }
        
        // Use this below code to present the picker
        
        let pickerNavigationController = UINavigationController(rootViewController: picker)
        self.present(pickerNavigationController, animated: true, completion: nil)
    }
    
    func openCamera()
    {
        
        checkCameraPermission()
        
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            imagePickerNew.delegate = self
            imagePickerNew.sourceType = UIImagePickerController.SourceType.camera
            imagePickerNew.allowsEditing = true
            imagePickerNew.mediaTypes = [kUTTypeImage as String]
            self.present(imagePickerNew, animated: true, completion: nil)
        }
        else
        {
            let windows = UIApplication.shared.windows
            windows.last?.makeToast("You don't have camera")
        }
    }
    
    func checkCameraPermission() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            // Permission is granted, proceed to use the camera
            print("Camera access granted.")
            // You can add your camera usage code here
            
        case .notDetermined:
            // Permission has not been requested yet, request it
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    DispatchQueue.main.async {
                        // Permission granted
                        print("Camera access granted.")
                        // Proceed with camera usage
                    }
                } else {
                    DispatchQueue.main.async {
                        // Permission denied
                        self.showPermissionDeniedAlert()
                    }
                }
            }
            
        case .denied, .restricted:
            // Permission denied or restricted
            print("Camera access denied.")
            showPermissionDeniedAlert()
            
        @unknown default:
            fatalError("Unexpected authorization status.")
        }
    }
    
    func showPermissionDeniedAlert() {
        let alert = UIAlertController(title: "Camera Access Denied",
                                      message: "Please enable camera access in Settings.",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url)
            }
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func openGallary()
    {
        imagePickerNew.delegate = self
        imagePickerNew.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePickerNew.allowsEditing = true
        imagePickerNew.mediaTypes = ["public.image"]
        self.present(imagePickerNew, animated: true, completion: nil)
    }
    
    // Mark :- Edit Api
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        {
            let imageurl = info[UIImagePickerController.InfoKey.mediaURL] as? URL
            selectedImg = imageurl?.lastPathComponent
            self.isImgUpload = true
            DispatchQueue.main.async {
                self.imgProfile.image = image
            }
        }
        else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            let imageurl = info[UIImagePickerController.InfoKey.mediaURL] as? URL
            selectedImg = imageurl?.lastPathComponent
            self.isImgUpload = true
            DispatchQueue.main.async {
                self.imgProfile.image = image
            }
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func myImageUploadRequest(imageToUpload: UIImage, imgKey: String) {
        
        APIClient.sharedInstance.showIndicator()
 
        let token = UserDefaults.standard.value(forKey: "token") as? String
        
        let myUrl = NSURL(string: BASE_URL + PROFILE_UPDATE);
        let request = NSMutableURLRequest(url:myUrl! as URL);
        request.httpMethod = "POST";
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("Bearer \(token ?? "")", forHTTPHeaderField: "Authorization")
        
        let name = self.txtFName.text ?? ""

        let email = self.txtEmail.text ?? ""
        
        let mobile_number = "\(self.txtMobile.text ?? "")"
        
        let country_code = txtCounty.text ?? ""
                
        var params = ["name":name,"mobile_number":mobile_number,"email":email,"date_of_birth":self.strDOB, "country_code": country_code]
      
        print(params)
        
        let boundary = generateBoundaryString()
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        
        let imageData = imageToUpload.jpegData(compressionQuality: 0.3)
        if imageData == nil  {
            return
        }
        
        request.httpBody = createBodyWithParameters(parameters: params, filePathKey: imgKey, imageDataKey: imageData! as NSData, boundary: boundary, imgKey: imgKey) as Data
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            APIClient.sharedInstance.hideIndicator()
            
            if error != nil {
                print("error=\(error!)")
                return
            }
            
            // print reponse body
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("response data = \(responseString!)")
            
            do{
                
                if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                    
                    // try to read out a string array
                    if var status = json["status"] as? Int
                    {
                        if status == 201
                        {
                            let message = json["message"] as? String
                            
                            DispatchQueue.main.async {
                                
                                self.setUpMakeToast(msg: message ?? "")
                                
                                if let dicResponse = json["response"] as? NSDictionary
                                {
                                    let dicData = TIUserLoginResponse(fromDictionary: dicResponse)
                                    
                                    appDelegate?.saveCurrentUserData(dic: dicData)
                                    appDelegate?.dicCurrentUserData = dicData
                                }
                                
                                self.clickedBack(self)
                                
                            }
                        }
                        else
                        {
                            let message = json["message"] as? String
                            
                            DispatchQueue.main.async {
                                self.view.makeToast(message)
                                let window = UIApplication.shared.windows
                                window.last?.makeToast(message)
                            }
                            
                        }
                    }
                }
                
            }catch{
                
            }
            
        }
        
        task.resume()
    }
    
    func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String, imgKey: String) -> NSData {
        
        let body = NSMutableData();
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString(string: "--\(boundary)\r\n")
                body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString(string: "\(value)\r\n")
            }
        }
        
        let filenameImageBOL = "image.jpg"
        let mimetypeImageBOL = "image/jpg"
        
        let imageData =  imgProfile.image?.jpegData(compressionQuality: 0.3)
        
        body.appendString(string: "--\(boundary)\r\n")
        body.appendString(string: "Content-Disposition: form-data; name=\"image_path\"; filename=\"\(filenameImageBOL)\"\r\n")
        body.appendString(string: "Content-Type: \(mimetypeImageBOL)\r\n\r\n")
        body.append(imageData! as Data)
        body.appendString(string: "\r\n")
        body.appendString(string: "--\(boundary)--\r\n")
         
        return body
    }
    
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    func randomString(of length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var s = ""
        for _ in 0 ..< length {
            s.append(letters.randomElement()!)
        }
        return s
    }
    
    //MARK: - API Calling
    
    func callProfileAPI()
    {
        APIClient.sharedInstance.showIndicator()
        
        let param = ["name":self.txtFName.text ?? "","mobile_number": "\(self.txtMobile.text ?? "")", "date_of_birth": self.txtDOB.text ?? "","country_code": txtCounty.text ?? ""]
        
        print(param)
        
        APIClient.sharedInstance.MakeAPICallWithAuthHeaderPost(PROFILE_UPDATE, parameters: param) { response, error, statusCode in
            
            print("STATUS CODE \(String(describing: statusCode))")
            print("RESPONSE \(String(describing: response))")
            
            if error == nil
            {
                APIClient.sharedInstance.hideIndicator()
                
                let status = response?.value(forKey: "status") as? Int
                let message = response?.value(forKey: "message") as? String
                
                if statusCode == 200
                {
                    if status == 201
                    {
                        self.setUpMakeToast(msg: message ?? "")
                        
                        if let dicResponse = response?.value(forKey: "response") as? NSDictionary
                        {
                            let dicData = TIUserLoginResponse(fromDictionary: dicResponse)
                            
                            appDelegate?.saveCurrentUserData(dic: dicData)
                            appDelegate?.dicCurrentUserData = dicData
                        }
                        
                        self.clickedBack(self)
                    }
                    else
                    {
                        APIClient.sharedInstance.hideIndicator()
                        
                        self.setUpMakeToast(msg: message ?? "")
                        
                    }
                }
                else
                {
                    APIClient.sharedInstance.hideIndicator()
                    
                    self.setUpMakeToast(msg: message ?? "")
                }
            }
            else
            {
                APIClient.sharedInstance.hideIndicator()
            }
        }
    }
    
}

extension MyProfileViewController: ADCountryPickerDelegate {
    
    func countryPicker(_ picker: ADCountryPicker, didSelectCountryWithName name: String, code: String, dialCode: String)
    {
        _ = picker.navigationController?.popToRootViewController(animated: true)
        
        self.txtCounty.text = dialCode
        
        let flagImage =  picker.getFlag(countryCode: code)
        self.lblFlag.text = countryFlag(code)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func countryFlag(_ countryCode: String) -> String {
        let flagBase = UnicodeScalar("🇦").value - UnicodeScalar("A").value
        
        let flag = countryCode
            .uppercased()
            .unicodeScalars
            .compactMap({ UnicodeScalar(flagBase + $0.value)?.description })
            .joined()
        return flag
    }
    
}
