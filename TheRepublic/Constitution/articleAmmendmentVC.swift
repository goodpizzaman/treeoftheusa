//
//  articleAmmendmentVC.swift
//  Tree of the USA
//
//  Created by x on 09/01/18.
//  Copyright © 2018 x. All rights reserved.
//

import UIKit
import DeviceKit

class articleAmmendmentVC: UIViewController {
    //Shows the user the text of the article or ammendment and have a button for the actual document from the National Archive.
    
    @IBOutlet var textView: UITextView!
    @IBOutlet var articleAmmendmentName: UILabel!
    
    var tool = tools()
    var name = ""
    var text = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Setups custom back button
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let yourBackImage = UIImage(named: "backButton")
        self.navigationController?.navigationBar.backIndicatorImage = yourBackImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
        
        //Setups @IBOutlet from above
        articleAmmendmentName.text = name
        textView.backgroundColor = UIColor.clear
        textView.text = text
        
        //Adds picture UIBarButtonItem for document from the National Archive and adds it to the right side of the navigation controller
        let addPictureButton = UIButton()
        addPictureButton.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        addPictureButton.setImage(UIImage(named: "documentx50@2x.png"), for: UIControlState())
        addPictureButton.addTarget(self, action: #selector(showPicture), for: .touchUpInside)
        let addPictureBarButton = UIBarButtonItem()
        addPictureBarButton.customView = addPictureButton
        self.navigationItem.rightBarButtonItems = [addPictureBarButton]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @objc func showPicture(){
        //Shows document from the National Archive
        let showDocument = UIStoryboard(name: self.tool.sbName(), bundle: nil).instantiateViewController(withIdentifier: "showDocument") as! showDocument
        showDocument.imageName = name
        
        self.navigationController?.pushViewController(showDocument, animated: true)
    }
    
}
