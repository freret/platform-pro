//
//  NearbyArrivalsView.swift
//  Just Trains
//
//  Created by Reilly Freret on 2/20/23.
//

import Foundation
import SwiftUI

struct ArrivalListItem: View {
  var arrival: Arrival
  var direction: String
  
  var body: some View {
    HStack {
      Text(Image(systemName:
                  direction == "north" ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill"))
      .font(.system(size: 10))
      .foregroundColor(Color(.systemGray))
      RouteIcon(canonicalRouteName: arrival.route)
      Spacer()
      Text(arrival.readableTime(since: Date()))
    }
  }
}

struct StationListItem: View {
  var station: Station
  
  var body: some View {
    Section(header: Text(station.name).font(.system(size: 18)).fontWeight(.medium).foregroundColor(Color(.label))) {
      HStack(alignment: .top) {
        VStack {
          ForEach(station.N, id: \.self) { arrival in
            ArrivalListItem(arrival:arrival, direction: "north")
          }
        }
        .frame(maxWidth: .infinity)
        
        Divider()
          .background(Color(.systemGray4))
          .padding(.horizontal, 15)
        
        VStack {
          ForEach(station.S, id: \.self) { arrival in
            ArrivalListItem(arrival:arrival, direction: "south")
          }
        }
        .frame(maxWidth: .infinity)
      }
    }
    .listRowSeparator(.hidden)
  }
}

struct NearbyArrivalsView: View {
  @EnvironmentObject var fetcher: Fetcher
  @ObservedObject var locationManager: LocationManager = LocationManager()
  
  init() {
    self.locationManager.manager.requestWhenInUseAuthorization()
    self.locationManager.manager.startUpdatingLocation()
  }
  
  @ViewBuilder
  var body: some View {
    VStack {
      PageHeader(title: "Trains 🚂", buttonFunction: triggerRefresh)
      
      if (locationManager.manager.authorizationStatus == .notDetermined || locationManager.manager.authorizationStatus == .denied) {
        CenteredError(message: "We don't have permission to use your location; allow location usage in Settings to enable this page", withSystemIcon: "location.slash.fill")
      } else {
        if (fetcher.lastArrivalsResponse.hasError ?? false && fetcher.lastArrivalsResponse.data.isEmpty) {
          // failed to fetch, haven't gotten results
          CenteredError(message: "Failed to fetch train data; check connection and try again", withSystemIcon: "wifi.exclamationmark")
        } else {
          if (fetcher.lastArrivalsResponse.hasError ?? false) {
            // failed to fetch, but keep showing old results and let user decide if they're still relevant
            Text("\(Image(systemName: "wifi.exclamationmark")) failed to connect; data may be old").padding(.top, 10)
          }
          List{
            ForEach(fetcher.lastArrivalsResponse.data) { s in
              StationListItem(station: s)
            }
            if (fetcher.lastArrivalsResponse.data.count > 1) {
              Spacer().frame(minHeight: 50, maxHeight: 50)
                .listRowSeparator(.hidden)
            }
          }
          .listStyle(.plain)
          .refreshable {
            triggerRefresh()
          }
          .onReceive(locationManager.$lastLocation, perform: {l in
            if (l == nil) {
              print("no location")
              return
            }
            print("calling fetch")
            fetcher.getNearestStationData(relativeTo: l!)
          })
        }
      }
    }
  }
  
  func triggerRefresh() {
    print("manual refresh")
    locationManager.manager.startUpdatingLocation()
    if (locationManager.lastLocation == nil) {
      print("no location; exiting")
      return
    }
    fetcher.getNearestStationData(relativeTo: locationManager.lastLocation!)
  }
}
