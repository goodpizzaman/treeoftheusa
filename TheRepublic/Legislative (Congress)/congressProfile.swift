//
//  congressProfile.swift
//  Tree of the USA
//
//  Created by x on 09/01/18.
//  Copyright © 2018 x. All rights reserved.
//

import UIKit
import Haneke
import DeviceKit

class congressProfile: UIViewController {
    //Congress Profile after touches a senator or house of representative

    //Parties: D, R, I
    @IBOutlet var partyColor: UIView!
    @IBOutlet var congressPicture: UIImageView!
    @IBOutlet var congressName: UILabel!
    
    var color = ""
    var profileURL = ""
    var name = ""
    var firstName = ""
    var lastName = ""
    var community = ""
    
    var id = ""
    var www = ""
    var twitter = ""
    var facebook = ""
    var youtube = ""
    var votesmart = ""
    var govtrack = ""
    var cspan = ""
    var phone = ""
    
    var tool = tools()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setup custom back button
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let yourBackImage = UIImage(named: "backButton")
        self.navigationController?.navigationBar.backIndicatorImage = yourBackImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
        
        print("Showing profile for: \(name), \(id)")

        //Party Color
        partyColor.backgroundColor = hexColor(color)
        
        //Profile photo
        congressPicture.hnk_setImageFromURL(URL(string: profileURL)!, placeholder: nil, format: nil, failure: nil) { (image) in
            self.congressPicture.image = image
            self.congressPicture.layer.cornerRadius = 10
            self.congressPicture.clipsToBounds = true
        }
        
