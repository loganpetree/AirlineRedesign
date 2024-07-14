//
//  EnterSearchDetailsView.swift
//  AirlineRedesign
//
//  Created by Logan Petree on 7/14/24.
//

import SwiftUI

struct EnterSearchDetailsView: View {
    @State private var departureAirport: Airport? = nil
    var body: some View {
        NavigationStack{
            VStack{
                Form{
                    Section{
                        DepartureButton(departureAirport: $departureAirport)
                        ArrivalButton()
                    }
                    
                    Section{
                        Button{
                            // trigger show departure airports
                        } label: {
                            VStack(alignment:.leading){
                                Text("Departure Date")
                                    .font(.subheadline)
                                HStack{
                                    Text("Dallas")
                                    Text("DFW")
                                }
                            }
                        }
                        .frame(height: UIScreen.main.bounds.height * 0.05)
                        Button{
                            // trigger show departure airports
                        } label: {
                            VStack(alignment:.leading){
                                Text("Departure Date")
                                    .font(.subheadline)
                                HStack{
                                    Text("Dallas")
                                    Text("DFW")
                                }
                            }
                        }
                        .frame(height: UIScreen.main.bounds.height * 0.05)
                        
                    }
                }
                .scrollDisabled(true)
                .tint(.black)
                
            }
            .navigationTitle("Booking")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    EnterSearchDetailsView()
}

struct DepartureButton: View {
    @State private var showingAirportList: Bool = false
    @Binding var departureAirport: Airport?
    var body: some View {
        if departureAirport == nil {
            Button{
                showingAirportList.toggle()
            } label: {
                HStack{
                    Text(departureAirport?.code ?? "Enter Departure")
                        .font(.title2)
                        .foregroundStyle(Color.gray)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Image(systemName: "airplane")
                        .rotationEffect(.degrees(270))
                        .imageScale(.large)
                }
            }
            .frame(height: UIScreen.main.bounds.height * 0.08)
            .sheet(isPresented: $showingAirportList) {
                PickFlightDetailsView(selection: $departureAirport, navigationTitle: "Departure Airports")
            }
        } else {
            Button{
                showingAirportList.toggle()
            } label: {
                HStack{
                    VStack(alignment: .leading) {
                        Text("Departing")
                            .font(.subheadline)
                        Text(departureAirport?.code ?? "Departure Code")
                            .font(.title2)
                            .bold()
                        HStack(spacing: 4) {
                            Text(departureAirport?.city ?? "City")
                            Text(departureAirport?.state ?? "State")
                        }
                        .font(.subheadline)
                    }
                    Spacer()
                    Image(systemName: "airplane")
                        .rotationEffect(.degrees(270))
                        .imageScale(.large)
                }
            }
            .frame(height: UIScreen.main.bounds.height * 0.08)
            .sheet(isPresented: $showingAirportList) {
                PickFlightDetailsView(selection: $departureAirport, navigationTitle: "Departure Airports")
            }
        }
    }
}



struct ArrivalButton: View {
    @State private var departureCode: String = ""
    @State private var departureCity: String = ""
    @State private var departureState: String = ""
    @State private var arrivalCode: String = ""
    @State private var arrivalCity: String = ""
    @State private var arrivalState: String = ""
    var body: some View {
        Button{
            // trigger show departure airports
        } label: {
            HStack{
                VStack(alignment:.leading){
                    Text("Arriving")
                        .font(.subheadline)
                    if arrivalCode == ""{
                        Text("Arrival Code")
                            .font(.title2)
                            .bold()
                    } else {
                        Text(arrivalCode)
                            .font(.title2)
                            .bold()
                    }
                    HStack(spacing: 4){
                        if arrivalCity == ""{
                            Text("City")
                        } else {
                            Text(arrivalCity)
                        }
                        
                        if arrivalState == ""{
                            Text("State")
                        } else {
                            Text(arrivalState)
                        }
                        
                    }
                    .font(.subheadline)
                }
                Spacer()
                Image(systemName: "airplane")
                    .rotationEffect(.degrees(90))
                    .imageScale(.large)
            }
        }
        .frame(height: UIScreen.main.bounds.height * 0.08)
    }
}
