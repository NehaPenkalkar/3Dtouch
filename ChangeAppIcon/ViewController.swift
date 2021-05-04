//
//  ViewController.swift
//  ChangeAppIcon
//
//  Created by Neha Penkalkar on 14/04/21.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func gameTap(_ sender: UIButton) {
        changeIcon(to: "Game")
    }
    
    @IBAction func appStoreTap(_ sender: UIButton) {
        changeIcon(to: "AppStore")
    }
    
    @IBAction func spaceTap(_ sender: UIButton) {
        changeIcon(to: "appicon")
    }
    
    func changeIcon(to iconName: String) {
        // 1
        guard UIApplication.shared.supportsAlternateIcons else {
            return
        }
        // 2
        UIApplication.shared.setAlternateIconName(iconName, completionHandler: { (error) in
            // 3
            if let error = error {
                print("App icon failed to change due to \(error.localizedDescription)")
            } else {
                print("App icon changed successfully")
            }
        })
    }
}

