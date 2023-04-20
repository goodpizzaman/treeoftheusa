//
//  scotusProfile.swift
//  Tree of the USA
//
//  Created by x on 09/01/18.
//  Copyright © 2018 x. All rights reserved.
//

import UIKit
import DeviceKit

class scotusProfile: UIViewController {
    //Supreme court justice profile
    
    @IBOutlet var picture: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    
    var name = ""
    var bio = ""
    var cspan = ""
    var pictureName = ""
    let community = "Supreme Court"
    
    var tool = tools()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let yourBackImage = UIImage(named: "backButton")
        self.navigationController?.navigationBar.backIndicatorImage = yourBackImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = yourBackImage

        //Setup name
        nameLabel.text = name
        
        //Setup picture
        picture.image = UIImage.init(named: pictureName)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func bio(_ sender: Any) {
        //bio
        let bioVC = UIStoryboard(name: self.tool.sbName(), bundle: nil).instantiateViewController(withIdentifier: "scotusBio") as! scotusBio
        bioVC.bio = bio
        
        self.navigationController?.pushViewController(bioVC, animated: true)
    }
    
    @IBAction func oralArguments(_ sender: Any) {
        //oral arguments
        let urlVC = UIStoryboard(name: self.tool.sbName(), bundle: nil).instantiateViewController(withIdentifier: "urlWebview") as! urlWeb
        urlVC.urlPass = "https://www.supremecourt.gov/oral_arguments/oral_arguments.aspx"
        
        self.navigationController?.pushViewController(urlVC, animated: true)
    }

    @IBAction func speeches(_ sender: Any) {
        //speeches
        let urlVC = UIStoryboard(name: self.tool.sbName(), bundle: nil).instantiateViewController(withIdentifier: "urlWebview") as! urlWeb
        urlVC.urlPass = "https://www.supremecourt.gov/publicinfo/speeches/speeches.aspx"
        
        self.navigationController?.pushViewController(urlVC, animated: true)
    }
    
    @IBAction func termOpinion(_ sender: Any) {
        //term opinions
        let urlVC = UIStoryboard(name: self.tool.sbName(), bundle: nil).instantiateViewController(withIdentifier: "urlWebview") as! urlWeb
        urlVC.urlPass = "https://www.supremecourt.gov/opinions/opinions.aspx"
        
        self.navigationController?.pushViewController(urlVC, animated: true)
    }
    
    @IBAction func cspan(_ sender: Any) {
        //C-SPAN
        let urlVC = UIStoryboard(name: self.tool.sbName(), bundle: nil).instantiateViewController(withIdentifier: "urlWebview") as! urlWeb
        urlVC.urlPass = cspan
        
        self.navigationController?.pushViewController(urlVC, animated: true)
    }
   
}
