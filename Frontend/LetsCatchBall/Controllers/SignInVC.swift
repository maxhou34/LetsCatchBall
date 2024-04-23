//
//  SignInVC.swift
//  LetsKGB
//
//  Created by Chun on 2023/9/25.
//

import UIKit
import KRProgressHUD

class SignInVC: UIViewController {

  @IBOutlet weak var accountTF: UITextField!
  @IBOutlet weak var passwordTF: UITextField!
  
  
  @IBOutlet weak var accountErrorLb: UILabel!
  @IBOutlet weak var passwordErrorLb: UILabel!
  
  @IBOutlet weak var signInErrorLb: UILabel!
  
  @IBOutlet weak var signInBtn: UIButton!
  @IBOutlet weak var signUpBtn: UIButton!
  
  override func viewDidLoad() {
        super.viewDidLoad()
    accountTF.delegate = self
    passwordTF.delegate = self
    signInErrorLb.isHidden = true
    
    resetFrom()
    }
    
  
  // MARK: - IBAction
  
  @IBAction func accountChange(_ sender: Any) {
    if let email = accountTF.text {
      if let errorMessage = accountTF.text?.invalidEmail(email) {
        accountErrorLb.text = errorMessage
        accountErrorLb.isHidden = false
      } else {
        accountErrorLb.isHidden = true
      }
    }
    checkForVaildForm()
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
    checkForVaildForm()
  }
  
  
  @IBAction func signInBtnPressed(_ sender: UIButton) {
    resetFrom()
    KRProgressHUD.show()
    if let account = accountTF.text,
       let password = passwordTF.text {
      Communicator.shared.signIn(email: account, password: password) { result, error in
        defer {
          DispatchQueue.main.async {
            KRProgressHUD.dismiss()
          }
        }
        if let error = error {
          print("Sign In Fail: \(error)")
          return
        }
        if let result = result {
          print(result)
          if result.code == "200" {
            UserDefaults.standard.set(result.userID, forKey: "User")
            self.navigationController?.dismiss(animated: true)
          } else {
            self.signInErrorLb.isHidden = false
            DispatchQueue.main.async {
              self.signInErrorLb.text = result.message
            }
          }
        }
      }
    }
    
    accountTF.text = ""
    passwordTF.text = ""
  }
  
  @IBAction func signUpBtnPressed(_ sender: UIButton) {
    guard let signUpVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpVC") as? SignUpVC else {
      assertionFailure("To SignUpVC Fail")
      return
    }
    self.navigationController?.pushViewController(signUpVC, animated: true)
  }
  
  
  // MARK: - Other Method
  
  func resetFrom() {
    signInBtn.isEnabled = false
    
    accountErrorLb.isHidden = false
    passwordErrorLb.isHidden = false
    
    accountErrorLb.text = NSLocalizedString("Required", comment: "")
    passwordErrorLb.text = NSLocalizedString("Required", comment: "")
  }
  
  func checkForVaildForm() {
    if accountErrorLb.isHidden && passwordErrorLb.isHidden {
      signInBtn.isEnabled = true
    } else {
      signInBtn.isEnabled = false
    }
  }
  

}
