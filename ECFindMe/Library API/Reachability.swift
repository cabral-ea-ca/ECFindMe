//
//  Reachability.swift
//  ECFindMe
//
//  Created by Ryerson Student on 2018-06-03.
//  Copyright © 2018 Ryerson Student. All rights reserved.
//

import SystemConfiguration

public class Reachability {
    
    class func isConnectedToNetwork() -> (Bool, Bool) {
        var retisReachable:Bool = false
        var retisCellData:Bool = false
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == true {
            /* Only Working for WIFI
             let isReachable = flags == .reachable
             let needsConnection = flags == .connectionRequired
             
             return isReachable && !needsConnection
             */
            
            /* Working for Cellular and WIFI
             let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
             let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0

             return isReachable && !needsConnection
             */
            retisReachable = (flags.contains(.reachable) && !flags.contains(.connectionRequired))
            retisCellData  = flags.contains(.isWWAN)
        }
        
        return (retisReachable, retisCellData)
    }
}

