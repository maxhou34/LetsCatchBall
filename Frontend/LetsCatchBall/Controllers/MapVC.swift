//
//  MapVC.swift
//  LetsKGB
//
//  Created by Chun on 2023/7/27.
//

import CoreLocation
import MapKit
import UIKit

class MapVC: UIViewController {
  @IBOutlet var activityMV: MKMapView!

  @IBOutlet var addActivityBtn: UIButton!

  var locations = [ActivityModel]()

//  let locationManager = CLLocationManager()

  override func viewDidLoad() {
    super.viewDidLoad()
    self.activityMV.delegate = self

//    locationManager.delegate = self
//    locationManager.requestAlwaysAuthorization()
//    locationManager.desiredAccuracy = kCLLocationAccuracyBest
//    locationManager.activityType = .automotiveNavigation
//    locationManager.startUpdatingLocation()

    Communicator.shared.getActivity { result, error in
      if let error = error {
        print("Get Activity Fail: \(error)")
        return
      }
      if let result = result,
         let datas = result.data
      {
        for data in datas {
          let location = ActivityModel(title: data.title, location: data.location, latitude: data.latitude, longitude: data.longitude)
          self.locations.append(location)
        }
        print(self.locations)
      }
      DispatchQueue.main.async {
        for location in self.locations {
          let coordinate = CLLocationCoordinate2D(latitude: location.latitude ?? 0.0, longitude: location.longitude ?? 0.0)
          let annotation = MKPointAnnotation()
          annotation.coordinate = coordinate
          annotation.title = location.title
          annotation.subtitle = location.location
          self.activityMV.addAnnotation(annotation)
        }
      }
    }
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(true)
    Communicator.shared.getActivity { result, error in
      if let error = error {
        print("Get Activity Fail: \(error)")
        return
      }
      if let result = result,
         let datas = result.data
      {
        for data in datas {
          let location = ActivityModel(title: data.title, location: data.location, latitude: data.latitude, longitude: data.longitude)
          self.locations.append(location)
        }
        print(self.locations)
      }
      DispatchQueue.main.async {
        for location in self.locations {
          let coordinate = CLLocationCoordinate2D(latitude: location.latitude ?? 0.0, longitude: location.longitude ?? 0.0)
          let annotation = MKPointAnnotation()
          annotation.coordinate = coordinate
          annotation.title = location.title
          annotation.subtitle = location.location
          self.activityMV.addAnnotation(annotation)
        }
      }
    }
  }

  @IBAction func goStartBtnPressed(_ sender: Any) {
    self.mainAuth()
  }

  func mainAuth() {
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
