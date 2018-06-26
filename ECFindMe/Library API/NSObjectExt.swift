//
//  NSObjectExt.swift
//  ECFindMe
//
//  Created by Ryerson Student on 2018-06-08.
//  Copyright © 2018 Ryerson Student. All rights reserved.
//

import UIKit

extension NSObject{
    var className: String {
        //return String(describing: type(of: self))
        return String("\(self)")
    }
    
    class var className: String {
        //return String(describing: self)
        return String("\(self)")
    }
}
