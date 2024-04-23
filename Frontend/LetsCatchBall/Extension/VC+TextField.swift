//
//  SignUpVC+TextField.swift
//  LetsKGB
//
//  Created by Chun on 2023/9/11.
//

import Foundation
import UIKit

extension SignInVC: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    guard let text = textField.text,
          !text.isEmpty else {
      return false
    }
    switch textField {
    case accountTF:
      passwordTF.isEnabled = true
      passwordTF.becomeFirstResponder()
    default:
      break
    }
    return true
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
  }
}

extension SignUpVC: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    guard let text = textField.text,
          !text.isEmpty else {
      return false
    }
    switch textField {
    case accountTF:
      passwordTF.isEnabled = true
      passwordTF.becomeFirstResponder()
    case passwordTF:
      comfirmPasswordTF.isEnabled = true
      comfirmPasswordTF.becomeFirstResponder()
    default:
      break
    }
    return true
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
  }
  
}

extension AddActivityVC: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    guard let text = textField.text,
          !text.isEmpty else {
      return false
    }
    switch textField {
    case activityTitleTF:
      activityTimeTF.isEnabled = true
      activityTimeTF.becomeFirstResponder()
    case activityTimeTF:
      self.activityTimeTF.text = self.dateFormat.string(from: self.datePicker.date)
      activityLocationTF.isEnabled = true
      activityLocationTF.becomeFirstResponder()
    case activityLocationTF:
      activitySpendTF.isEnabled = true
      activitySpendTF.becomeFirstResponder()
    case activitySpendTF:
      activityInformationTF.isEnabled = true
      activityInformationTF.becomeFirstResponder()
    case activityInformationTF:
      addActivityBtn.isEnabled = true
      activityInformationTF.resignFirstResponder()
    default:
      break
    }
    return true
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
  }
}
