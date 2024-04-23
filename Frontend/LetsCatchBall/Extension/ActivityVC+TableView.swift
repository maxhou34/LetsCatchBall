//
//  ActivityVC+TableView.swift
//  LetsKGB
//
//  Created by Chun on 2023/10/3.
//

import Foundation
import UIKit

extension ActivityVC: UITableViewDelegate, UITableViewDataSource {
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return activities.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "activityCell", for: indexPath) as? ActivityTableViewCell,
          let data = activities[indexPath.row] as? ActivityModel else {
      return UITableViewCell()
    }
    cell.activityTitleLb.text = NSLocalizedString("Title", comment: "")
    cell.titleLb.text = data.title
    cell.activityTimeLb.text = NSLocalizedString("Time", comment: "")
    cell.timeLb.text = data.time
    cell.activityLocationLb.text = NSLocalizedString("Location", comment: "")
    cell.locationLb.text = data.location
    cell.activitySpendLb.text = NSLocalizedString("Spend", comment: "")
    cell.spendLb.text = data.spend
    cell.activityInformationLb.text = NSLocalizedString("Information", comment: "")
    cell.informationLb.text = data.information
    
    return cell
  }
 
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 200
  }
  
}
