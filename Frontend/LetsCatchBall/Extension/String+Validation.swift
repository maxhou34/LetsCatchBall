//
//  String + Validation.swift
//  LetsKGB
//
//  Created by Chun on 2023/9/27.
//

import Foundation

extension String {
  
  func invalidEmail(_ value: String) -> String? {
    let emailRegex = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
    if !predicate.evaluate(with: value) {
      return NSLocalizedString("The Email Format Is Not Valid", comment: "")
    }
    
    return nil
  }
  
  func invalidPassword(_ value: String) -> String? {
    if value.count < 8 || value.count > 12 {
      return NSLocalizedString("The Password Should Be 8 To 12 Characters Long", comment: "")
    }
    if containsDigit(value) {
      return NSLocalizedString("The Password Must Contain At Least 1 Digit", comment: "")
    }
    if containsLowerCase(value) {
      return NSLocalizedString("The Password Must Contain At Least 1 Lowercase Letter", comment: "")
    }
    if containsUpperCase(value) {
      return NSLocalizedString("The Password Must Contain At Least 1 Uppercase Letter", comment: "")
    }
    
    return nil
  }
  
  func containsDigit(_ value: String) -> Bool {
    let passwordRegex = ".*[0-9]+.*"
    let predicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
    return !predicate.evaluate(with: value)
  }
  
  func containsLowerCase(_ value: String) -> Bool {
    let passwordRegex = ".*[a-z]+.*"
    let predicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
    return !predicate.evaluate(with: value)
  }
  
  func containsUpperCase(_ value: String) -> Bool {
    let passwordRegex = ".*[A-Z]+.*"
    let predicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
    return !predicate.evaluate(with: value)
  }
}
