//
//  MainAuthVC.swift
//  LetsKGB
//
//  Created by Chun on 2023/10/3.
//

import UIKit

class MainAuthVC: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    guard let activityVC = self.storyboard?.instantiateViewController(withIdentifier: "ActivityVC") as? ActivityVC else {
      assertionFailure("To ActivityVC Fail")
      return
    }
    if UserDefaults.standard.string(forKey: "User") != nil {
      let navigaActivityVC = UINavigationController(rootViewController: activityVC)
      navigaActivityVC.modalPresentationStyle = .fullScreen
      self.present(navigaActivityVC, animated: false)
    } else {
      guard let signInVC = self.storyboard?.instantiateViewController(withIdentifier: "SignInVC") as? SignInVC else {
        assertionFailure("To SignInVC Fail")
        return
      }
      let navigaActivityVC = UINavigationController(rootViewController: activityVC)
      let navigaSignInVC = UINavigationController(rootViewController: signInVC)
      navigaActivityVC.modalPresentationStyle = .fullScreen
      navigaSignInVC.modalPresentationStyle = .fullScreen
      self.present(navigaActivityVC, animated: false) {
        navigaActivityVC.present(navigaSignInVC, animated: false)
      }
    }
  }
}
