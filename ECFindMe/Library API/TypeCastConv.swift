//
//  TypeCastConv.swift
//  ECFindMe
//
//  Created by Ryerson Student on 2018-06-03.
//  Copyright © 2018 Ryerson Student. All rights reserved.
//

import UIKit
import CoreLocation

extension CLDeviceOrientation {
    var uiInterfaceOrientation: UIInterfaceOrientation {
        get {
            switch self {
            case .landscapeLeft:        return .landscapeRight
            case .landscapeRight:       return .landscapeLeft
            case .portrait:             return .portrait
            case .portraitUpsideDown:   return .portraitUpsideDown
            default:                    return .unknown
            }
        }
    }
    
    init(ui:UIInterfaceOrientation) {
        switch ui {
        case .landscapeRight:       self = .landscapeLeft
        case .landscapeLeft:        self = .landscapeRight
        case .portrait:             self = .portrait
        case .portraitUpsideDown:   self = .portraitUpsideDown
        default:                    self = .unknown
        }
    }
}

extension UIInterfaceOrientationMask {
    var uiInterfaceOrientation: UIInterfaceOrientation {
        get {
            switch self {
            case .landscapeLeft:        return .landscapeRight
            case .landscapeRight:       return .landscapeLeft
            case .portrait:             return .portrait
            case .portraitUpsideDown:   return .portraitUpsideDown
            default:
                return .unknown
            }
        }
    }
    
    init(ui:UIInterfaceOrientation) {
        switch ui {
        case .landscapeRight:       self = .landscapeLeft
        case .landscapeLeft:        self = .landscapeRight
        case .portrait:             self = .portrait
        case .portraitUpsideDown:   self = .portraitUpsideDown
        default:
            self = .all
        }
    }
}
