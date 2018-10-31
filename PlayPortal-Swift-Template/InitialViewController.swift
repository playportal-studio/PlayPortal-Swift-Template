//
//  InitialViewController.swift
//  PlayPortal-Swift-Template
//
//  Created by Lincoln Fraley on 10/31/18.
//  Copyright © 2018 Lincoln Fraley. All rights reserved.
//

import Foundation
import UIKit
import PPSDK_Swift

class InitialViewController: UIViewController {
    
    var userProfile: PlayPortalProfile!
    
    @IBAction func settingsTapped(_ sender: UIBarButtonItem) {
        guard let settings = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "settings") as? SettingsTableViewController else {
            return
        }
        navigationController?.pushViewController(settings, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
