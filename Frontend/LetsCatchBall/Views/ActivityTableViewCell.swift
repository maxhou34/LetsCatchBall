//
//  ActivityTableViewCell.swift
//  LetsKGB
//
//  Created by Chun on 2023/10/11.
//

import UIKit

class ActivityTableViewCell: UITableViewCell {

  
  
  @IBOutlet weak var activityTitleLb: UILabel!
  
  @IBOutlet weak var titleLb: UILabel!
  
  @IBOutlet weak var activityTimeLb: UILabel!
  
  @IBOutlet weak var timeLb: UILabel!
  
  @IBOutlet weak var activityLocationLb: UILabel!
  
  @IBOutlet weak var locationLb: UILabel!
  
  @IBOutlet weak var activitySpendLb: UILabel!
  
  @IBOutlet weak var spendLb: UILabel!
  
  @IBOutlet weak var activityInformationLb: UILabel!
  
  @IBOutlet weak var informationLb: UILabel!
  
  
  
  
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
