//
//  congress.swift
//  Tree of the USA
//
//  Created by x on 09/01/18.
//  Copyright © 2018 x. All rights reserved.
//

import UIKit
import CoreLocation
import GEOSwift
import Alamofire
import SwiftSpinner
import Haneke
import PMAlertController
import DeviceKit

class congress: UIViewController, CLLocationManagerDelegate {
    //---Congress
    //Shows the user their congressmen from their district by using their GPS location.
    //It takes the GPS location and finds which geojson the user is located in to find the district.
    //After finding the district it displays the two senators and the house of representative.
    
    @IBOutlet var senatorFirst: UIButton!
    @IBOutlet var senatorSecond: UIButton!
    @IBOutlet var house: UIButton!
    @IBOutlet var senateFirstName: UILabel!
    @IBOutlet var senateSecondName: UILabel!
    @IBOutlet var houseName: UILabel!
    @IBOutlet var stateDistrict: UILabel!
    
    var locationManager: CLLocationManager = CLLocationManager()
    var startLocation: CLLocation!
    var latitude = ""
    var longitude = ""
    var foundLocation = false
    
    var senateFirstAllInfo = [String]()
    var senateSecondAllInfo = [String]()
    var houseAllInfo = [String]()
    
    var state = ""
    var district = ""
    
    var tool = tools()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setups custom back button
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let yourBackImage = UIImage(named: "backButton")
        self.navigationController?.navigationBar.backIndicatorImage = yourBackImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
        
        //Setups CLLocationManager
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        startLocation = nil

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        //When CLLocationManager succeeds of finding location of user
        
        let latestLocation: CLLocation = locations[locations.count - 1]
        
        if (foundLocation == false){
            foundLocation = true
            latitude = String(format: "%.4f", latestLocation.coordinate.latitude)
            longitude = String(format: "%.4f", latestLocation.coordinate.longitude)
            print("🍎latitude: \(latitude)")
            print("🍎longitude: \(longitude)")
            
            if startLocation == nil {
                startLocation = latestLocation
            }
            
            Async.main({SwiftSpinner.show("Loading Congressmen")})
            
            Async.main(after: 0.3, {self.getCongress()})
        }

    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //When CLLocationManager fails of finding location of user
        
        SwiftSpinner.hide()
        
