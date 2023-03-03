// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let alert = try? JSONDecoder().decode(Alert.self, from: jsonData)

import Foundation

struct AlertResponse: Codable {
  let updated: Int
  let alerts: [Alert]
  var hasError: Bool? = false
}

// MARK: - Alert
struct Alert: Codable, Identifiable, Equatable {
  static func == (lhs: Alert, rhs: Alert) -> Bool {
    return lhs.id == rhs.id
  }
  
  let activePeriod: [ActivePeriod]
  let descriptionText: DescriptionText?
  let headerText: DescriptionText
  let id: String
  let informedRoutes: [String]
  let mercuryAlert: MercuryAlert
  
  static func getTextAsComponents(from: String) -> [(Int, String)] {
    var result: [String] = []
    var partial: String = ""
    
    for c in from {
      partial = partial.replacingOccurrences(of: "accessibility icon", with: "__ai__")
      if c == "[" {
        if (partial != "") { result += partial.components(separatedBy: " ") }
        partial = String(c)
      } else if c == "]" {
        partial.append(c)
        result += partial.components(separatedBy: " ")
        partial = ""
      } else {
        partial.append(c)
      }
    }
    result += partial.components(separatedBy: " ")
    let filtered = result.filter { s in s != "" }
    
    return Array(zip(filtered.indices, filtered))
  }
  
  public func getTitleAsComponents() -> [(Int, String)] {
    guard let titleText = self.headerText.translation[safe: 0]?.text.replacingOccurrences(of: "\n", with: " ") else {
      return [(0, "<ERROR>"), (1, "parsing"), (2, "alert")]
    }
    return Alert.getTextAsComponents(from: titleText)
  }
  
  public func getDescriptionAsComponents() -> [(Int, String)] {
    guard let descText = self.descriptionText?.translation[safe: 0]?.text.replacingOccurrences(of: "\n", with: " ") else {
      return [(0, "<ERROR>"), (1, "parsing"), (2, "alert")]
    }
    return Alert.getTextAsComponents(from: descText)
  }
}

// MARK: - ActivePeriod
struct ActivePeriod: Codable {
  let end, start: Int?
}

// MARK: - DescriptionText
struct DescriptionText: Codable {
  let translation: [Translation]
}

// MARK: - Translation
struct Translation: Codable {
  let language, text: String
}

// MARK: - MercuryAlert
struct MercuryAlert: Codable {
  let alertType: String
  let humanReadableActivePeriod: DescriptionText?
  let servicePlanNumber: [String]?
  let updatedAt, createdAt, displayBeforeActive: Int?
}
