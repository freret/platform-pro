//
//  Just_TrainsApp.swift
//  Just Trains
//
//  Created by Reilly Freret on 2/19/23.
//

import SwiftUI
import CoreLocation

@main
struct PlatformProApp: App {
  
  init() {
    UIScrollView.appearance().clipsToBounds = false
  }
  
  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
  let manager = CLLocationManager()
  @Published var lastLocation: CLLocation?
  
  override init() {
    super.init()
    manager.delegate = self
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print("error:: \(error.localizedDescription)")
  }
  
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    if status == .authorizedWhenInUse {
      manager.startUpdatingLocation()
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    print("ldu")
    if (lastLocation != nil && locations.count > 0 && lastLocation!.distance(from: locations.last!) < 10) {
      // hasn't moved enough
      manager.stopUpdatingLocation()
      return
    }
    print("Location updating")
    self.lastLocation = locations.last!
  }
  
}
