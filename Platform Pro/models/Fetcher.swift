//
//  Fetcher.swift
//  Just Trains
//
//  Created by Reilly Freret on 2/19/23.
//

import Foundation
import SwiftUI
import CoreLocation

class Fetcher: ObservableObject {
  @Published var lastArrivalsResponse: MTAPIResponse = MTAPIResponse(data: [], updated: Date(), hasError: false)
  @Published var lastAlertsResponse: AlertResponse = AlertResponse(updated: 0, alerts: [])
  
  func getCurrentAlerts() {
    print("requesting alerts")
    guard let url = URL(string: "https://just-trains.herokuapp.com/alerts") else { fatalError("Missing URL") }
    
    let urlRequest = URLRequest(url: url)
    
    let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
      if error != nil {
        DispatchQueue.main.async {
          self.lastAlertsResponse.hasError = true
        }
        return
      }
      
      guard let response = response as? HTTPURLResponse else { return }
      print(response.statusCode)
      
      if response.statusCode == 200 {
        guard let data = data else { return }
        DispatchQueue.main.async {
          do {
            let decoder = JSONDecoder()
            let res = try decoder.decode(AlertResponse.self, from: data)
            
            self.lastAlertsResponse = res
            
          } catch let error {
            print("Error decoding: ", error)
          }
        }
      }
    }
    
    dataTask.resume()
  }
  
  func getNearestStationData(relativeTo: CLLocation) {
    print("requesting nearest stops")
    let lat = relativeTo.coordinate.latitude
    let lon = relativeTo.coordinate.longitude
    
    guard let url = URL(string: "https://just-trains.herokuapp.com/by-location?lat=\(lat)&lon=\(lon)") else { fatalError("Missing URL") }
    
    let urlRequest = URLRequest(url: url)
    
    let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
      if error != nil {
        DispatchQueue.main.async {
          self.lastArrivalsResponse.hasError = true
        }
        return
      }
      
      guard let response = response as? HTTPURLResponse else { return }
      
      if response.statusCode == 200 {
        guard let data = data else { return }
        DispatchQueue.main.async {
          do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let res = try decoder.decode(MTAPIResponse.self, from: data)
            self.lastArrivalsResponse = res
          } catch let error {
            print("Error decoding: ", error)
          }
        }
      }
    }
    
    dataTask.resume()
  }
  
  func TEST_getNearestStationData() {
    let c = CLLocation(latitude: 40.68118312462264, longitude: -73.95529723026948)
    getNearestStationData(relativeTo: c)
  }
}
