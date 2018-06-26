//
//  LockUsage.swift
//  ECFindMe
//
//  Created by Ryerson Student on 2018-06-03.
//  Copyright © 2018 Ryerson Student. All rights reserved.
//

class CLockUsage{
    enum  LockType : Int {
        case kUnknown = -1
        case kLocked = 0
        case kUnlocked = 1
    }
    
    internal var lockUsageType:LockType = .kUnlocked ;
    internal var typeStringTable = [
        "Locked" ,
        "Unlocked"
        ]
    
    var lockUsageDesc : String {
        get { return typeStringTable[lockUsageType.rawValue] }
    }
    
    internal func lockUsageForLock(){
        let OldValue = lockUsageType
        lockUsageType = .kLocked
        print( "CLockUsage: lockUsageForLock called \(OldValue) -> \(lockUsageType)"  )
    }
    
    internal func lockUsageForUnlock(){
        let OldValue = lockUsageType
        lockUsageType = .kUnlocked
        print( "CLockUsage: lockUsageForUnlock called \(OldValue) -> \(lockUsageType)"  )
    }

    func switchLock(){
        print( "CLockUsage: switchLock called" )
        switch lockUsageType {
        case .kUnknown:     print( "What happened???" )
        case .kLocked:      lockUsageForUnlock()
        case .kUnlocked:    lockUsageForLock()
        }

    }
}
