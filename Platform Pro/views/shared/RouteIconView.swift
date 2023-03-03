//
//  RouteIconView.swift
//  Just Trains
//
//  Created by Reilly Freret on 2/22/23.
//

import Foundation
import SwiftUI

struct RouteIcon: View {
    var canonicalRouteName: String
    var weight: Font.Weight = .medium
    var paddingC: CGFloat = 10
    
    var info: RouteInfo {
        RouteLib.getInfo(about: canonicalRouteName)
    }
    
    var body: some View {
        ZStack {
            Text(info.displayName)
                .foregroundColor(info.fgColor)
                .fontWeight(weight)
                .monospaced()
        }
        .padding(paddingC)
        .background(info.bgColor)
        .clipShape(Circle())
    }
}
