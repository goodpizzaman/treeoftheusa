//
//  tools.swift
//  Tree of the USA
//
//  Created by x on 09/01/18.
//  Copyright © 2018 x. All rights reserved.
//

import Foundation
import UIKit
import DeviceKit

class tools: UIViewController {
    //funcs that are repeatedly used throughout the app
    
    var appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //🛠Use tools everywhere

    func sbName() -> String{
        //Picks correct Storyboard name
        var sbName = ""
        let heightScreen = UIScreen.main.bounds.size.height
        print("heightScreen - appDel: \(heightScreen)")
        
        let device = Device()
        
        print("Device: \(device)")     // prints, for example, "iPhone 6 Plus"
        
        if device == .iPhone5s || device == .simulator(.iPhone5s) || device == .iPhoneSE || device == .simulator(.iPhoneSE){
            sbName = "iPhone SE"
        }
        else if device == .iPhone6Plus || device == .simulator(.iPhone6Plus) || device == .iPhone6sPlus  || device == .simulator(.iPhone6sPlus) || device == .iPhone7Plus  || device == .simulator(.iPhone7Plus)  || device == .iPhone8Plus  || device == .simulator(.iPhone8Plus) {
            sbName = "iPhone 8 Plus"
        }
        else if device == .iPhone6 || device == .simulator(.iPhone6) || device == .iPhone6s  || device == .simulator(.iPhone6s) || device == .iPhone7  || device == .simulator(.iPhone7)  || device == .iPhone8  || device == .simulator(.iPhone8) {
            sbName = "iPhone 8"
        }
        else if device == .iPhoneX || device == .simulator(.iPhoneX) || device == .iPhoneXs || device == .simulator(.iPhoneXs){
            sbName = "iPhone X"
        }
        else if device == .iPhoneXr || device == .simulator(.iPhoneXr) {
            print("User has iPhone XR")
            sbName = "iPhone XR"
        }
        else if device == .iPhoneXsMax || device == .simulator(.iPhoneXsMax){
            sbName = "iPhone XS Max"
        }
        else{
            sbName = "iPhone 8"
        }
        
        return sbName
        
    }
    
    func hexColor(_ hexColorString: String) -> UIColor{
        //Converts hex color string to UIColor
        
        //print("🌈hexColorString: \(hexColorString)")
        //Change color of nav bar and tab bar based on channel
        func intFromHexString(_ hexStr: String) -> UInt32 {
            var hexInt: UInt32 = 0
            // Create scanner
            let scanner: Scanner = Scanner(string: hexStr)
            // Tell scanner to skip the # character
            scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
            // Scan hex value
            scanner.scanHexInt32(&hexInt)
            return hexInt
        }
        
        // Convert hex string to an integer
        let hexint = Int(intFromHexString(hexColorString))
        let red = CGFloat((hexint & 0xff0000) >> 16) / 255.0
        let green = CGFloat((hexint & 0xff00) >> 8) / 255.0
        let blue = CGFloat((hexint & 0xff) >> 0) / 255.0
        
        // Create color object, specifying alpha as well
        let color = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        return color
    }
    
}
