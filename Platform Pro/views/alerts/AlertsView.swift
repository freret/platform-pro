//
//  AlertsView.swift
//  Just Trains
//
//  Created by Reilly Freret on 2/20/23.
//

import Foundation
import SwiftUI
import WrappingHStack

struct AlertsView: View {
  @EnvironmentObject var fetcher: Fetcher
  @State var focusedAlert: Alert? = nil
  @State var sheetDisplayed: Bool = false
  
  @ViewBuilder
  var body: some View {
    VStack {
      PageHeader(title: "Alerts ⚠️", buttonFunction: fetcher.getCurrentAlerts)
      
      if (fetcher.lastAlertsResponse.hasError ?? false && fetcher.lastAlertsResponse.alerts.isEmpty) { // failed to fetch, haven't gotten results
        Spacer()
        Text("\(Image(systemName: "wifi.exclamationmark")) failed to fetch alerts data; check connection and try again")
        Spacer()
      } else {
        if (fetcher.lastAlertsResponse.hasError ?? false) { // failed to fetch
          Text("\(Image(systemName: "wifi.exclamationmark")) failed to connect; data may be old").padding(.top, 10)
        }
        List{
          ForEach(fetcher.lastAlertsResponse.alerts) { alert in
            AlertsListItem(alert: alert)
              .onTapGesture {
                focusedAlert = alert
                sheetDisplayed = true
              }
          }
          Spacer().frame(minHeight: 50, maxHeight: 50)
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .refreshable {
          fetcher.getCurrentAlerts()
        }
      }
    }
    .onChange(of: focusedAlert) { _ in
      sheetDisplayed = true
    }
    .sheet(isPresented: $sheetDisplayed) {
      AlertDetail(alert: focusedAlert)
    }
    
  }
}


