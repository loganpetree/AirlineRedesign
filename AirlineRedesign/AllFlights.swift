//
//  AllFlights.swift
//  AirlineRedesign
//
//  Created by Logan Petree on 7/11/24.
//

import SwiftUI

struct AllFlights: View {
    @State private var flights: [Datum] = []
    
    var body: some View {
    
   
        List{
            ForEach(flights) { flight in
                SearchResultCard(flight: flight)
            }
        }
        
//            .task {
//                do {
//                    let clientId = "oIH9cKRsNF0GkBmf9AA9GAlHKG6pyWR4"
//                    let clientSecret = "yhKNFCqDmmZ4A6Cf"
//                    
//                    flights = try await fetchFlightOffers(clientId: clientId, clientSecret: clientSecret, origin: "DFW", destination: "LAX", departureDate: "2024-12-09", adults: 1, maxResults: 10)
//                    
//                    print(flights)
//                    
//                
//                } catch {
//                    print("Error: Can't show flights. \(error)")
//                }
//            }
        }
}

#Preview {
    AllFlights()
}
