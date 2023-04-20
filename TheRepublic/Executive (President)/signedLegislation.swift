//
//  signedLegislations.swift
//  Tree of the USA
//
//  Created by x on 09/01/18.
//  Copyright © 2018 x. All rights reserved.
//

import UIKit
import Alamofire
import PMAlertController
import DeviceKit

class signedLegislations: UITableViewController {
    //Show signed legislations from the president
    
    @IBOutlet var congressEnactedTV: UITableView!
    
    var downloadFinish = false
    var tool = tools()
    
    //House
    var congressHouseSigned = [String]()
    var congressHouseNumber = [String]()
    var congressHouseNumbers = [String : String]()
    var congressHouseDescription = [String : String]()
    var congressHousePDF = [String : String]()
    //Senate
    var congressSenateSigned = [String]()
    var congressSenateNumber = [String]()
    var congressSenateNumbers = [String : String]()
    var congressSenateDescription = [String : String]()
    var congressSenatePDF = [String : String]()
    //Organized Bills
    var congressSigned = [String]()
    var congressNumbers = [String]()
    var congressDescription = [String]()
    var congressPDF = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setup custom back button
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let yourBackImage = UIImage(named: "backButton")
        self.navigationController?.navigationBar.backIndicatorImage = yourBackImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
        
        getSignedLegislations()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getSignedLegislations(){
        print("getSignedLegislations")
        
        //📌House - Enact bills
        
        //requestString variable must be of type [String]
        let requestStringHouse : String =  "https://api.propublica.org/congress/v1/115/house/bills/enacted.json"
        
        //headers variable must be of type [String: String]
        let headersHouse : HTTPHeaders = [
            "X-API-Key": "GET API KEY FROM PROPUBLICA",
            "Content-Type": "application/json"
        ]
        
        //Alamofire 4 uses a different .request syntax that Alamofire 3, so make sure you have the correct version and format.
        Alamofire.request(requestStringHouse, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headersHouse).responseJSON { (DataResponse) in
            print("DataResponse: \(String(describing: DataResponse))")
            print("DataResponse.result: \(String(describing: DataResponse.result))")
            print("DataResponse.result.value: \(String(describing: DataResponse.result.value))")
            
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
            //print("🛠billsZero: \(String(describing: billsZero["bills"]))")
            let bills = billsZero["bills"] as! [Any]
            //print("🛠bills: \(bills)")
            
            //Organized house bills
            for i in 0...bills.count-1{
                let bill = bills[i] as! [String: Any]
                
                let dateString = bill["enacted"] as! String
                let number = (bill["number"] as! String)
        
                self.congressHouseNumbers[dateString + number] = number
                self.congressHouseSigned.append(dateString)
                self.congressHouseNumber.append(number)
                self.congressHouseDescription[dateString + number] = (bill["title"] as! String)
                self.congressHousePDF[dateString + number] = (bill["congressdotgov_url"] as! String)
            }
            print("congressHouseNumbers: \(self.congressHouseNumbers)")
            
            if(self.congressSenateNumbers.count != 0){
                self.organizeBills()
            }
            }
        }
        
        //📌Senate - Enact bills
        
        //requestString variable must be of type [String]
        let requestStringSenate : String =  "https://api.propublica.org/congress/v1/115/senate/bills/enacted.json"
        
        //headers variable must be of type [String: String]
        let headersSenate : HTTPHeaders = [
            "X-API-Key": "GET API KEY FROM PROPUBLICA",
            "Content-Type": "application/json"
        ]
        
