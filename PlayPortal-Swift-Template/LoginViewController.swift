//
//  LoginViewController.swift
//  PlayPortal-Swift-Template
//
//  Created by Lincoln Fraley on 10/31/18.
//  Copyright © 2018 Dynepic, Inc. All rights reserved.
//

import Foundation
import UIKit
import PPSDK_Swift

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //  Add login button to handle SSO flow
        let loginButton = PlayPortalLoginButton(from: self)
        loginButton.center = CGPoint(x: loginView.bounds.size.width / 2, y: loginView.bounds.size.height / 2)
        loginView.addSubview(loginButton)
    }
}
