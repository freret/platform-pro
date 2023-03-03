//
//  CenteredError.swift
//  Platform Pro
//
//  Created by Reilly Freret on 3/3/23.
//

import Foundation
import SwiftUI

struct CenteredError: View {
  var message: String
  var withSystemIcon: String
  
  var body: some View {
    Spacer().frame(maxHeight: 200)
    Image(systemName: withSystemIcon)
      .padding(.bottom)
      .font(.system(size: 26))
    Text(message)
      .multilineTextAlignment(.center)
      .padding(.horizontal, 20)
    Spacer()
  }
}
