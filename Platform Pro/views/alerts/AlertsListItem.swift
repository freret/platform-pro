//
//  AlertsListItem.swift
//  Just Trains
//
//  Created by Reilly Freret on 2/22/23.
//

import Foundation
import SwiftUI
import WrappingHStack

struct AlertsListItem: View {
  var alert: Alert
  
  private func generateView(item: String) -> some View {
    if item.contains(/\[[A-Z0-9]+\]/) {
      let formatted = item.replacingOccurrences(of: "[\\[\\]]", with: "", options: .regularExpression)
      return AnyView(RouteIcon(canonicalRouteName: formatted, weight: .bold, paddingC: 6).font(.system(size: 12)))
    }
    return AnyView(Text(item).padding(.vertical, 2))
  }
  
  var body: some View {
    VStack(spacing: 0) {
      Text(alert.mercuryAlert.alertType)
        .font(.system(size: 18))
        .fontWeight(.bold)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.bottom, 10)
      WrappingHStack(alignment: .leading, horizontalSpacing: 4, verticalSpacing: 0) {
        ForEach(alert.getTitleAsComponents(), id: \.0) { _, word in
          generateView(item: word)
        }
      }
    }
  }
}

struct AnyAsAlert: View {
  var withText: String
  
  private func generateView(item: String) -> some View {
    if item.contains(/\[[A-Z0-9]+\]/) {
      let formatted = item.replacingOccurrences(of: "[\\[\\]]", with: "", options: .regularExpression)
      return AnyView(RouteIcon(canonicalRouteName: formatted, weight: .bold, paddingC: 6).font(.system(size: 12)))
    } else if (item.contains("__ai__")) {
      return AnyView(Text(Image(systemName: "figure.roll")))
    }
    return AnyView(Text(item).padding(.vertical, 2))
  }
  
  var body: some View {
    WrappingHStack(alignment: .leading, horizontalSpacing: 4, verticalSpacing: 0) {
      ForEach(Alert.getTextAsComponents(from: withText), id: \.0) { _, word in
        generateView(item: word)
      }
    }
  }
}
