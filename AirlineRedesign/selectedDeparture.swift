//
//  selectedDeparture.swift
//  AirlineRedesign
//
//  Created by Logan Petree on 7/14/24.
//

import SwiftUI

struct selectedDeparture: View {
    var airport: Airport
    var body: some View {
        VStack(alignment: .leading){
            Text("Departing \(airport.city)")
                .font(.largeTitle)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            Spacer()
            
        }
        .padding(.trailing, 75)
    }
}

#Preview {
    NavigationStack{
        let previewAirport = Airport(code: "Dfw", city: "Dallas", state: "Tx")
        selectedDeparture(airport: previewAirport)

    }
}
