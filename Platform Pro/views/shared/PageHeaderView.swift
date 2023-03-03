//
//  PageHeaderView.swift
//  Just Trains
//
//  Created by Reilly Freret on 2/22/23.
//

import Foundation
import SwiftUI

struct PageHeader: View {
  var title: String
  var buttonFunction: () -> Void
  
  var body: some View {
    HStack {
      Text(title).font(.system(size: 32)).fontWeight(.bold)
      Spacer()
      Button(action: {
        buttonFunction()
      }, label: {
        Image(systemName: "arrow.triangle.2.circlepath")
      })
      .font(.system(size: 16))
      .buttonStyle(.bordered)
      .tint(.blue)
    }
    .padding(.horizontal, 20)
    .padding(.top, 10)
  }
}
