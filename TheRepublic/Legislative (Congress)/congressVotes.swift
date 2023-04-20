//
//  congressVotes.swift
//  Tree of the USA
//
//  Created by x on 09/01/18.
//  Copyright © 2018 x. All rights reserved.
//

import UIKit
import Alamofire
import PMAlertController
import DeviceKit

class congressVotes: UITableViewController {
    //Congressman voted bills tableview
    
    @IBOutlet var congressVotesTV: UITableView!
    
    var downloadFinish = false
    
    var id = ""
    
    //Organized Bills
    var congressSigned = [String]()
    var congressRollCall = [String]()
    var congressNumbers = [String]()
    var congressDescription = [String]()
    var congressBillJson = [String]()
    var congressPosition = [String]()
    var congressResults = [String]()
    
    var tool = tools()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setup custom back button
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let yourBackImage = UIImage(named: "backButton")
        self.navigationController?.navigationBar.backIndicatorImage = yourBackImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
        
        print("Votes for: \(id)")
        
        getVotedBills()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getVotedBills(){
        //Get congressman voted bill from propublica
        print("getVotedBills")
        
        //requestString variable must be of type [String]
        let requestString : String =  "https://api.propublica.org/congress/v1/members/\(id)/votes.json"
        
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
            //print("🛠billsZero: \(String(describing: billsZero))")
            let votes = billsZero["votes"] as! [Any]
            //print("🛠votes: \(votes)")
            //print("🛠votes0: \(votes[0])")
            
            
            //Organized house bills
            for i in 0...votes.count-1{
                let bill = votes[i] as! [String: Any]
                print("📌bill: \(bill)")
                
                let result = bill["result"] as! String
                print("result: +\(result)+")
                let description = bill["description"] as! String
                print("description: \(description)")
                let question = bill["question"] as! String
                
                
                self.congressSigned.append(bill["date"] as! String)
                self.congressRollCall.append(bill["roll_call"] as! String)
                self.congressPosition.append(bill["position"] as! String)
                self.congressResults.append(result)
                
                let billDetail = bill["bill"] as! [String: Any]
                print("🛠billDetail: \(billDetail)")
                print("🛠billDetail.count: \(billDetail.count)")
                
                if(billDetail.count != 0){
                    self.congressNumbers.append(billDetail["number"] as! String)
                    let title = billDetail["title"] as? String
                    print("title : \(title)")
                    if (title != nil){
                        self.congressDescription.append(title!.replacingOccurrences(of: "&#39;", with: "'"))
                    }
                    else{
                        self.congressDescription.append("")
                    }
                    
                    print("bill_uri : \(billDetail["bill_uri"])")
                    
                    let billUri =  billDetail["bill_uri"] as? String
                    if (billUri != nil){
                        self.congressBillJson.append(billUri!)
                    }
                    else{
                        self.congressBillJson.append("")
                    }
                    
                    
                    
                }
                else if (result.contains("Cloture Motion Agreed to") || result.contains("Nomination Confirmed")){
                    self.congressNumbers.append("")
                    self.congressDescription.append(description.replacingOccurrences(of: "&#39;", with: "'"))
                    self.congressBillJson.append("")
                }
                else if (billDetail.count == 0 && description == ""){
                    self.congressNumbers.append("")
                    self.congressDescription.append(question.replacingOccurrences(of: "&#39;", with: "'"))
                    self.congressBillJson.append("")
                }
                else if(billDetail.count == 0){
                    self.congressNumbers.append("")
                    self.congressDescription.append("")
                    self.congressBillJson.append("")
                }
            }
            
            print("congressNumbers: \(self.congressNumbers)")
            
            self.downloadFinish = true
            
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
            self.congressVotesTV.reloadData()
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
        //Shows congressman bill of user choosen cell
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "billCell", for: indexPath) as! congressBillCell
        
        if(downloadFinish == false){
            cell.billNumber.text = "Loading"
            cell.votedDate.text = "Loading"
            cell.billTitle.text = "Loading"
            cell.rollCallNumber.text = "Loading"
            cell.passedFailed.text = "Loading"
        }
        else if(downloadFinish == true){
            cell.billNumber.text = congressNumbers[indexPath.row]
            cell.votedDate.text = congressSigned[indexPath.row]
            cell.billTitle.text = congressDescription[indexPath.row]
            cell.rollCallNumber.text = congressRollCall[indexPath.row]
            cell.passedFailed.text = congressResults[indexPath.row].uppercased()
            
            //Set cell card color for voted yes or no
            if (congressPosition[indexPath.row] == "Yes"){
                cell.yesNoBG.image = UIImage.init(named: "yesVote")
            }
            else if (congressPosition[indexPath.row] == "No"){
                cell.yesNoBG.image = UIImage.init(named: "noVote")
            }
        }
        
        return cell
    }

}
