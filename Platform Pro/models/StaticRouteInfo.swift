//
//  StaticRouteInfo.swift
//  Just Trains
//
//  Created by Reilly Freret on 2/19/23.
//

import Foundation
import SwiftUI

struct RouteInfo {
  var bgColor: Color
  var fgColor: Color
  var displayName: String
}

class RouteLib {
  // key: canonical name  value: information
  private static var routes: [String: RouteInfo] = [
    "1": RouteInfo(bgColor: Color(hex: "EE352E"), fgColor: Color(.white), displayName: "1"),
    "2": RouteInfo(bgColor: Color(hex: "EE352E"), fgColor: Color(.white), displayName: "2"),
    "3": RouteInfo(bgColor: Color(hex: "EE352E"), fgColor: Color(.white), displayName: "3"),
    "4": RouteInfo(bgColor: Color(hex: "00933C"), fgColor: Color(.white), displayName: "4"),
    "5": RouteInfo(bgColor: Color(hex: "00933C"), fgColor: Color(.white), displayName: "5"),
    "5X": RouteInfo(bgColor: Color(hex: "00933C"), fgColor: Color(.white), displayName: "5"),
    "6": RouteInfo(bgColor: Color(hex: "00933C"), fgColor: Color(.white), displayName: "6"),
    "6X": RouteInfo(bgColor: Color(hex: "00933C"), fgColor: Color(.white), displayName: "6"),
    "7": RouteInfo(bgColor: Color(hex: "B933AD"), fgColor: Color(.white), displayName: "7"),
    "7X": RouteInfo(bgColor: Color(hex: "B933AD"), fgColor: Color(.white), displayName: "7"),
    "GS": RouteInfo(bgColor: Color(hex: "6D6E71"), fgColor: Color(.white), displayName: "S"),
    "A": RouteInfo(bgColor: Color(hex: "2850AD"), fgColor: Color(.white), displayName: "A"),
    "B": RouteInfo(bgColor: Color(hex: "FF6319"), fgColor: Color(.white), displayName: "B"),
    "C": RouteInfo(bgColor: Color(hex: "2850AD"), fgColor: Color(.white), displayName: "C"),
    "D": RouteInfo(bgColor: Color(hex: "FF6319"), fgColor: Color(.white), displayName: "D"),
    "E": RouteInfo(bgColor: Color(hex: "2850AD"), fgColor: Color(.white), displayName: "E"),
    "F": RouteInfo(bgColor: Color(hex: "FF6319"), fgColor: Color(.white), displayName: "F"),
    "FX": RouteInfo(bgColor: Color(hex: "FF6319"), fgColor: Color(.white), displayName: "F"),
    "FS": RouteInfo(bgColor: Color(hex: "6D6E71"), fgColor: Color(.white), displayName: "S"),
    "G": RouteInfo(bgColor: Color(hex: "6CBE45"), fgColor: Color(.white), displayName: "G"),
    "J": RouteInfo(bgColor: Color(hex: "996633"), fgColor: Color(.white), displayName: "J"),
    "L": RouteInfo(bgColor: Color(hex: "A7A9AC"), fgColor: Color(.white), displayName: "L"),
    "M": RouteInfo(bgColor: Color(hex: "FF6319"), fgColor: Color(.white), displayName: "M"),
    "N": RouteInfo(bgColor: Color(hex: "FCCC0A"), fgColor: Color(.black), displayName: "N"),
    "Q": RouteInfo(bgColor: Color(hex: "FCCC0A"), fgColor: Color(.black), displayName: "Q"),
    "R": RouteInfo(bgColor: Color(hex: "FCCC0A"), fgColor: Color(.black), displayName: "R"),
    "H": RouteInfo(bgColor: Color(.systemTeal), fgColor: Color(.white), displayName: "H"),
    "W": RouteInfo(bgColor: Color(hex: "FCCC0A"), fgColor: Color(.black), displayName: "W"),
    "Z": RouteInfo(bgColor: Color(hex: "996633"), fgColor: Color(.white), displayName: "Z"),
    "SIR": RouteInfo(bgColor: Color(hex: "183aa0"), fgColor: Color(.white), displayName: "SI"),
  ]
  
  public static func getInfo(about: String) -> RouteInfo {
    if (routes[about] == nil) {
      print("UNKNOWN ROUTE: \(about)")
      return RouteInfo(bgColor: Color(.purple), fgColor: Color(.white), displayName: "?")
    }
    return routes[about]!
  }
}

extension Color {
  init(hex: String) {
    let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
    var int: UInt64 = 0
    Scanner(string: hex).scanHexInt64(&int)
    let a, r, g, b: UInt64
    switch hex.count {
    case 3: // RGB (12-bit)
      (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
    case 6: // RGB (24-bit)
      (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
    case 8: // ARGB (32-bit)
      (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
    default:
      (a, r, g, b) = (1, 1, 1, 0)
    }
    
    self.init(
      .sRGB,
      red: Double(r) / 255,
      green: Double(g) / 255,
      blue:  Double(b) / 255,
      opacity: Double(a) / 255
    )
  }
}
