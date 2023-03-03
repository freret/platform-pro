//
//  AlertsDetail.swift
//  Just Trains
//
//  Created by Reilly Freret on 2/22/23.
//

import Foundation
import SwiftUI

struct AlertDetail: View {
  var alert: Alert?
  
  @ViewBuilder
  var body: some View {
    if (alert == nil) {
      Text("Error presenting alert")
    } else {
      List {
        VStack(spacing: 10) {
          Text(alert!.mercuryAlert.alertType)
            .frame(maxWidth: .infinity, alignment: .leading)
            .fontWeight(.bold)
            .font(.system(size: 20))
            .padding(.top, 15)
          
          Divider()
          
          AnyAsAlert(withText: alert!.headerText.translation[0].text.replacingOccurrences(of: "\n", with: " "))
            .frame(maxWidth: .infinity, alignment: .leading)
          
          Divider()
          
          if (alert!.descriptionText?.translation[0].text == nil) {
            Text("No description")
              .italic()
              .frame(maxWidth: .infinity, alignment: .leading)
          } else {
            ForEach(alert!.descriptionText!.translation[0].text.components(separatedBy: "\n").filter { $0 != "" }, id: \.self) { paragraph in
              AnyAsAlert(withText: paragraph)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 10)
            }
          }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .listRowSeparator(.hidden)
      }
      .listStyle(.plain)
    }
    
  }
}
