//
//  Synchronized.swift
//  IPMExample-swift
//
//  Created by Pavel Gorb on 4/18/16.
//  Copyright © 2016 Virgil Security, Inc. All rights reserved.
//

import Foundation

func synchronized<T>(object: AnyObject, closure: () -> T) -> T {
    objc_sync_enter(object)
    let retVal: T = closure()
    objc_sync_exit(object)
    return retVal
}

func synchronized(object: AnyObject, closure: () -> ()) {
    objc_sync_enter(object)
    closure()
    objc_sync_exit(object)
}