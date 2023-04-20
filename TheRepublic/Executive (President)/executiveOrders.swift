//
//  executiveOrders.swift
//  Tree of the USA
//
//  Created by x on 09/01/18.
//  Copyright © 2018 x. All rights reserved.
//

import UIKit
import Alamofire
import DeviceKit

class executiveOrders: UITableViewController {
    //Executive order tableview for the president
    
    @IBOutlet var executiveOrderTV: UITableView!
    
    var downloadFinish = false
    
    var eoNumbers = [String]()
    var eoSigned = [String]()
    var eoDescription = [String]()
    var eoPDF = [String]()
    
    var tool = tools()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setup custom back button
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let yourBackImage = UIImage(named: "backButton")
        self.navigationController?.navigationBar.backIndicatorImage = yourBackImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
        
        getEOs()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getEOs(){
        //Get executive orders from https://www.federalregister.gov/ json
        print("getEOs")
        
        Alamofire.request("https://www.federalregister.gov/documents/search.json?conditions%5Bcorrection%5D=0&conditions%5Bpresident%5D=donald-trump&conditions%5Bpresidential_document_type_id%5D=2&conditions%5Btype%5D=PRESDOCU&fields%5B%5D=citation&fields%5B%5D=document_number&fields%5B%5D=end_page&fields%5B%5D=executive_order_notes&fields%5B%5D=executive_order_number&fields%5B%5D=html_url&fields%5B%5D=pdf_url&fields%5B%5D=publication_date&fields%5B%5D=signing_date&fields%5B%5D=start_page&fields%5B%5D=title&fields%5B%5D=full_text_xml_url&fields%5B%5D=body_html_url&fields%5B%5D=json_url&order=executive_order_number&per_page=1000").responseJSON { response in
            
            if let json = response.result.value {
                print("JSON: \(json)")
                let value = json as! [String: Any]
                let results = value["results"] as! [Any]
                print("results: \(String(describing: results))")
                
                //Setup - Numbers, Signed, Description
                for i in 0...results.count-1{
                    let resultsDict = results[i] as! [String: Any]
                    
                    //Number
                    self.eoNumbers.append(String(describing: resultsDict["executive_order_number"]!))
                    print("number: \(String(describing: resultsDict["executive_order_number"]))")
                    
                    //Signed
                    self.eoSigned.append(String(describing: resultsDict["signing_date"]!))
                    print("signed: \(String(describing: resultsDict["signing_date"]!))")
                    
                    //Description
                    self.eoDescription.append(String(describing: resultsDict["title"]!))
                    print("description: \(String(describing: resultsDict["title"]!))")
                    
                    //PDF
                    self.eoPDF.append(String(describing: resultsDict["pdf_url"]!))
                    print("pdf: \(String(describing: resultsDict["pdf_url"]!))")
                }
                
                self.eoNumbers = self.eoNumbers.reversed()
                self.eoSigned = self.eoSigned.reversed()
                self.eoDescription = self.eoDescription.reversed()
                self.eoPDF = self.eoPDF.reversed()
                
                print("self.eoNumbers: \(self.eoNumbers)")
                
                self.downloadFinish = true
                self.executiveOrderTV.reloadData()
                
            }
        }

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if(downloadFinish == true){
            return eoNumbers.count
        }
        
        return 1
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Shows actual document of executive order pdf
        let selectedCV = indexPath.item
        print("selectedCV: \(selectedCV)")
        
        let urlVC = UIStoryboard(name: self.tool.sbName(), bundle: nil).instantiateViewController(withIdentifier: "urlWebview") as! urlWeb
        urlVC.urlPass = eoPDF[selectedCV]
        
        self.navigationController?.pushViewController(urlVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eoCell", for: indexPath) as! executiveOrderCells

        if(downloadFinish == false){
            cell.number.text = "Loading"
            cell.signed.text = "Loading"
            cell.eoDescription.text = "Loading"
        }
        else if(downloadFinish == true){
            cell.number.text = "#" + eoNumbers[indexPath.row]
            cell.signed.text = "Signed:\n" + eoSigned[indexPath.row]
            cell.eoDescription.text = eoDescription[indexPath.row]
        }

        return cell
    }
    
}
