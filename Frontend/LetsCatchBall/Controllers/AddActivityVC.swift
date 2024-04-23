//
//  AddActivityVC.swift
//  LetsKGB
//
//  Created by Chun on 2023/10/3.
//

import KRProgressHUD
import MapKit
import UIKit

class AddActivityVC: UIViewController {
  @IBOutlet var activityTitleTF: UITextField!
  @IBOutlet var activityTimeTF: UITextField!
  @IBOutlet var activityLocationTF: UITextField!
  @IBOutlet var activityLocationMV: MKMapView!
  @IBOutlet var activitySpendTF: UITextField!
  @IBOutlet var activityInformationTF: UITextField!
  
  @IBOutlet var activityTitleLb: UILabel!
  @IBOutlet var activityTimeLb: UILabel!
  @IBOutlet var activityLocationLb: UILabel!
  @IBOutlet var activitySpendLb: UILabel!
  @IBOutlet var activityInformationLb: UILabel!
  
  @IBOutlet var addActivityBtn: UIButton!
  
  let datePicker = UIDatePicker()
  let dateFormat = DateFormatter()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    activityTitleTF.delegate = self
    activityTimeTF.delegate = self
    activityLocationTF.delegate = self
    activitySpendTF.delegate = self
    activityInformationTF.delegate = self
    resetForm()
    datePicker.datePickerMode = .dateAndTime
    datePicker.locale = Locale(identifier: "zh-TW")
    activityTimeTF.inputView = datePicker
    dateFormat.dateFormat = "yyyy/MM/dd/hh/mm"
    datePicker.addAction(UIAction(handler: { _ in
      self.activityTimeTF.text = self.dateFormat.string(from: self.datePicker.date)
    }), for: .valueChanged)
    
    let toolbar = UIToolbar()
    toolbar.sizeToFit()
    let doneBTn = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneBtnTapped))
    toolbar.setItems([doneBTn], animated: false)
    activityTimeTF.inputAccessoryView = toolbar
  }
  
  // MARK: - IBAction
  
  @IBAction func titleChange(_ sender: Any) {}
  @IBAction func timeChange(_ sender: Any) {}
  @IBAction func locationChange(_ sender: Any) {
    if let query = activityLocationTF.text {
      LocationManger.shared.searchLocation(query: query, mapView: activityLocationMV) { response, error in
        if let error = error {
          print("Error: \(error)")
        } else if let response = response,
                  let firstMapItem = response.mapItems.first
        {
          let placemark = firstMapItem.placemark
          let coordinate = placemark.coordinate

          let annotation = MKPointAnnotation()
          annotation.coordinate = coordinate
          annotation.title = placemark.name

          print("searchLocation - Lat: \(coordinate.latitude), Lon: \(coordinate.longitude)")

          self.activityLocationMV.addAnnotation(annotation)

          let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
          self.activityLocationMV.setRegion(region, animated: true)
        } else {
          print("No results found")
        }
      }
    }
  }

  @IBAction func spendChange(_ sender: Any) {}
  @IBAction func informationChange(_ sender: Any) {}
  
  @IBAction func addActivityBtnPressed(_ sender: Any) {
    KRProgressHUD.show()
    if let title = activityTitleTF.text,
       let time = activityTimeTF.text,
       let location = activityLocationTF.text,
       let spend = activitySpendTF.text,
       let information = activityInformationTF.text
    {
      LocationManger.shared.getCoordinateFrom(address: location) { response, error in
        if let error = error {
          print("Error: \(error)")
        } else if let response = response,
                  let firstMapItem = response.mapItems.first
        {
          let placemark = firstMapItem.placemark
          let coordinate = placemark.coordinate
          print("searchLocation - Lat: \(coordinate.latitude), Lon: \(coordinate.longitude)")
          Communicator.shared.createActivity(title: title, time: time, location: location, latitude: coordinate.latitude, longitude: coordinate.longitude, spend: spend, information: information) { result, error in
            defer {
              DispatchQueue.main.async {
                KRProgressHUD.dismiss()
              }
            }
            if let error = error {
              print("Create Activity Fail: \(error)")
              return
            }
            if let result = result {
              print(result)
              if result.code == "201" {
                self.navigationController?.dismiss(animated: true)
              }
            }
          }
        }
      }
    }
    activityTitleTF.text = ""
    activityTimeTF.text = ""
    activityLocationTF.text = ""
    activitySpendTF.text = ""
    activityInformationTF.text = ""
  }
  
  // MARK: - OBJC Method
  
  @objc func doneBtnTapped() {
    activityTimeTF.text = dateFormat.string(from: datePicker.date)
    activityLocationTF.isEnabled = true
    activityLocationTF.becomeFirstResponder()
  }
  
  // MARK: - Other Method
  
  func resetForm() {
    addActivityBtn.isEnabled = false
    
    activityTimeTF.isEnabled = false
    activityLocationTF.isEnabled = false
    activitySpendTF.isEnabled = false
    activityInformationTF.isEnabled = false
    
    activityTitleLb.text = NSLocalizedString("Title", comment: "")
    activityTimeLb.text = NSLocalizedString("Time", comment: "")
    activityLocationLb.text = NSLocalizedString("Location", comment: "")
    activitySpendLb.text = NSLocalizedString("Spend", comment: "")
    activityInformationLb.text = NSLocalizedString("Information", comment: "")
  }
}
