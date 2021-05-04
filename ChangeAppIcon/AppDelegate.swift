//
//  AppDelegate.swift
//  ChangeAppIcon
//
//  Created by Neha Penkalkar on 14/04/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        updateQuickAction()
        return true
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("notification here")
        
    }
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        switch shortcutItem.type {
        case "IconPress":
            
            delay(1.0) {
                
                if let iconName = UIApplication.shared.alternateIconName , iconName == "icon_dark"{
                    self.changeIcon(to: nil)
                }else{
                    self.changeIcon(to: "icon_dark")
                }
                
            }
            
        case "SharePress":
            
            let text = "Checkout this App! It allows you to create and manage your own online shop, post and sell your products and start getting paid."
            let myWebsite = URL(string:"https://apps.apple.com/us/app/connects-ecommerce-website/id1516426561")
            let shareAll : [Any] = [text,myWebsite!]
            let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.window?.rootViewController?.view
            self.window?.rootViewController?.present(activityViewController, animated: true, completion: nil)
            
        default:
            break
        }
    }
    
    func delay(_ delay:Double, closure:@escaping ()->()) {
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
    }
    
    func changeIcon(to name: String?) {
        //Check if the app supports alternating icons
        guard UIApplication.shared.supportsAlternateIcons else {
            return;
        }
        
        
        //Change the icon to a specific image with given name
        UIApplication.shared.setAlternateIconName(name) { (error) in
            //After app icon changed, print our error or success message
            if let error = error {
                print("App icon failed to due to \(error.localizedDescription)")
            } else {
                print("App icon changed successfully.")
                self.updateQuickAction()
            }
        }
    }
    
    func updateQuickAction(){
        let application = UIApplication.shared
        
        var shortcut2 = UIMutableApplicationShortcutItem(type: "IconPress",
                                                         localizedTitle: "Update Icon to Dark Mode",
                                                         localizedSubtitle: "",
                                                         icon: UIApplicationShortcutIcon(type: .add),
                                                         userInfo: nil
        )
        
        if let iconName = UIApplication.shared.alternateIconName{
            if(iconName == "icon_dark"){
                shortcut2 = UIMutableApplicationShortcutItem(type: "IconPress",
                                                             localizedTitle: "Update Icon to Light Mode",
                                                             localizedSubtitle: "",
                                                             icon: UIApplicationShortcutIcon(type: .add),
                                                             userInfo: nil
                )
            }
        }else{
            //show dark set option
        }
        let shortcut3 = UIMutableApplicationShortcutItem(type: "SharePress",
                                                         localizedTitle: "Share App",
                                                         localizedSubtitle: "",
                                                         icon: UIApplicationShortcutIcon(type: .share),
                                                         userInfo: nil
        )
        application.shortcutItems = [shortcut3,shortcut2]
    }
    
    
}

