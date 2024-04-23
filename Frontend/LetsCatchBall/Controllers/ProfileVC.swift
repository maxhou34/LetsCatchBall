//
//  ProfileVC.swift
//  LetsKGB
//
//  Created by Chun on 2023/9/4.
//

import UIKit

class ProfileVC: UIViewController {
  @IBOutlet var signOutBtn: UIButton!
  @IBOutlet var deleteBtn: UIButton!
  
  @IBOutlet var userAccountLb: UILabel!
  @IBOutlet var accountLb: UILabel!
  
  var user: UserModel?

  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.userAccountLb.text = NSLocalizedString("Account:", comment: "")
    
    Communicator.shared.getUser { result, error in
      if let error = error {
        print("Get User Fail: \(error)")
      }
      if let result = result,
         let datas = result.data
      {
        for data in datas {
          self.user = UserModel(account: data.account)
        }
        print(self.user!)
      }
      DispatchQueue.main.async {
        self.accountLb.text = self.user?.account
      }
    }
  }

  @IBAction func signOutBtnPressed(_ sender: UIButton) {
    // 建立 UIAlertController 的 Alert 物件
    let alertController1 = UIAlertController(title: NSLocalizedString("Warning!", comment: ""), message: NSLocalizedString("Are You Sure You Want To Sign Out?", comment: ""), preferredStyle: .alert)
        
    // 定義警告選項與動作
    let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel) { _ in
      print("按了Cancel")
    }
    let deleteAction = UIAlertAction(title: NSLocalizedString("SignOut", comment: ""), style: .destructive) { _ in
      print("按了SignOut")
      if let appDomain = Bundle.main.bundleIdentifier {
        UserDefaults.standard.removePersistentDomain(forName: appDomain)
      }
      self.navigationController?.dismiss(animated: false)
    }
        
    // 把警告選項加入 UIAlertController 物件中
    alertController1.addAction(cancelAction)
    alertController1.addAction(deleteAction)
        
    // 把 UIAlertController 呈現在當前 UIViewController 之上
    self.present(alertController1, animated: true, completion: {
      print("跳出警告了")
    })
  }

  @IBAction func deleteBtnPressed(_ sender: UIButton) {
    // 建立 UIAlertController 的 Alert 物件
    let alertController1 = UIAlertController(title: NSLocalizedString("Warning!", comment: ""), message: NSLocalizedString("Are You Sure You Want To Delete Your Account?", comment: ""), preferredStyle: .alert)
        
    // 定義警告選項與動作
    let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel) { _ in
      print("按了Cancel")
    }
    let deleteAction = UIAlertAction(title: NSLocalizedString("Delete", comment: ""), style: .destructive) { _ in
      print("按了Delete")
      Communicator.shared.deleteUser { result, error in
        if let error = error {
          print("Delete User Fail: \(error)")
        }
        if let result = result {
          print(result)
        }
        if let appDomain = Bundle.main.bundleIdentifier {
          UserDefaults.standard.removePersistentDomain(forName: appDomain)
        }
        self.navigationController?.dismiss(animated: false)
      }
    }
        
    // 把警告選項加入 UIAlertController 物件中
    alertController1.addAction(cancelAction)
    alertController1.addAction(deleteAction)
        
    // 把 UIAlertController 呈現在當前 UIViewController 之上
    self.present(alertController1, animated: true, completion: {
      print("跳出警告了")
    })
  }
}
