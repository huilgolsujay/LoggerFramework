//
//  Logging.swift
//  LoggerFramework
//
//  Created by sujay huilgol on 9/15/17.
//  Copyright © 2017 sujay huilgol. All rights reserved.
//

import Foundation
import UIKit

public class Ylogging
{
    private var nametoLog : String!
    
    public init() {}
    
    public func setName ()
    {
        nametoLog = "sujay"
    }
    public func LogName()
    {
        print("name is \(nametoLog)")
    }
    
}