        congressName.text = name
        community = community.replacingOccurrences(of: ".", with: "")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func phone(_ sender: Any) {
        //Calls congressman
        print("phone: \(phone)")
        if(phone == ""){
            let error = UIAlertController(title: "Error", message: "\(name) does not have a phone number.", preferredStyle: UIAlertControllerStyle.alert)
            error.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(UIAlertAction) -> Void in
                print("No phone")
            }))
            
            self.present(error, animated: true, completion: nil)
        }
        else{
            UIApplication.shared.open(URL(string: "tel://" + phone.replacingOccurrences(of: "-", with: ""))!, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func votes(_ sender: Any) {
        //Shows voted bills
        print("votes id: \(id)")
        
        let votesVC = UIStoryboard(name: self.tool.sbName(), bundle: nil).instantiateViewController(withIdentifier: "congressVotes") as! congressVotes
        votesVC.id = id
        
        self.navigationController?.pushViewController(votesVC, animated: true)
    }
    
    @IBAction func sponsoredBills(_ sender: Any) {
        //Shows sponsored bills
        print("sponsoredBills, id: \(id)")
        
        let sponsoredBillsVC = UIStoryboard(name: self.tool.sbName(), bundle: nil).instantiateViewController(withIdentifier: "congressSponsoredBills") as! congressSponsoredBills
        sponsoredBillsVC.id = id
        
        self.navigationController?.pushViewController(sponsoredBillsVC, animated: true)
    }
    
    @IBAction func www(_ sender: Any) {
        //Shows congressman website
        print("www: \(www)")
        
        let urlVC = UIStoryboard(name: self.tool.sbName(), bundle: nil).instantiateViewController(withIdentifier: "urlWebview") as! urlWeb
        urlVC.urlPass = www
        
        self.navigationController?.pushViewController(urlVC, animated: true)
    }
    
    @IBAction func twitter(_ sender: Any) {
        //Shows congressman twitter
        print("twitter: \(twitter)")
        
        if(twitter == ""){
            let error = UIAlertController(title: "Error", message: "\(name) does not have a twitter account.", preferredStyle: UIAlertControllerStyle.alert)
            error.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(UIAlertAction) -> Void in
                print("No twitter")
            }))
            
            self.present(error, animated: true, completion: nil)
        }
        else{
            if(UIApplication.shared.canOpenURL(NSURL(string: "twitterrific://")! as URL)){
                let url = NSURL(string: "twitterrific://current/profile?screen_name=\(twitter)")
                UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
                print("Twitterrific App")
            }
                
            else if(UIApplication.shared.canOpenURL(NSURL(string: "tweetbot://")! as URL)){
                let url = NSURL(string: "tweetbot://realDonaldTrump/user_profile/\(twitter)")
                UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
                print("Tweetbot App")
            }
                
            else if (UIApplication.shared.canOpenURL(NSURL(string: "twitter:///")! as URL)){
                let url = NSURL(string: "twitter:///user?screen_name=\(twitter)")
                UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
                print("Twitter App")
            }
                
            else{
                let urlVC = UIStoryboard(name: self.tool.sbName(), bundle: nil).instantiateViewController(withIdentifier: "urlWebview") as! urlWeb
                urlVC.urlPass = "https://twitter.com/\(twitter)"
                
                self.navigationController?.pushViewController(urlVC, animated: true)
            }
        }
    }
    
    @IBAction func facebook(_ sender: Any) {
        //Shows congressman facebook
        print("facebook: \(facebook)")
        
        if(facebook == ""){
            let error = UIAlertController(title: "Error", message: "\(name) does not have a facebook account.", preferredStyle: UIAlertControllerStyle.alert)
            error.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(UIAlertAction) -> Void in
                print("No facebook")
            }))
            
            self.present(error, animated: true, completion: nil)
        }
        else{
            let urlVC = UIStoryboard(name: self.tool.sbName(), bundle: nil).instantiateViewController(withIdentifier: "urlWebview") as! urlWeb
            urlVC.urlPass = "https://www.facebook.com/\(facebook)/"
            
            self.navigationController?.pushViewController(urlVC, animated: true)
        }

    }
    
    @IBAction func youtube(_ sender: Any) {
        //Shows congressman youtube
        print("youtube: \(youtube)")
        
        if(youtube == ""){
            let error = UIAlertController(title: "Error", message: "\(name) does not have a youtube account.", preferredStyle: UIAlertControllerStyle.alert)
            error.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(UIAlertAction) -> Void in
                print("No youtube")
            }))
            
            self.present(error, animated: true, completion: nil)
        }
        else{
            
            if(UIApplication.shared.canOpenURL(NSURL(string: "youtube://")! as URL)){
                let url = NSURL(string: "youtube://www.youtube.com/\(youtube)/")
                //Example: twitterrific://current/profile?screen_name=lil_algo
                UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
                print("Youtube App")
            }
            else{
                let urlVC = UIStoryboard(name: self.tool.sbName(), bundle: nil).instantiateViewController(withIdentifier: "urlWebview") as! urlWeb
                urlVC.urlPass = "https://www.youtube.com/\(youtube)/"
            
                self.navigationController?.pushViewController(urlVC, animated: true)
            }
        }
    }
    
    @IBAction func votesmart(_ sender: Any) {
        //Shows congressman votesmart profile
        print("votesmart: \(votesmart)")
        
        if(votesmart == ""){
            let error = UIAlertController(title: "Error", message: "\(name) does not have information on votesmart.", preferredStyle: UIAlertControllerStyle.alert)
            error.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(UIAlertAction) -> Void in
                print("No votesmart")
            }))
            
            self.present(error, animated: true, completion: nil)
        }
        else{
            let urlVC = UIStoryboard(name: self.tool.sbName(), bundle: nil).instantiateViewController(withIdentifier: "urlWebview") as! urlWeb
            urlVC.urlPass = "https://votesmart.org/candidate/biography/\(votesmart)/"
            
            self.navigationController?.pushViewController(urlVC, animated: true)
        }
    }
    
    @IBAction func govtrack(_ sender: Any) {
        //Shows congressman govtrack profile
        print("govtrack: \(govtrack)")
        
        if(govtrack == ""){
            let error = UIAlertController(title: "Error", message: "\(name) does not have information on govtrack.", preferredStyle: UIAlertControllerStyle.alert)
            error.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(UIAlertAction) -> Void in
                print("No govtrack")
            }))
            
            self.present(error, animated: true, completion: nil)
        }
        else{
            let urlVC = UIStoryboard(name: self.tool.sbName(), bundle: nil).instantiateViewController(withIdentifier: "urlWebview") as! urlWeb
            urlVC.urlPass = "https://www.govtrack.us/congress/members/\(firstName)_\(lastName)/\(govtrack)"
            
            self.navigationController?.pushViewController(urlVC, animated: true)
        }

    }
    
    @IBAction func cspan(_ sender: Any) {
        //Shows congressman C-SPAN profile
        print("cspan: \(cspan)")
        
        if(cspan == ""){
            let error = UIAlertController(title: "Error", message: "\(name) does not have a cspan videos.", preferredStyle: UIAlertControllerStyle.alert)
            error.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(UIAlertAction) -> Void in
                print("No cspan")
            }))
            
            self.present(error, animated: true, completion: nil)
        }
        else{
            let urlVC = UIStoryboard(name: self.tool.sbName(), bundle: nil).instantiateViewController(withIdentifier: "urlWebview") as! urlWeb
            urlVC.urlPass = "https://www.c-span.org/search/?searchtype=Videos&sort=Newest&personid[]=\(cspan)"
            
            self.navigationController?.pushViewController(urlVC, animated: true)
        }
    }
    
}
