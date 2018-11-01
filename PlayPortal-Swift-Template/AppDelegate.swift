//
//  AppDelegate.swift
//  PlayPortal-Swift-Template
//
//  Created by Lincoln Fraley on 10/31/18.
//  Copyright © 2018 Dynepic, Inc. All rights reserved.
//

import UIKit
import PPSDK_Swift

//  Configuration for your app
let clientId = "your-client-id"
let clientSecret = "your-client-secret"
//  The redirect uri must be addded as a url scheme in your info.plist
let redirect = "your-redirect://"
let env = PlayPortalEnvironment.sandbox

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, PlayPortalLoginDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        PlayPortalAuth.shared.configure(forEnvironment: env, withClientId: clientId, andClientSecret: clientSecret, andRedirectURI: redirect)
        authenticate()
        
        return true
    }
    
    //  Start SSO flow by checking if user is authenticated; if not, open login
    func authenticate() {
        PlayPortalAuth.shared.isAuthenticated(loginDelegate: self) { [weak self] error, userProfile in
            guard let self = self else { return }
            if let userProfile = userProfile {
                //  User is authenticated, go to initial
                guard let nav = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "navigation") as? UINavigationController
                    , let initial = nav.viewControllers[0] as? InitialViewController
                    else {
                        return
                }
                
                initial.userProfile = userProfile
                
                self.window?.rootViewController = nav
            } else if let error = error {
                print("Error during authentication: \(error)")
            } else {
                //  Not authenticated, open login view controller
                print("User not authenticated, go to login")
                guard let login = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "login") as? LoginViewController else {
                    return
                }
                self.window?.rootViewController = login
            }
        }
    }
    
    //  This method must be implemented so the sdk can handle redirects from playPORTAL SSO
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        PlayPortalAuth.shared.open(url: url)
        return true
    }
    
    func didFailToLogin(with error: Error) {
        print("Login failed during SSO flow: \(error)")
    }
    
    func didLogout(with error: Error) {
        print("Error occurred during logout: \(error)")
    }
    
    func didLogoutSuccessfully() {
        print("Logged out successfully!")
        authenticate()
    }
}
