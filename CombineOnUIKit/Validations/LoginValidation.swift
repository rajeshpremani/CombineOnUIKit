//
//  LoginValidation.swift
//  CombineOnUIKit
//
//  Created by Rajesh Kumar Sahil on 13/08/2022.
//

import Foundation

struct LoginValidation {
    static func validation(loginRequest: LoginRequest) -> ValidationResult{
        if loginRequest.username.isEmpty || loginRequest.password.isEmpty{
            return ValidationResult(success: false, validationError: "username or password cannot be empty.")
        }
        return ValidationResult(success: false, validationError: nil)
    }
}