        if(foundLocation == false){
            let error = UIAlertController(title: "Error", message: "Can not find your location. Please enable 'Location Services' for 'The Republic'.", preferredStyle: UIAlertControllerStyle.alert)
            error.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(UIAlertAction) -> Void in
                print("Location error: \(error)")
                self.navigationController?.popToRootViewController(animated: true)
            }))
        
            self.present(error, animated: true, completion: nil)
        }
    }

    func getCongress(){
        //Get district from user GPS location
        
        print("getCongress")
        
        var distanceBetweenSmallest = 9999999.0
        var userStateDistrict = ""
        let districts = ["AK-0","AL-1","AL-2","AL-3","AL-4","AL-5","AL-6","AL-7","AR-1","AR-2","AR-3","AR-4","AZ-1","AZ-2","AZ-3","AZ-4","AZ-5","AZ-6","AZ-7","AZ-8","AZ-9","CA-1","CA-10","CA-11","CA-12","CA-13","CA-14","CA-15","CA-16","CA-17","CA-18","CA-19","CA-2","CA-20","CA-21","CA-22","CA-23","CA-24","CA-25","CA-26","CA-27","CA-28","CA-29","CA-3","CA-30","CA-31","CA-32","CA-33","CA-34","CA-35","CA-36","CA-37","CA-38","CA-39","CA-4","CA-40","CA-41","CA-42","CA-43","CA-44","CA-45","CA-46","CA-47","CA-48","CA-49","CA-5","CA-50","CA-51","CA-52","CA-53","CA-6","CA-7","CA-8","CA-9","CO-1","CO-2","CO-3","CO-4","CO-5","CO-6","CO-7","CT-1","CT-2","CT-3","CT-4","CT-5","DE-0","FL-1","FL-10","FL-11","FL-12","FL-13","FL-14","FL-15","FL-16","FL-17","FL-18","FL-19","FL-2","FL-20","FL-21","FL-22","FL-23","FL-24","FL-25","FL-26","FL-27","FL-3","FL-4","FL-5","FL-6","FL-7","FL-8","FL-9","GA-1","GA-10","GA-11","GA-12","GA-13","GA-14","GA-2","GA-3","GA-4","GA-5","GA-6","GA-7","GA-8","GA-9","HI-1","HI-2","IA-1","IA-2","IA-3","IA-4","ID-1","ID-2","IL-1","IL-10","IL-11","IL-12","IL-13","IL-14","IL-15","IL-16","IL-17","IL-18","IL-2","IL-3","IL-4","IL-5","IL-6","IL-7","IL-8","IL-9","IN-1","IN-2","IN-3","IN-4","IN-5","IN-6","IN-7","IN-8","IN-9","KS-1","KS-2","KS-3","KS-4","KY-1","KY-2","KY-3","KY-4","KY-5","KY-6","LA-1","LA-2","LA-3","LA-4","LA-5","LA-6","MA-1","MA-2","MA-3","MA-4","MA-5","MA-6","MA-7","MA-8","MA-9","MD-1","MD-2","MD-3","MD-4","MD-5","MD-6","MD-7","MD-8","ME-1","ME-2","MI-1","MI-10","MI-11","MI-12","MI-13","MI-14","MI-2","MI-3","MI-4","MI-5","MI-6","MI-7","MI-8","MI-9","MN-1","MN-2","MN-3","MN-4","MN-5","MN-6","MN-7","MN-8","MO-1","MO-2","MO-3","MO-4","MO-5","MO-6","MO-7","MO-8","MS-1","MS-2","MS-3","MS-4","MT-0","NC-1","NC-10","NC-11","NC-12","NC-13","NC-2","NC-3","NC-4","NC-5","NC-6","NC-7","NC-8","NC-9","ND-0","NE-1","NE-2","NE-3","NH-1","NH-2","NJ-1","NJ-10","NJ-11","NJ-12","NJ-2","NJ-3","NJ-4","NJ-5","NJ-6","NJ-7","NJ-8","NJ-9","NM-1","NM-2","NM-3","NV-1","NV-2","NV-3","NV-4","NY-1","NY-10","NY-11","NY-12","NY-13","NY-14","NY-15","NY-16","NY-17","NY-18","NY-19","NY-2","NY-20","NY-21","NY-22","NY-23","NY-24","NY-25","NY-26","NY-27","NY-3","NY-4","NY-5","NY-6","NY-7","NY-8","NY-9","OH-1","OH-10","OH-11","OH-12","OH-13","OH-14","OH-15","OH-16","OH-2","OH-3","OH-4","OH-5","OH-6","OH-7","OH-8","OH-9","OK-1","OK-2","OK-3","OK-4","OK-5","OR-1","OR-2","OR-3","OR-4","OR-5","PA-1","PA-10","PA-11","PA-12","PA-13","PA-14","PA-15","PA-16","PA-17","PA-18","PA-2","PA-3","PA-4","PA-5","PA-6","PA-7","PA-8","PA-9","RI-1","RI-2","SC-1","SC-2","SC-3","SC-4","SC-5","SC-6","SC-7","SD-0","TN-1","TN-2","TN-3","TN-4","TN-5","TN-6","TN-7","TN-8","TN-9","TX-1","TX-10","TX-11","TX-12","TX-13","TX-14","TX-15","TX-16","TX-17","TX-18","TX-19","TX-2","TX-20","TX-21","TX-22","TX-23","TX-24","TX-25","TX-26","TX-27","TX-28","TX-29","TX-3","TX-30","TX-31","TX-32","TX-33","TX-34","TX-35","TX-36","TX-4","TX-5","TX-6","TX-7","TX-8","TX-9","UT-1","UT-2","UT-3","UT-4","VA-1","VA-10","VA-11","VA-2","VA-3","VA-4","VA-5","VA-6","VA-7","VA-8","VA-9","VT-0","WA-1","WA-10","WA-2","WA-3","WA-4","WA-5","WA-6","WA-7","WA-8","WA-9","WI-1","WI-2","WI-3","WI-4","WI-5","WI-6","WI-7","WI-8","WV-1","WV-2","WV-3","WY-0"]
        
        
        for i in 0...districts.count-1{
            //Goes through districts array of geojson to find user district
            
                do{
                    //print("🔧district: \(districts[i])")
            
                    let geoJSONURL = Bundle.main.url(forResource: districts[i], withExtension: "geojson")
                    //print("geoJSONURL: \(String(describing: geoJSONURL))")
                    let geometries = try Geometry.fromGeoJSON(geoJSONURL!)
                    let geoJson = geometries?[0] as? MultiPolygon
                    //print("geometries?[0]: \(String(describing: geometries?[0]))")
                    let shape = geoJson?.mapShape() as? MKShapesCollection
                    
                    //print("shape?.centroid: \(String(describing: shape?.centroid))")

                    let pinLocation = CLLocation(latitude: (shape?.centroid.latitude)!, longitude: (shape?.centroid.longitude)!)
                    //print("pinLocation.coordinate: \(pinLocation.coordinate)")
            
                    let distanceBetween = startLocation.distance(from: pinLocation)
                    //print("distanceBetween meters: \(distanceBetween)")
            
                    let miles = distanceBetween/1609.344
                    //print("distanceBetween miles: \(distanceBetween/1609.344)")
                    
                    if(distanceBetweenSmallest > miles){
                        distanceBetweenSmallest = miles
                        userStateDistrict = districts[i]
                        print("🔧userStateDistrict: \(userStateDistrict)")
                    }
            
                    if(i == (districts.count-1)){
                        print("🏁userStateDistrict: \(userStateDistrict)")
                        
                        //Find State
                        self.state = String(userStateDistrict.characters.prefix(2))
                        print("state: \(state)")
                        
                        //Find district
                        self.district = String(userStateDistrict.characters.prefix(5)).replacingOccurrences(of: state+"-", with: "")
                        print("district: \(district)")
                            
                        //Get congressman ID, get congressman information
                        getCongressmanID(state: state, district: district)
                        
                    }
            
                }
                    
                catch{
                    //catch error
                }
        }
        
        
    }
    
    func getCongressmanID(state: String, district: String){
        print("getCongressmanID")
        
        print("state: \(state), district: \(district)")
        
        var senateFirstID = ""
        var senateSecondID = ""
        var houseID = ""
        
        //📌Senate - Get the congressman ID by using state and district
        
        //requestString variable must be of type [String]
        let requestStringSenate : String =  "https://api.propublica.org/congress/v1/members/senate/\(state)/current.json"
        
        //headers variable must be of type [String: String]
        let headersSenate : HTTPHeaders = [
            "X-API-Key": "GET API KEY FROM PROPUBLICA",
            "Content-Type": "application/json"
        ]
        
        //Alamofire 4 uses a different .request syntax that Alamofire 3, so make sure you have the correct version and format.
        Alamofire.request(requestStringSenate, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headersSenate).responseJSON { (DataResponse) in
            //print("DataResponse: \(String(describing: DataResponse))")
            //print("DataResponse.result: \(String(describing: DataResponse.result))")
            //print("DataResponse.result.value: \(String(describing: DataResponse.result.value))")
            
            let json = DataResponse.result.value
            let value = json as! [String: Any]
            print("🛠value: \(value)")
            let message = String(describing: value["message"])
            
            if(message.contains("Endpoint request timed out")){
                print("Service not working")
                SwiftSpinner.hide()
                let badgeImageName = "TRPsad.png"
                let alertVC = PMAlertController(title: "Oh No!", description: "Congress service is not working. Please try again later.", image: UIImage(named: badgeImageName), style: .alert)
                
                alertVC.addAction(PMAlertAction(title: "OK", style: .default, action: { () in
                    print("Capture action OK")
                    self.navigationController?.popToRootViewController(animated: true)
                }))
                
                self.present(alertVC, animated: true, completion: nil)
            }
            
            else{
                let results = value["results"] as! [Any]
                //print("🛠results: \(String(describing: results))")

                //First senator ID
                let senateFirst = results[0] as! [String:Any]
                //print("🛠senateFirst: \(String(describing: senateFirst))")
                senateFirstID = senateFirst["id"] as! String
                print("🛠senateFirstID: \(String(describing: senateFirstID))")
            
                //Second Senator ID
                let senateSecond = results[1] as! [String:Any]
                //print("🛠senateSecond: \(String(describing: senateSecond))")
                senateSecondID = senateSecond["id"] as! String
                print("🛠senateSecondID: \(String(describing: senateSecondID))")
            
                if (houseID != ""){
                    self.getCongressmanInfo(senateFirstID: senateFirstID, senateSecondID: senateSecondID, houseID: houseID)
                }
            }
        }
        
        //📌House - Get the congressman ID by using state and district
        
        //requestString variable must be of type [String]
        let requestStringHouse : String =  "https://api.propublica.org/congress/v1/members/house/\(state)/\(district)/current.json"
        
        //headers variable must be of type [String: String]
        let headersHouse : HTTPHeaders = [
            "X-API-Key": "GET API KEY FROM PROPUBLICA",
            "Content-Type": "application/json"
        ]
        
        //Alamofire 4 uses a different .request syntax that Alamofire 3, so make sure you have the correct version and format.
        Alamofire.request(requestStringHouse, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headersHouse).responseJSON { (DataResponse) in
            //print("DataResponse: \(String(describing: DataResponse))")
            //print("DataResponse.result: \(String(describing: DataResponse.result))")
            //print("DataResponse.result.value: \(String(describing: DataResponse.result.value))")
            
            let json = DataResponse.result.value
            let value = json as! [String: Any]
            //print("🛠value: \(value)")
            
            let message = String(describing: value["message"])
            
            if(message.contains("Endpoint request timed out")){
                print("Service not working")
                SwiftSpinner.hide()
                let badgeImageName = "TRPsad.png"
                let alertVC = PMAlertController(title: "Oh No!", description: "Congress service is not working. Please try again later.", image: UIImage(named: badgeImageName), style: .alert)
                
                alertVC.addAction(PMAlertAction(title: "OK", style: .default, action: { () in
                    print("Capture action OK")
                    self.navigationController?.popToRootViewController(animated: true)
                }))
                
                self.present(alertVC, animated: true, completion: nil)
            }
            
            else{
            
                let results = value["results"] as! [Any]
                //print("🛠results: \(String(describing: results))")
            
                //House ID
                let house = results[0] as! [String:Any]
                //print("🛠house: \(String(describing: house))")
                houseID = house["id"] as! String
                print("🛠houseID: \(String(describing: houseID))")
            
                if (senateFirstID != "" && senateSecondID != ""){
                    self.getCongressmanInfo(senateFirstID: senateFirstID, senateSecondID: senateSecondID, houseID: houseID)
                }
            }
            
        }
    }
    
    func getCongressmanInfo(senateFirstID : String, senateSecondID : String, houseID : String){
        print("getCongressmanInfo")
        
        //📌Senate - Get the congressman info using senateFirstID
        
        //requestString variable must be of type [String]
        let requestStringSenateFirst : String =  "https://api.propublica.org/congress/v1/members/\(senateFirstID).json"
        
        //headers variable must be of type [String: String]
        let headersSenateFirst : HTTPHeaders = [
            "X-API-Key": "GET API KEY FROM PROPUBLICA",
            "Content-Type": "application/json"
        ]
        
        //Alamofire 4 uses a different .request syntax that Alamofire 3, so make sure you have the correct version and format.
        Alamofire.request(requestStringSenateFirst, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headersSenateFirst).responseJSON { (DataResponse) in
            //print("DataResponse: \(String(describing: DataResponse))")
            //print("DataResponse.result: \(String(describing: DataResponse.result))")
            //print("DataResponse.result.value: \(String(describing: DataResponse.result.value))")
            
            let json = DataResponse.result.value
            let value = json as! [String: Any]
            //print("🛠value: \(value)")
            
            let message = String(describing: value["message"])
            
            if(message.contains("Endpoint request timed out")){
                print("Service not working")
                SwiftSpinner.hide()
                let badgeImageName = "TRPsad.png"
                let alertVC = PMAlertController(title: "Oh No!", description: "Congress service is not working. Please try again later.", image: UIImage(named: badgeImageName), style: .alert)
                
                alertVC.addAction(PMAlertAction(title: "OK", style: .default, action: { () in
                    print("Capture action OK")
                    self.navigationController?.popToRootViewController(animated: true)
                }))
                
                self.present(alertVC, animated: true, completion: nil)
            }

            else{
            let results = value["results"] as! [Any]
            //print("🛠results: \(String(describing: results))")
            
            //First senator ID info
            let senateFirstIDResult = results[0] as! [String:Any]
            print("🛠senateFirstIDResult: \(String(describing: senateFirstIDResult))")
            print("🍏memberID - senateFisrt: \(senateFirstID)")
            self.senateFirstAllInfo.append(senateFirstID)
            
            let photo = "https://theunitedstates.io/images/congress/450x550/\(senateFirstID).jpg"
            print("🛠photo: \(String(describing: photo))")
            self.senateFirstAllInfo.append(photo)
            
            let party = senateFirstIDResult["current_party"] as? String
            print("🛠party: \(String(describing: party))")
            self.senateFirstAllInfo.append(String(describing: party))
            
            let firstName = senateFirstIDResult["first_name"] as? String
            print("🛠firstName: \(String(describing: firstName))")
            self.senateFirstAllInfo.append(String(describing: firstName))
            
            let middleName = senateFirstIDResult["middle_name"] as? String
            print("🛠middleName: \(String(describing: middleName))")
            self.senateFirstAllInfo.append(String(describing: middleName))
            
            let lastName = senateFirstIDResult["last_name"] as? String
            print("🛠lastName: \(String(describing: lastName))")
            self.senateFirstAllInfo.append(String(describing: lastName))
            
            let birthDate = senateFirstIDResult["date_of_birth"] as? String
            print("🛠birthDate: \(String(describing: birthDate))")
            self.senateFirstAllInfo.append(String(describing: birthDate))
            
            let www = senateFirstIDResult["url"] as? String
            print("🛠www: \(String(describing: www))")
            self.senateFirstAllInfo.append(String(describing: www))
            
            let twitter = senateFirstIDResult["twitter_account"] as? String
            print("🛠twitter: \(String(describing: twitter))")
            self.senateFirstAllInfo.append(String(describing: twitter))
            
            let facebook = senateFirstIDResult["facebook_account"] as? String
            print("🛠facebook: \(String(describing: facebook))")
            self.senateFirstAllInfo.append(String(describing: facebook))
            
            let youtube = senateFirstIDResult["youtube_account"] as? String
            print("🛠youtube: \(String(describing: youtube))")
            self.senateFirstAllInfo.append(String(describing: youtube))
            
            let votesmart = senateFirstIDResult["votesmart_id"] as? String
            print("🛠votesmart: \(String(describing: votesmart))")
            self.senateFirstAllInfo.append(String(describing: votesmart))
            
            let govtrack = senateFirstIDResult["govtrack_id"] as? String
            print("🛠govtrack: \(String(describing: govtrack))")
            self.senateFirstAllInfo.append(String(describing: govtrack))
            
            let cspan = senateFirstIDResult["cspan_id"] as? String
            print("🛠cspan: \(String(describing: cspan))")
            self.senateFirstAllInfo.append(String(describing: cspan))
            
            let roles = senateFirstIDResult["roles"] as! [Any]
            //print("roles[0]: \(roles[0])")
            let rolesZeroDict = roles[0] as! [String: Any]
            let phoneNumber = rolesZeroDict["phone"] as? String
            print("🛠phoneNumber: \(String(describing: phoneNumber))")
            self.senateFirstAllInfo.append(String(describing: phoneNumber))
            
            if(self.senateFirstAllInfo.count == 15 && self.senateSecondAllInfo.count == 15 && self.houseAllInfo.count == 15){
                self.setup()
            }
            }
        }
        
        //📌Senate - Get the congressman info using senateSecondID
        
        //requestString variable must be of type [String]
        let requestStringSenateSecond : String =  "https://api.propublica.org/congress/v1/members/\(senateSecondID).json"
        
        //headers variable must be of type [String: String]
        let headersSenateSecond : HTTPHeaders = [
            "X-API-Key": "GET API KEY FROM PROPUBLICA",
            "Content-Type": "application/json"
        ]
        
        //Alamofire 4 uses a different .request syntax that Alamofire 3, so make sure you have the correct version and format.
        Alamofire.request(requestStringSenateSecond, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headersSenateSecond).responseJSON { (DataResponse) in
            //print("DataResponse: \(String(describing: DataResponse))")
            //print("DataResponse.result: \(String(describing: DataResponse.result))")
            //print("DataResponse.result.value: \(String(describing: DataResponse.result.value))")
            
            let json = DataResponse.result.value
            let value = json as! [String: Any]
            //print("🛠value: \(value)")
            
            let message = String(describing: value["message"])
            
            if(message.contains("Endpoint request timed out")){
                print("Service not working")
                SwiftSpinner.hide()
                let badgeImageName = "TRPsad.png"
                let alertVC = PMAlertController(title: "Oh No!", description: "Congress service is not working. Please try again later.", image: UIImage(named: badgeImageName), style: .alert)
                
                alertVC.addAction(PMAlertAction(title: "OK", style: .default, action: { () in
                    print("Capture action OK")
                    self.navigationController?.popToRootViewController(animated: true)
                }))
                
                self.present(alertVC, animated: true, completion: nil)
            }

            else{
            let results = value["results"] as! [Any]
            //print("🛠results: \(String(describing: results))")
            
            //Second senator ID info
            let senateSecondIDResult = results[0] as! [String:Any]
            print("🛠senateSecondIDResult: \(String(describing: senateSecondIDResult))")
            print("🍏memberID - senateFisrt: \(senateSecondID)")
            self.senateSecondAllInfo.append(senateSecondID)
            
            let photo = "https://theunitedstates.io/images/congress/450x550/\(senateSecondID).jpg"
            print("🛠photo: \(String(describing: photo))")
            self.senateSecondAllInfo.append(photo)
            
            let party = senateSecondIDResult["current_party"] as? String
            print("🛠party: \(String(describing: party))")
            self.senateSecondAllInfo.append(String(describing: party))
            
            let firstName = senateSecondIDResult["first_name"] as? String
            print("🛠firstName: \(String(describing: firstName))")
            self.senateSecondAllInfo.append(String(describing: firstName))
            
            let middleName = senateSecondIDResult["middle_name"] as? String
            print("🛠middleName: \(String(describing: middleName))")
            self.senateSecondAllInfo.append(String(describing: middleName))
            
            let lastName = senateSecondIDResult["last_name"] as? String
            print("🛠lastName: \(String(describing: lastName))")
            self.senateSecondAllInfo.append(String(describing: lastName))
            
            let birthDate = senateSecondIDResult["date_of_birth"] as? String
            print("🛠birthDate: \(String(describing: birthDate))")
            self.senateSecondAllInfo.append(String(describing: birthDate))
            
            let www = senateSecondIDResult["url"] as? String
            print("🛠www: \(String(describing: www))")
            self.senateSecondAllInfo.append(String(describing: www))
            
            let twitter = senateSecondIDResult["twitter_account"] as? String
            print("🛠twitter: \(String(describing: twitter))")
            self.senateSecondAllInfo.append(String(describing: twitter))
            
            let facebook = senateSecondIDResult["facebook_account"] as? String
            print("🛠facebook: \(String(describing: facebook))")
            self.senateSecondAllInfo.append(String(describing: facebook))
            
            let youtube = senateSecondIDResult["youtube_account"] as? String
            print("🛠youtube: \(String(describing: youtube))")
            self.senateSecondAllInfo.append(String(describing: youtube))
            
            let votesmart = senateSecondIDResult["votesmart_id"] as? String
            print("🛠votesmart: \(String(describing: votesmart))")
            self.senateSecondAllInfo.append(String(describing: votesmart))
            
            let govtrack = senateSecondIDResult["govtrack_id"] as? String
            print("🛠govtrack: \(String(describing: govtrack))")
            self.senateSecondAllInfo.append(String(describing: govtrack))
            
            let cspan = senateSecondIDResult["cspan_id"] as? String
            print("🛠cspan: \(String(describing: cspan))")
            self.senateSecondAllInfo.append(String(describing: cspan))
            
            let roles = senateSecondIDResult["roles"] as! [Any]
            //print("roles[0]: \(roles[0])")
            let rolesZeroDict = roles[0] as! [String: Any]
            let phoneNumber = rolesZeroDict["phone"] as? String
            print("🛠phoneNumber: \(String(describing: phoneNumber))")
            self.senateSecondAllInfo.append(String(describing: phoneNumber))
            
            if(self.senateFirstAllInfo.count == 15 && self.senateSecondAllInfo.count == 15 && self.houseAllInfo.count == 15){
                self.setup()
            }
            }
        }
        
        //📌House - Get the congressman info using senateFirstID
        
        //requestString variable must be of type [String]
        let requestStringHouse : String =  "https://api.propublica.org/congress/v1/members/\(houseID).json"
        
        //headers variable must be of type [String: String]
        let headersHouse : HTTPHeaders = [
            "X-API-Key": "GET API KEY FROM PROPUBLICA",
            "Content-Type": "application/json"
        ]
        
        //Alamofire 4 uses a different .request syntax that Alamofire 3, so make sure you have the correct version and format.
        Alamofire.request(requestStringHouse, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headersHouse).responseJSON { (DataResponse) in
            //print("DataResponse: \(String(describing: DataResponse))")
            //print("DataResponse.result: \(String(describing: DataResponse.result))")
            //print("DataResponse.result.value: \(String(describing: DataResponse.result.value))")
            
            let json = DataResponse.result.value
            let value = json as! [String: Any]
            //print("🛠value: \(value)")
            
            let message = String(describing: value["message"])
            
            if(message.contains("Endpoint request timed out")){
                print("Service not working")
                SwiftSpinner.hide()
                let badgeImageName = "TRPsad.png"
                let alertVC = PMAlertController(title: "Oh No!", description: "Congress service is not working. Please try again later.", image: UIImage(named: badgeImageName), style: .alert)
                
                alertVC.addAction(PMAlertAction(title: "OK", style: .default, action: { () in
                    print("Capture action OK")
                    self.navigationController?.popToRootViewController(animated: true)
                }))
                
                self.present(alertVC, animated: true, completion: nil)
            }

            else{
            let results = value["results"] as! [Any]
            //print("🛠results: \(String(describing: results))")
            
            //House ID info
            let houseIDResult = results[0] as! [String:Any]
            print("🛠houseIDResult: \(String(describing: houseIDResult))")
            print("🍏memberID - senateFisrt: \(houseID)")
            self.houseAllInfo.append(houseID)
            
            let photo = "https://theunitedstates.io/images/congress/450x550/\(houseID).jpg"
            print("🛠photo: \(String(describing: photo))")
            self.houseAllInfo.append(photo)
            
            let party = houseIDResult["current_party"] as? String
            print("🛠party: \(String(describing: party))")
            self.houseAllInfo.append(String(describing: party))
            
            let firstName = houseIDResult["first_name"] as? String
            print("🛠firstName: \(String(describing: firstName))")
            self.houseAllInfo.append(String(describing: firstName))
            
            let middleName = houseIDResult["middle_name"] as? String
            print("🛠middleName: \(String(describing: middleName))")
            self.houseAllInfo.append(String(describing: middleName))
            
            let lastName = houseIDResult["last_name"] as? String
            print("🛠lastName: \(String(describing: lastName))")
            self.houseAllInfo.append(String(describing: lastName))
            
            let birthDate = houseIDResult["date_of_birth"] as? String
            print("🛠birthDate: \(String(describing: birthDate))")
            self.houseAllInfo.append(String(describing: birthDate))
            
            let www = houseIDResult["url"] as? String
            print("🛠www: \(String(describing: www))")
            self.houseAllInfo.append(String(describing: www))
            
            let twitter = houseIDResult["twitter_account"] as? String
            print("🛠twitter: \(String(describing: twitter))")
            self.houseAllInfo.append(String(describing: twitter))
            
            let facebook = houseIDResult["facebook_account"] as? String
            print("🛠facebook: \(String(describing: facebook))")
            self.houseAllInfo.append(String(describing: facebook))
            
            let youtube = houseIDResult["youtube_account"] as? String
            print("🛠youtube: \(String(describing: youtube))")
            self.houseAllInfo.append(String(describing: youtube))
            
            let votesmart = houseIDResult["votesmart_id"] as? String
            print("🛠votesmart: \(String(describing: votesmart))")
            self.houseAllInfo.append(String(describing: votesmart))
            
            let govtrack = houseIDResult["govtrack_id"] as? String
            print("🛠govtrack: \(String(describing: govtrack))")
            self.houseAllInfo.append(String(describing: govtrack))
            
            let cspan = houseIDResult["cspan_id"] as? String
            print("🛠cspan: \(String(describing: cspan))")
            self.houseAllInfo.append(String(describing: cspan))
            
            let roles = houseIDResult["roles"] as! [Any]
            //print("roles[0]: \(roles[0])")
            let rolesZeroDict = roles[0] as! [String: Any]
            let phoneNumber = rolesZeroDict["phone"] as? String
            print("🛠phoneNumber: \(String(describing: phoneNumber))")
            self.houseAllInfo.append(String(describing: phoneNumber))
            
            if(self.senateFirstAllInfo.count == 15 && self.senateSecondAllInfo.count == 15 && self.houseAllInfo.count == 15){
                self.setup()
            }
            }
        }
        
    }
    
    func setup(){
        //Setups congress viewcontroller
        
        print("setup")
        
        print("Senate1 first name: \(senateFirstAllInfo[3])")
        print("Senate2 first name: \(senateSecondAllInfo[3])")
        print("House first name: \(houseAllInfo[3])")
        
        //Setups House of Represenative stateDistrict label
        stateDistrict.text = "\(state) of District \(district)"

        //---Setups the two senators and house of representative portraits
        senatorFirst.hnk_setImageFromURL(URL(string: senateFirstAllInfo[1])!, state: .normal, placeholder: nil, format: nil, failure: nil) { (image) in
            self.senatorFirst.setBackgroundImage(image, for: .normal)
            self.senatorFirst.layer.cornerRadius = 10
            self.senatorFirst.clipsToBounds = true
        }

        senatorSecond.hnk_setImageFromURL(URL(string: senateSecondAllInfo[1])!, state: .normal, placeholder: nil, format: nil, failure: nil) { (image) in
            self.senatorSecond.setBackgroundImage(image, for: .normal)
            self.senatorSecond.layer.cornerRadius = 10
            self.senatorSecond.clipsToBounds = true
        }
        senatorSecond.layer.cornerRadius = 10
        senatorSecond.clipsToBounds = true
        
        house.hnk_setImageFromURL(URL(string: houseAllInfo[1])!, state: .normal, placeholder: nil, format: nil, failure: nil) { (image) in
            self.house.setBackgroundImage(image, for: .normal)
            self.house.layer.cornerRadius = 10
            self.house.clipsToBounds = true
        }
        house.layer.cornerRadius = 10
        house.clipsToBounds = true
        //---
        
        //---Setups the two senators and house of representative names
        var sfirstName = senateFirstAllInfo[3] + " " + senateFirstAllInfo[4] + " " + senateFirstAllInfo[5]
        sfirstName = sfirstName.replacingOccurrences(of: "Optional(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "nil", with: "").replacingOccurrences(of: "\"", with: "")
        
        var sSecondName = senateSecondAllInfo[3] + " " + senateSecondAllInfo[4] + " " + senateSecondAllInfo[5]
        sSecondName = sSecondName.replacingOccurrences(of: "Optional(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "nil", with: "").replacingOccurrences(of: "\"", with: "")
        
        var hName = houseAllInfo[3] + " " + houseAllInfo[4] + " " + houseAllInfo[5]
        hName = hName.replacingOccurrences(of: "Optional(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "nil", with: "").replacingOccurrences(of: "\"", with: "")
        
        senateFirstName.text = sfirstName
        senateSecondName.text = sSecondName
        houseName.text = hName
        //---
        
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        SwiftSpinner.hide()
    }


    @IBAction func senatorFirstSee(_ sender: Any) {
        //Button to show first senator (left) congressProfile
        
        print("senatorFirstSee")
        
        let congressProfile = UIStoryboard(name: self.tool.sbName(), bundle: nil).instantiateViewController(withIdentifier: "congressProfile") as! congressProfile
        
        print("senateFirstAllInfo[2]: \(senateFirstAllInfo[2])")
        
        //---Color of party representation
        let color = senateFirstAllInfo[2].replacingOccurrences(of: "Optional(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "\"", with: "")
        print("color: \(color)")
        if(color == "D"){
            congressProfile.color = "00B0EE"
        }
        else if(color == "R"){
            congressProfile.color = "D6262B"
        }
        //---
        
        //---setup congressProfile content
        congressProfile.profileURL = senateFirstAllInfo[1]
        
        var sfirstName = senateFirstAllInfo[3] + " " + senateFirstAllInfo[4] + " " + senateFirstAllInfo[5]
        sfirstName = sfirstName.replacingOccurrences(of: "Optional(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "nil", with: "").replacingOccurrences(of: "\"", with: "")
        congressProfile.name = sfirstName
        congressProfile.firstName = senateFirstAllInfo[3].replacingOccurrences(of: "Optional(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "nil", with: "").replacingOccurrences(of: "\"", with: "")
        congressProfile.lastName = senateFirstAllInfo[5].replacingOccurrences(of: "Optional(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "nil", with: "").replacingOccurrences(of: "\"", with: "")
        
        congressProfile.community = sfirstName + " - " + state + " Senator"
        
        congressProfile.id = senateFirstAllInfo[0].replacingOccurrences(of: "Optional(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "\"", with: "")
        congressProfile.www = senateFirstAllInfo[7].replacingOccurrences(of: "Optional(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "\"", with: "")
        congressProfile.twitter = senateFirstAllInfo[8].replacingOccurrences(of: "Optional(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "\"", with: "")
        congressProfile.facebook = senateFirstAllInfo[9].replacingOccurrences(of: "Optional(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "\"", with: "")
        congressProfile.youtube = senateFirstAllInfo[10].replacingOccurrences(of: "Optional(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "\"", with: "")
        congressProfile.votesmart = senateFirstAllInfo[11].replacingOccurrences(of: "Optional(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "\"", with: "")
        congressProfile.govtrack = senateFirstAllInfo[12].replacingOccurrences(of: "Optional(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "\"", with: "")
        congressProfile.cspan = senateFirstAllInfo[13].replacingOccurrences(of: "Optional(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "\"", with: "")
        congressProfile.phone = senateFirstAllInfo[14].replacingOccurrences(of: "Optional(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "\"", with: "")
        //---
        
        self.navigationController?.pushViewController(congressProfile, animated: true)
    }

    @IBAction func senatorSecondSee(_ sender: Any) {
        //Button to show second senator (right) congressProfile
        
        print("senatorSecondSee")
        
        let congressProfile = UIStoryboard(name: self.tool.sbName(), bundle: nil).instantiateViewController(withIdentifier: "congressProfile") as! congressProfile
        
        print("senateSecondAllInfo[2]: \(senateSecondAllInfo[2])")
        
        //---Color of party representation
        let color = senateSecondAllInfo[2].replacingOccurrences(of: "Optional(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "\"", with: "")
        print("color: \(color)")
        if(color == "D"){
            congressProfile.color = "00B0EE"
        }
        else if(color == "R"){
            congressProfile.color = "D6262B"
        }
        //---
        
        //---setup congressProfile content
        congressProfile.profileURL = senateSecondAllInfo[1]
        
        var sfirstName = senateSecondAllInfo[3] + " " + senateSecondAllInfo[4] + " " + senateSecondAllInfo[5]
        sfirstName = sfirstName.replacingOccurrences(of: "Optional(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "nil", with: "").replacingOccurrences(of: "\"", with: "")
        congressProfile.name = sfirstName
        congressProfile.firstName = senateSecondAllInfo[3].replacingOccurrences(of: "Optional(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "nil", with: "").replacingOccurrences(of: "\"", with: "")
        congressProfile.lastName = senateSecondAllInfo[5].replacingOccurrences(of: "Optional(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "nil", with: "").replacingOccurrences(of: "\"", with: "")
        
        congressProfile.community = sfirstName + " - " + state + " Senator"
        
        congressProfile.id = senateSecondAllInfo[0].replacingOccurrences(of: "Optional(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "\"", with: "")
        congressProfile.www = senateSecondAllInfo[7].replacingOccurrences(of: "Optional(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "\"", with: "")
        congressProfile.twitter = senateSecondAllInfo[8].replacingOccurrences(of: "Optional(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "\"", with: "")
        congressProfile.facebook = senateSecondAllInfo[9].replacingOccurrences(of: "Optional(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "\"", with: "")
        congressProfile.youtube = senateSecondAllInfo[10].replacingOccurrences(of: "Optional(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "\"", with: "")
        congressProfile.votesmart = senateSecondAllInfo[11].replacingOccurrences(of: "Optional(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "\"", with: "")
        congressProfile.govtrack = senateSecondAllInfo[12].replacingOccurrences(of: "Optional(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "\"", with: "")
        congressProfile.cspan = senateSecondAllInfo[13].replacingOccurrences(of: "Optional(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "\"", with: "")
        congressProfile.phone = senateSecondAllInfo[14].replacingOccurrences(of: "Optional(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "\"", with: "")
        //---
        
        self.navigationController?.pushViewController(congressProfile, animated: true)
    }
    
    @IBAction func houseSee(_ sender: Any) {
        //Button to show house of representative congressProfile
        
        print("houseSee")
        
        let congressProfile = UIStoryboard(name: self.tool.sbName(), bundle: nil).instantiateViewController(withIdentifier: "congressProfile") as! congressProfile
        
        print("houseAllInfo[2]: \(houseAllInfo[2])")
        
        //---Color of party representation
        let color = houseAllInfo[2].replacingOccurrences(of: "Optional(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "\"", with: "")
        print("color: \(color)")
        if(color == "D"){
            congressProfile.color = "00B0EE"
        }
        else if(color == "R"){
            congressProfile.color = "D6262B"
        }
        //---
        
        //---setup congressProfile content
        congressProfile.profileURL = houseAllInfo[1]
        
        var sfirstName = houseAllInfo[3] + " " + houseAllInfo[4] + " " + houseAllInfo[5]
        sfirstName = sfirstName.replacingOccurrences(of: "Optional(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "nil", with: "").replacingOccurrences(of: "\"", with: "")
        congressProfile.name = sfirstName
        congressProfile.firstName = houseAllInfo[3].replacingOccurrences(of: "Optional(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "nil", with: "").replacingOccurrences(of: "\"", with: "")
        congressProfile.lastName = houseAllInfo[5].replacingOccurrences(of: "Optional(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "nil", with: "").replacingOccurrences(of: "\"", with: "")
        
        congressProfile.community = sfirstName + " - " + state + " Senator"
        
        congressProfile.id = houseAllInfo[0].replacingOccurrences(of: "Optional(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "\"", with: "")
        congressProfile.www = houseAllInfo[7].replacingOccurrences(of: "Optional(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "\"", with: "")
        congressProfile.twitter = houseAllInfo[8].replacingOccurrences(of: "Optional(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "\"", with: "")
        congressProfile.facebook = houseAllInfo[9].replacingOccurrences(of: "Optional(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "\"", with: "")
        congressProfile.youtube = houseAllInfo[10].replacingOccurrences(of: "Optional(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "\"", with: "")
        congressProfile.votesmart = houseAllInfo[11].replacingOccurrences(of: "Optional(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "\"", with: "")
        congressProfile.govtrack = houseAllInfo[12].replacingOccurrences(of: "Optional(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "\"", with: "")
        congressProfile.cspan = houseAllInfo[13].replacingOccurrences(of: "Optional(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "\"", with: "")
        congressProfile.phone = houseAllInfo[14].replacingOccurrences(of: "Optional(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "\"", with: "")
        //---
        
        self.navigationController?.pushViewController(congressProfile, animated: true)
    }

}
