//
//  ActivityVC.swift
//  LetsKGB
//
//  Created by Chun on 2023/10/2.
//

import UIKit

class ActivityVC: UIViewController {
  @IBOutlet var activityTableView: UITableView!
  
  var activities = [ActivityModel]()
  
  let refreshControl = UIRefreshControl()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    activityTableView.dataSource = self
    activityTableView.delegate = self
    
    activityTableView.refreshControl = refreshControl
    
    refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    
    Communicator.shared.getActivity { result, error in
      if let error = error {
        print("Get Activity Fail: \(error)")
      }
      if let result = result,
         let datas = result.data
      {
        for data in datas {
          let activity = ActivityModel(title: data.title, time: data.time, location: data.location, spend: data.spend, information: data.information)
          self.activities.append(activity)
        }
        print(self.activities)
      }
      DispatchQueue.main.async {
        self.activityTableView.reloadData()
      }
    }
    
    activityTableView.reloadData()
  }
  
  @objc private func refresh() {
    activities.removeAll()
    // 在這個函數中更新你的數據
    Communicator.shared.getActivity { result, error in
      if let error = error {
        print("Get Activity Fail: \(error)")
      }
      if let result = result,
         let datas = result.data
      {
        for data in datas {
          let activity = ActivityModel(title: data.title, time: data.time, location: data.location, spend: data.spend, information: data.information)
          self.activities.append(activity)
        }
        print(self.activities)
      }
      DispatchQueue.main.async {
        self.activityTableView.reloadData()
      }
    }
    // 例如，你可以重新加載數據來源
    // self.loadData()
    // 重新加載 tableView 的數據
    // 停止刷新控制的動畫
    refreshControl.endRefreshing()
  }
  
  @IBAction func addActivityBtnPressed(_ sender: UIButton) {
    guard let addActivityVC = storyboard?.instantiateViewController(withIdentifier: "AddActivityVC") as? AddActivityVC else {
      assertionFailure("To AddActivityVC Fail")
      return
    }
    navigationController?.pushViewController(addActivityVC, animated: true)
  }
  
  @IBAction func toProfileBtnPressed(_ sender: UIButton) {
    guard let toProfileVC = storyboard?.instantiateViewController(withIdentifier: "ProfileVC") as? ProfileVC else {
      assertionFailure("To ProfileVC Fail")
      return
    }
    navigationController?.pushViewController(toProfileVC, animated: true)
  }
}
