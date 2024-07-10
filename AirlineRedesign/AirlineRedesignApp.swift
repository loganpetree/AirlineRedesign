//
//  AirlineRedesignApp.swift
//  AirlineRedesign
//
//  Created by Logan Petree on 7/8/24.
//

import SwiftUI

@main
struct AirlineRedesignApp: App {
    var body: some Scene {
        WindowGroup {
            SelectRouteView()
                .task {
                    do {
                        let clientId = "oIH9cKRsNF0GkBmf9AA9GAlHKG6pyWR4"
                        let clientSecret = "yhKNFCqDmmZ4A6Cf"
                        
                        let accessToken = try await requestAccessToken(apiKey: clientId, apiSecret: clientSecret)
                        print("Access Token: \(accessToken)")
                        
                    } catch {
                        print("Error: \(error)")
                    }
                }
        }
    }
}
