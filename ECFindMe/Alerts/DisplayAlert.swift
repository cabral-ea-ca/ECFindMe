//
//  DisplayAlert.swift
//  ECFindMe
//
//  Created by Ryerson Student on 2018-06-03.
//  Copyright © 2018 Ryerson Student. All rights reserved.
//

import UIKit

class DisplayAlert {
    internal var currentVC: UIViewController?
    
    internal func openURL( urlStr: URL){
        if #available(iOS 10.0, *){
            DispatchQueue.main.async {
                UIApplication.shared.open(urlStr, options: [:], completionHandler: nil )
            }
        }
        else{
            DispatchQueue.main.async {
                UIApplication.shared.openURL(urlStr)
            }
        }
    }
    
    internal func settingLocationHandler(alert: UIAlertAction!) {
        let urlStr = URL( string: "App-Prefs:root=Privacy&path=LOCATION"  )
        openURL( urlStr: urlStr! )
        justClose(alert: alert)
    }
    
    internal func settingNetworkHandler(alert: UIAlertAction!) {
        let urlStr = URL( string: "App-Prefs:root"  )
        openURL( urlStr: urlStr! )
        justClose(alert: alert)
    }
    
    internal func delAllLocationItemsHandler(alert: UIAlertAction!) {
        AppDelegate.dataBase.delLocationItems()
        let viewController = currentVC as? LogViewController
        viewController?.initAllItems()
        justClose(alert: alert)
    }
    
    internal func justClose(alert: UIAlertAction!){
        currentVC = nil
        AppDelegate.displayAlert = nil
    }
    
    public func showAlertNetwork( title:String, message:String, viewController : UIViewController){
        print( "DisplayAlert: showAlertNetwork called" )
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: NSLocalizedString("Settings", comment: "Setting action"), style: .cancel, handler: settingNetworkHandler))
        alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default"), style: .default, handler: justClose ))
        currentVC = viewController
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    public func showAlertLocation(title :String, message : String, viewController : UIViewController){
        print( "DisplayAlert: showAlertLocation called" )
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: NSLocalizedString("Settings", comment: "Setting action"), style: .cancel, handler: settingLocationHandler))
        alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default"), style: .default, handler: justClose ))
        currentVC = viewController
        viewController.present(alertController, animated: true, completion: nil)
    }

    public func showDelAllLocationItems(title :String, message : String, viewController : UIViewController){
        print( "DisplayAlert: showDelAllLocationItems called" )
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: NSLocalizedString("Yes", comment: "Yes action"), style: .cancel, handler: delAllLocationItemsHandler))
        alertController.addAction(UIAlertAction(title: NSLocalizedString("No", comment: "No action"), style: .default, handler: justClose ))
        currentVC = viewController
        viewController.present(alertController, animated: true, completion: nil)
    }
}
