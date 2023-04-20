//
//  executive.swift
//  Tree of the USA
//
//  Created by x on 09/01/18.
//  Copyright © 2018 x. All rights reserved.
//

import UIKit
import Alamofire
import DeviceKit

class executive: UIViewController {
    //---Executive
    //Shows the president with social networks, website, c-span, etc.

    var tool = tools()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setup custom back button
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let yourBackImage = UIImage(named: "backButton")
        self.navigationController?.navigationBar.backIndicatorImage = yourBackImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = yourBackImage

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func www(_ sender: Any) {
        //Website
        print("executive - www")
        
        let urlVC = UIStoryboard(name: self.tool.sbName(), bundle: nil).instantiateViewController(withIdentifier: "urlWebview") as! urlWeb
        urlVC.urlPass = "https://www.donaldjtrump.com"
        
        self.navigationController?.pushViewController(urlVC, animated: true)
    }

    @IBAction func twitter(_ sender: Any) {
        //Twitter
        print("executive - twitter")

        if(UIApplication.shared.canOpenURL(NSURL(string: "twitterrific://")! as URL)){
            let url = NSURL(string: "twitterrific://current/profile?screen_name=realDonaldTrump")
            //Example: twitterrific://current/profile?screen_name=lil_algo
            UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
            print("Twitterrific App")
        }
            
        else if(UIApplication.shared.canOpenURL(NSURL(string: "tweetbot://")! as URL)){
            let url = NSURL(string: "tweetbot://realDonaldTrump/user_profile/realDonaldTrump")
            //Example: tweetbot://lil_algo/user_profile/lil_algo
            UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
            print("Tweetbot App")
        }
            
        else if (UIApplication.shared.canOpenURL(NSURL(string: "twitter:///")! as URL)){
            let url = NSURL(string: "twitter:///user?screen_name=realDonaldTrump")
            //Example: twitter:///user?screen_name=lil_algo
            UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
            print("Twitter App")
        }
            
        else{
            let urlVC = UIStoryboard(name: self.tool.sbName(), bundle: nil).instantiateViewController(withIdentifier: "urlWebview") as! urlWeb
            urlVC.urlPass = "https://twitter.com/realDonaldTrump"
        
            self.navigationController?.pushViewController(urlVC, animated: true)
        }
        
        
    }
    
    @IBAction func facebook(_ sender: Any) {
        //Facebook
        print("executive - facebook")
        
        if (UIApplication.shared.canOpenURL(NSURL(string: "fb://")! as URL)){
            let url = NSURL(string: "fb://profile/1220332944702810")
            //Example: fb://profile/130323453724097
            UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
            print("Facebook App")
        }
        else{
            let urlVC = UIStoryboard(name: self.tool.sbName(), bundle: nil).instantiateViewController(withIdentifier: "urlWebview") as! urlWeb
            urlVC.urlPass = "https://www.facebook.com/DonaldTrump/"
        
            self.navigationController?.pushViewController(urlVC, animated: true)
        }
    }
    
    @IBAction func opensecret(_ sender: Any) {
        //Opensecret
        print("executive - opensecret")
        
        let urlVC = UIStoryboard(name: self.tool.sbName(), bundle: nil).instantiateViewController(withIdentifier: "urlWebview") as! urlWeb
        urlVC.urlPass = "https://www.opensecrets.org/pres16/candidate.php?id=N00023864"
        
        self.navigationController?.pushViewController(urlVC, animated: true)
    }
    
    @IBAction func votesmart(_ sender: Any) {
        //Votesmart
        print("executive - votesmart")
        
        let urlVC = UIStoryboard(name: self.tool.sbName(), bundle: nil).instantiateViewController(withIdentifier: "urlWebview") as! urlWeb
        urlVC.urlPass = "https://votesmart.org/candidate/biography/15723/donald-trump"
        
        self.navigationController?.pushViewController(urlVC, animated: true)
    }
    
    @IBAction func cspan(_ sender: Any) {
        //C-SPAN
        print("executive - cspan")
        
        let urlVC = UIStoryboard(name: self.tool.sbName(), bundle: nil).instantiateViewController(withIdentifier: "urlWebview") as! urlWeb
        urlVC.urlPass = "https://www.c-span.org/person/?donaldtrump"
        
        self.navigationController?.pushViewController(urlVC, animated: true)
    }
    
    @IBAction func executive(_ sender: Any) {
        //Executive Orders
        print("executive - executive orders")

        let vc = UIStoryboard(name: self.tool.sbName(), bundle: nil).instantiateViewController(withIdentifier: "executiveOrderTable") as! executiveOrders
        self.navigationController?.pushViewController(vc, animated: true)
  
    }
    
    @IBAction func signedLegislation(_ sender: Any) {
        //Signed legislation
        print("executive - signedLegislation")
        
        let vc = UIStoryboard(name: self.tool.sbName(), bundle: nil).instantiateViewController(withIdentifier: "signedLegislationTable") as! signedLegislations
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
