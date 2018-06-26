//
//  LogViewNaviController.swift
//  ECFindMe
//
//  Created by Ryerson Student on 2018-06-08.
//  Copyright © 2018 Ryerson Student. All rights reserved.
//

import UIKit

class LogViewNaviController : UINavigationController{
    static func storyboardInstance() -> LogViewNaviController? {
        let storyboard: UIStoryboard? = UIStoryboard(name: "LogViewController", bundle: nil)
        var logViewNaviController: LogViewNaviController?
        if storyboard != nil{
            logViewNaviController = storyboard?.instantiateViewController(withIdentifier: className) as? LogViewNaviController
        }
        return logViewNaviController
    }
}
