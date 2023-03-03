//
//  Network.swift
//  Just Trains
//
//  Created by Reilly Freret on 2/19/23.
//

import Foundation
import CoreLocation

struct MTAPIResponse: Decodable {
  let data: [Station]
  let updated: Date
  var hasError: Bool? = false
}

struct Station: Decodable, Identifiable {
  let N: [Arrival]
  let S: [Arrival]
  let id: String
  let location: [Float]
  let name: String
  let routes: [String]
  let stops: [String: [Float]]
}

struct Arrival: Decodable, Hashable {
  let route: String
  let time: Date
  
  public func readableTime(since: Date) -> String {
    let k = since.distance(to: self.time)
    let minutes = Int(floor(k / 60))
    return minutes > 0 ? "\(minutes)m" : "now"
  }
}
