//
//  showDocument.swift
//  Tree of the USA
//
//  Created by x on 09/01/18.
//  Copyright © 2018 x. All rights reserved.
//

import UIKit

class showDocument: UIViewController, UIScrollViewDelegate{
    //Showing National Archive document through UIScrollView
    
    var image = UIImage()
    var imageName = ""

    @IBOutlet var documentView: UIScrollView!
    @IBOutlet var imageScroll: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        documentView.delegate = self
        
        if(imageName != ""){
            //Setups image and scrollview
            image = UIImage(named: imageName)!
            imageScroll.image = image
            
            documentView.minimumZoomScale = 1.0
            documentView.maximumZoomScale = 5.0
            documentView.contentSize = image.size
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageScroll
    }

}
