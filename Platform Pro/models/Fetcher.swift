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
  
  private let API_PREFIX: String = "https://platform-pro-api.herokuapp.com"
  
  func getCurrentAlerts() {
    print("requesting alerts")
    guard let url = URL(string: "\(API_PREFIX)/alerts") else { fatalError("Missing URL") }
    
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
      } else {
        // 404, for example
        DispatchQueue.main.async {
          self.lastAlertsResponse.hasError = true
        }
        return
      }
    }
    
    dataTask.resume()
  }
  
  func getNearestStationData(relativeTo: CLLocation) {
    print("requesting nearest stops")
    let lat = relativeTo.coordinate.latitude
    let lon = relativeTo.coordinate.longitude
    
    guard let url = URL(string: "\(API_PREFIX)/by-location?lat=\(lat)&lon=\(lon)") else { fatalError("Missing URL") }
    
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
      } else {
        // 404, for example
        DispatchQueue.main.async {
          self.lastArrivalsResponse.hasError = true
        }
        return
      }
    }
    
    dataTask.resume()
  }
  
}
