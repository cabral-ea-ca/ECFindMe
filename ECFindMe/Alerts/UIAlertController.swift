//
//  UIAlertController.swift
//  ECFindMe
//
//  Created by Ryerson Student on 2018-06-03.
//  Copyright © 2018 Ryerson Student. All rights reserved.
//

import UIKit

extension UIAlertController{
    override open var shouldAutorotate: Bool {
        get {
            return super.shouldAutorotate
        }
    }
    
    override open var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
        get {
            return super.preferredInterfaceOrientationForPresentation
        }
    }
    
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        get {
            return super.supportedInterfaceOrientations
        }
    }
}
