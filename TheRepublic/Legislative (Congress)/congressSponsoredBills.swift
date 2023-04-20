//
//  congressSponsoredBills.swift
//  Tree of the USA
//
//  Created by x on 09/01/18.
//  Copyright © 2018 x. All rights reserved.
//

import UIKit
import Alamofire
import PMAlertController
import DeviceKit

class congressSponsoredBills: UITableViewController {
    //Congress sponsored bills tableview
    
    @IBOutlet var congressSponsoredBillsTV: UITableView!
    
    var downloadFinish = false
    var tool = tools()
    
    var id = ""
    
    //Organized Bills
    var congressSigned = [String]()
    var congressNumbers = [String]()
    var congressDescription = [String]()
    var congressBillJson = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setups custom back button
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let yourBackImage = UIImage(named: "backButton")
        self.navigationController?.navigationBar.backIndicatorImage = yourBackImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
        
        print("Votes for: \(id)")
        
        getVotedBills()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getVotedBills(){
        //Gets voted bills of congressman from propublica
        print("getVotedBills")
        
        //requestString variable must be of type [String]
        let requestString : String =  "https://api.propublica.org/congress/v1/members/\(id)/bills/introduced.json"
        
        //headers variable must be of type [String: String]
        let headers : HTTPHeaders = [
            "X-API-Key": "GET API KEY FROM PROPUBLICA",
            "Content-Type": "application/json"
        ]
        
        //Alamofire 4 uses a different .request syntax that Alamofire 3, so make sure you have the correct version and format.
        Alamofire.request(requestString, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { (DataResponse) in
            //print("DataResponse: \(String(describing: DataResponse))")
            //print("DataResponse.result: \(String(describing: DataResponse.result))")
            //print("DataResponse.result.value: \(String(describing: DataResponse.result.value))")
            
            let json = DataResponse.result.value
            let value = json as? [String: Any]
            print("🛠value: \(value)")
            
            let message = String(describing: value?["message"])
            
            if(message.contains("Endpoint request timed out") || value == nil){
                print("Service not working")
                let badgeImageName = "TRPsad.png"
                let alertVC = PMAlertController(title: "Oh No!", description: "Service is not working. Please try again later.", image: UIImage(named: badgeImageName), style: .alert)
                
                alertVC.addAction(PMAlertAction(title: "OK", style: .default, action: { () in
                    print("Capture action OK")
                    self.navigationController?.popViewController(animated: true)
                }))
                
                self.present(alertVC, animated: true, completion: nil)
            }

            else{
            let results = value?["results"] as! [Any]
            //print("🛠results: \(String(describing: results))")
            let billsZero = results[0] as! [String:Any]
            //print("🛠billsZero: \(String(describing: billsZero))")
            let sponsoredBills = billsZero["bills"] as! [Any]
            
            //Organized house bills
            for i in 0...sponsoredBills.count-1{
                let bill = sponsoredBills[i] as! [String: Any]
                print("📌bill: \(bill)")

                self.congressNumbers.append(bill["number"] as! String)
                self.congressBillJson.append(bill["bill_uri"] as! String)
                self.congressSigned.append(bill["introduced_date"] as! String)
                let title = bill["title"] as! String
                self.congressDescription.append(title.replacingOccurrences(of: "&#39;", with: "'"))

            }
            
            print("congressNumbers: \(self.congressNumbers)")
            
            self.downloadFinish = true
            
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
            self.congressSponsoredBillsTV.reloadData()
            }
        }
        
    }
    
    func stringToDate(_ str: String)->Date{
        //print("🔧str: -\(str)-")
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: str)!
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if(downloadFinish == true){
            return congressNumbers.count
        }
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Shows bill of choosen cell
        let selectedCV = indexPath.item
        print("selectedCV: \(selectedCV)")
        print("🛠congressBillJson[selectedCV]: \(congressBillJson[selectedCV])")
        
        if(congressBillJson[selectedCV] != ""){
            //requestString variable must be of type [String]
            let requestString : String =  congressBillJson[selectedCV]
            
            //headers variable must be of type [String: String]
            let headers : HTTPHeaders = [
                "X-API-Key": "GET API KEY FROM PROPUBLICA",
                "Content-Type": "application/json"
            ]
            
            //Alamofire 4 uses a different .request syntax that Alamofire 3, so make sure you have the correct version and format.
            Alamofire.request(requestString, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { (DataResponse) in
                //print("DataResponse: \(String(describing: DataResponse))")
                //print("DataResponse.result: \(String(describing: DataResponse.result))")
                //print("DataResponse.result.value: \(String(describing: DataResponse.result.value))")
                
                let json = DataResponse.result.value
                let value = json as? [String: Any]
                //print("🛠value: \(value)")
                
                let message = String(describing: value?["message"])
                
                if(message.contains("Endpoint request timed out") || value == nil){
                    print("Service not working")
                    let badgeImageName = "TRPsad.png"
                    let alertVC = PMAlertController(title: "Oh No!", description: "Service is not working. Please try again later.", image: UIImage(named: badgeImageName), style: .alert)
                    
                    alertVC.addAction(PMAlertAction(title: "OK", style: .default, action: { () in
                        print("Capture action OK")
                        self.navigationController?.popViewController(animated: true)
                    }))
                    
                    self.present(alertVC, animated: true, completion: nil)
                }

                else{
                let results = value?["results"] as! [Any]
                //print("🛠results: \(String(describing: results))")
                let billsZero = results[0] as! [String:Any]
                print("🛠billsZero: \(String(describing: billsZero))")
                print("congressdotgov_url: \(String(describing: billsZero["congressdotgov_url"]))")
                
                let billUrl = billsZero["congressdotgov_url"]
                
                let urlVC = UIStoryboard(name: self.tool.sbName(), bundle: nil).instantiateViewController(withIdentifier: "urlWebview") as! urlWeb
                urlVC.urlPass = billUrl! as! String
                
                self.navigationController?.pushViewController(urlVC, animated: true)
                }
            }
        }
            
        else if(congressBillJson[selectedCV] == ""){
            let error = UIAlertController(title: "Error", message: "No data for selection.", preferredStyle: UIAlertControllerStyle.alert)
            error.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(UIAlertAction) -> Void in
                print("No data")
            }))
            
            self.present(error, animated: true, completion: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sponsoredBillCell", for: indexPath) as! congressBillCell
        
        if(downloadFinish == false){
            cell.billNumber.text = "Loading"
            cell.votedDate.text = "Loading"
            cell.billTitle.text = "Loading"
        }
        else if(downloadFinish == true){
            cell.billNumber.text = congressNumbers[indexPath.row]
            cell.votedDate.text = congressSigned[indexPath.row]
            cell.billTitle.text = congressDescription[indexPath.row]
        }
        
        return cell
    }

}
