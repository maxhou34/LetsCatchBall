//
//  LocationManger.swift
//  LetsKGB
//
//  Created by Chun on 2023/10/14.
//

import CoreLocation
import Foundation
import MapKit

typealias LocationErrorHandler = (_ response: MKLocalSearch.Response?, _ error:  Error?) -> Void
typealias LocationCoordinateHandler = (_ placemarks: [CLPlacemark]?, _ error: Error?) -> Void

class LocationManger {
  static let shared = LocationManger()
  private init() {}

  // MARK: - Search Location Method

  func searchLocation(query: String, mapView: MKMapView, completion: @escaping LocationErrorHandler) {
    let request = MKLocalSearch.Request()
    request.naturalLanguageQuery = query

    let search = MKLocalSearch(request: request)
    search.start(completionHandler: completion)
  }

  // MARK: - Get Coordinate From Method

  func getCoordinateFrom(address: String, completion: @escaping LocationErrorHandler) {
    let request = MKLocalSearch.Request()
    request.naturalLanguageQuery = address

    let search = MKLocalSearch(request: request)
    search.start(completionHandler: completion)
  }
}
