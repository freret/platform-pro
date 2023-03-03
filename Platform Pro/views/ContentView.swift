//
//  ContentView.swift
//  Just Trains
//
//  Created by Reilly Freret on 2/19/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    var f = Fetcher()
    
    init() {
        f.getCurrentAlerts()
    }
    
    var body: some View {
        ScrollView(.init()) { // fix for the tabview bullshit MARK
            TabView {
                NearbyArrivalsView().environmentObject(f)
                AlertsView().environmentObject(f)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
        .edgesIgnoringSafeArea(.bottom)
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
