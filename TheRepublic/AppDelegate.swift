//
//  AppDelegate.swift
//  
//
//  Created by x on 09/01/18.
//  Copyright © 2018 x. All rights reserved.
//.

import UIKit
import DeviceKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //Picks storyboard needed for user device
        let sb = selectSB()
        self.window?.rootViewController = sb.instantiateInitialViewController()
        self.window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func selectSB() -> UIStoryboard{
        //Selects storyboard for which device
        
        print("Selecting Storyboard")
        var sb = UIStoryboard()
        let height = UIScreen.main.bounds.height
        print("Height: \(height)")
        
        let device = Device()
        
        print("Device: \(device)")     // prints, for example, "iPhone 6 Plus"
        
        if device == .iPhone5s || device == .simulator(.iPhone5s) || device == .iPhoneSE || device == .simulator(.iPhoneSE){
            print("User has iPhone SE or 5S")
            sb = UIStoryboard(name: "iPhone SE", bundle: nil)
        }
        else if device == .iPhone6Plus || device == .simulator(.iPhone6Plus) || device == .iPhone6sPlus  || device == .simulator(.iPhone6sPlus) || device == .iPhone7Plus  || device == .simulator(.iPhone7Plus)  || device == .iPhone8Plus  || device == .simulator(.iPhone8Plus) {
            print("User has iPhone Plus phone")
            sb = UIStoryboard(name: "iPhone 8 Plus", bundle: nil)
        }
        else if device == .iPhone6 || device == .simulator(.iPhone6) || device == .iPhone6s  || device == .simulator(.iPhone6s) || device == .iPhone7  || device == .simulator(.iPhone7)  || device == .iPhone8  || device == .simulator(.iPhone8) {
            print("User has iPhone 8 style phone")
            sb = UIStoryboard(name: "iPhone 8", bundle: nil)
        }
        else if device == .iPhoneX || device == .simulator(.iPhoneX) || device == .iPhoneXs || device == .simulator(.iPhoneXs){
            print("User has iPhone X or XS")
            sb = UIStoryboard(name: "iPhone X", bundle: nil)
        }
        else if device == .iPhoneXr || device == .simulator(.iPhoneXr) {
            print("User has iPhone XR")
            sb = UIStoryboard(name: "iPhone XR", bundle: nil)
        }
        else if device == .iPhoneXsMax || device == .simulator(.iPhoneXsMax){
            print("User has iPhoneXS Max")
            sb = UIStoryboard(name: "iPhone XS Max", bundle: nil)
        }
        else{
            //iPad, etc.
            sb = UIStoryboard(name: "iPhone 8", bundle: nil)
        }
        
        return sb
    }


}

