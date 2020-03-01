//
//  validation.swift
//  -1819 Mobile
//
//  Created by Chris Holschuh on 2/13/20.
//  Copyright © 2020 Chris Holschuh. All rights reserved.
//

import Foundation

class validationHelper {
    
   class func isEmailVaild(emailAddress: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailValidation = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailValidation.evaluate(with: emailAddress)
    }
    
}