        //Alamofire 4 uses a different .request syntax that Alamofire 3, so make sure you have the correct version and format.
        Alamofire.request(requestStringSenate, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headersSenate).responseJSON { (DataResponse) in
            print("DataResponse: \(String(describing: DataResponse))")
            print("DataResponse.result: \(String(describing: DataResponse.result))")
            print("DataResponse.result.value: \(String(describing: DataResponse.result.value))")
            
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
            //print("🛠billsZero: \(String(describing: billsZero["bills"]))")
            let bills = billsZero["bills"] as! [Any]
            //print("🛠bills: \(bills)")
            
            //Organized house bills
            for i in 0...bills.count-1{
                let bill = bills[i] as! [String: Any]
                
                let dateString = bill["enacted"] as! String
                let number = (bill["number"] as! String)
                
                self.congressSenateNumbers[dateString + number] = number
                self.congressSenateSigned.append(dateString)
                self.congressSenateNumber.append(number)
                self.congressSenateDescription[dateString + number] = (bill["title"] as! String)
                self.congressSenatePDF[dateString + number] = (bill["congressdotgov_url"] as! String)
            }
            print("congressSenateNumbers: \(self.congressSenateNumbers)")
            
            if(self.congressHouseNumbers.count != 0){
                self.organizeBills()
            }
            }
        }
        
    }
    
    func stringToDate(_ str: String)->Date{
        //print("🔧str: -\(str)-")
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: str)!
    }
    
    func organizeBills(){
        print("organizeBills")
        
        print("congressHouseSigned: \(congressHouseSigned)")
        print("congressSenateSigned: \(congressSenateSigned)")
        
        var a = 0
        var b = 0
        
        func organizingBills(){
        //combine congressSenate and congressSenate oldest to newest then reloadData
        print("🔧")
        print("a: \(a)")
        print("b: \(b)")
        print("congressSigned.count: \(congressSigned.count )")
        print("(congressSenateSigned.count + congressHouseSigned.count): \((congressSenateSigned.count + congressHouseSigned.count))")
        print("congressHouseSigned.count: \(congressHouseSigned.count)")
        print("congressSenateSigned.count: \(congressSenateSigned.count)")
        
        if(a < congressHouseSigned.count){
            print("congressHouseSigned[a]: \(congressHouseSigned[a])")
        }
        if (b < congressSenateSigned.count){
            print("congressSenateSigned[b]: \(congressSenateSigned[b])")
        }
        
        var added = false
        
        if (congressSigned.count == (congressSenateSigned.count + congressHouseSigned.count)){
            print("🏁Finished")
            print("congressSigned: \(congressSigned)")
            
            added = true
            downloadFinish = true

            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
            congressEnactedTV.reloadData()
        }
        else if(a > congressHouseSigned.count-1 && congressSenateSigned.count != 0){
            print("a >")
            congressSigned.append(congressSenateSigned[b])
            congressNumbers.append(congressSenateNumbers[congressSenateSigned[b]+congressSenateNumber[b]]!)
            congressDescription.append(congressSenateDescription[congressSenateSigned[b]+congressSenateNumber[b]]!)
            congressPDF.append(congressSenatePDF[congressSenateSigned[b]+congressSenateNumber[b]]!)
            b = b + 1
            added = true
            organizingBills()
        }
        else if(b > congressSenateSigned.count-1 && congressHouseSigned.count != 0){
            print("b >")
            congressSigned.append(congressHouseSigned[a])
            congressNumbers.append(congressHouseNumbers[congressHouseSigned[a]+congressHouseNumber[a]]!)
            congressDescription.append(congressHouseDescription[congressHouseSigned[a]+congressHouseNumber[a]]!)
            congressPDF.append(congressHousePDF[congressHouseSigned[a]+congressHouseNumber[a]]!)
            a = a + 1
            added = true
            organizingBills()
        }
        
        if(congressSenateSigned.count != 0 && congressHouseSigned.count != 0 && added == false){
            if (stringToDate(congressHouseSigned[a]) == stringToDate(congressSenateSigned[b])){
                print("==")
                congressSigned.append(congressHouseSigned[a])
                congressNumbers.append(congressHouseNumbers[congressHouseSigned[a]+congressHouseNumber[a]]!)
                congressDescription.append(congressHouseDescription[congressHouseSigned[a]+congressHouseNumber[a]]!)
                congressPDF.append(congressHousePDF[congressHouseSigned[a]+congressHouseNumber[a]]!)
                congressSigned.append(congressSenateSigned[b])
                congressNumbers.append(congressSenateNumbers[congressSenateSigned[b]+congressSenateNumber[b]]!)
                congressDescription.append(congressSenateDescription[congressSenateSigned[b]+congressSenateNumber[b]]!)
                congressPDF.append(congressSenatePDF[congressSenateSigned[b]+congressSenateNumber[b]]!)
                a = a + 1
                b = b + 1
                organizingBills()
            }
            else if (stringToDate(congressHouseSigned[a]) > stringToDate(congressSenateSigned[b])){
                print(">")
                congressSigned.append(congressHouseSigned[a])
                congressNumbers.append(congressHouseNumbers[congressHouseSigned[a]+congressHouseNumber[a]]!)
                congressDescription.append(congressHouseDescription[congressHouseSigned[a]+congressHouseNumber[a]]!)
                congressPDF.append(congressHousePDF[congressHouseSigned[a]+congressHouseNumber[a]]!)
                a = a + 1
                organizingBills()
            }
            else if (stringToDate(congressHouseSigned[a]) < stringToDate(congressSenateSigned[b])){
                print("<")
                congressSigned.append(congressSenateSigned[b])
                congressNumbers.append(congressSenateNumbers[congressSenateSigned[b]+congressSenateNumber[b]]!)
                congressDescription.append(congressSenateDescription[congressSenateSigned[b]+congressSenateNumber[b]]!)
                congressPDF.append(congressSenatePDF[congressSenateSigned[b]+congressSenateNumber[b]]!)
                b = b + 1
                organizingBills()
            }
        }
        }
        
        organizingBills()
        
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
        //Shows bill from congress.gov
        let selectedCV = indexPath.item
        print("selectedCV: \(selectedCV)")
        
        let urlVC = UIStoryboard(name: self.tool.sbName(), bundle: nil).instantiateViewController(withIdentifier: "urlWebview") as! urlWeb
        urlVC.urlPass = congressPDF[selectedCV]
        
        self.navigationController?.pushViewController(urlVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "billCell", for: indexPath) as! executiveOrderCells
        
        if(downloadFinish == false){
            cell.number.text = "Loading"
            cell.signed.text = "Loading"
            cell.eoDescription.text = "Loading"
        }
        else if(downloadFinish == true){
            cell.number.text = congressNumbers[indexPath.row]
            cell.signed.text = "Signed:\n" + congressSigned[indexPath.row]
            cell.eoDescription.text = congressDescription[indexPath.row]
            
        }
        
        return cell
    }
    
}
