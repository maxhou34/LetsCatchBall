//
//  SignUpVC.swift
//  LetsKGB
//
//  Created by Chun on 2023/9/8.
//

import KRProgressHUD
import UIKit

class SignUpVC: UIViewController {
  @IBOutlet var accountTF: UITextField!
  
  @IBOutlet var passwordTF: UITextField!
  
  @IBOutlet var comfirmPasswordTF: UITextField!
  
  @IBOutlet var emailErrorLb: UILabel!
  
  @IBOutlet var passwordErrorLb: UILabel!
  
  @IBOutlet var comfirmPasswordErrorLb: UILabel!
  
  @IBOutlet var createBtn: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    accountTF.delegate = self
    passwordTF.delegate = self
    comfirmPasswordTF.delegate = self
    
    resetForm()
  }
  
  // MARK: - IBAction
  
  @IBAction func emailChange(_ sender: Any) {
    if let email = accountTF.text {
      if let errorMessage = accountTF.text?.invalidEmail(email) {
        emailErrorLb.text = errorMessage
        emailErrorLb.isHidden = false
        checkForValidForm()
        return
      } else {
        Communicator.shared.checkAccount(email: email) { result, error in
          if let error = error {
            print("Check Account Fail: \(error)")
          }
          if let result = result {
            DispatchQueue.main.async {
              self.emailErrorLb.text = result.message
              self.checkForValidForm()
            }
          }
        }
      }
    }
  }
  
  @IBAction func passwordChange(_ sender: Any) {
    if let password = passwordTF.text {
      if let errorMessage = passwordTF.text?.invalidPassword(password) {
        passwordErrorLb.text = errorMessage
        passwordErrorLb.isHidden = false
      } else {
        passwordErrorLb.isHidden = true
      }
    }
    checkForValidForm()
  }
  
  @IBAction func comfirmPasswordChange(_ sender: Any) {
    if let errorMessage = checkPassword(passwordTF, comfirmPasswordTF) {
      comfirmPasswordErrorLb.text = errorMessage
      comfirmPasswordErrorLb.isHidden = false
    } else {
      comfirmPasswordErrorLb.isHidden = true
    }
    checkForValidForm()
  }
  
  @IBAction func createAccountBtnPressed(_ sender: Any) {
    resetForm()
    KRProgressHUD.show()
    if let account = accountTF.text,
       let password = passwordTF.text
    {
      Communicator.shared.signUp(email: account, password: password) { result, error in
        defer {
          DispatchQueue.main.async {
            KRProgressHUD.dismiss()
          }
        }
        if let error = error {
          print("Create Account Fail: \(error)")
          return
        }
        if let result = result {
          print(result)
          if result.code == "201" {
            UserDefaults.standard.set(result.userID, forKey: "User")
            self.navigationController?.dismiss(animated: true)
          }
        }
      }
    }
    
    accountTF.text = ""
    passwordTF.text = ""
    comfirmPasswordTF.text = ""
  }
  
  // MARK: - Other Method
  
  func resetForm() {
    createBtn.isEnabled = false
    
    emailErrorLb.isHidden = false
    passwordErrorLb.isHidden = false
    comfirmPasswordErrorLb.isHidden = false
    
    emailErrorLb.text = NSLocalizedString("Required", comment: "")
    passwordErrorLb.text = NSLocalizedString("Required", comment: "")
    comfirmPasswordErrorLb.text = NSLocalizedString("Confirm Password", comment: "")
  }
  
  func checkForValidForm() {
    if emailErrorLb.text == "This Email Is Available" && passwordErrorLb.isHidden && comfirmPasswordErrorLb.isHidden {
      createBtn.isEnabled = true
    } else {
      createBtn.isEnabled = false
    }
  }
  
  func checkPassword(_ textFieldA: UITextField, _ textFieldB: UITextField) -> String? {
    guard let textA = textFieldA.text,
          let textB = textFieldB.text
    else {
      return nil
    }
    if textB != textA {
      return NSLocalizedString("Password Confirmation Does Not Match, Please Reconfirm", comment: "")
    }
    return nil
  }
}
