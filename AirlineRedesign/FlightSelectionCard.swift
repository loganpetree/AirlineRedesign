//
//  FlightSelectionCard.swift
//  AirlineRedesign
//
//  Created by Logan Petree on 7/10/24.
//

import SwiftUI
struct FlightSelectionCard: View {
    
    var flight: Datum
    
    var body: some View {
        HStack{
            HStack(spacing: 20){
                VStack(alignment:.leading){
                    Text(flight.itineraries?.first?.segments?.first?.departure?.iataCode ?? "DEPA")
                        .font(.subheadline)
                        .foregroundStyle(Color(UIColor.darkGray))
                    Text(extractTime(from: (flight.itineraries?.first?.segments?.first?.departure?.at)!))
                        .bold()
                    if let duration = flight.itineraries?.first?.segments?.first?.duration {
                        Text(formatDuration(duration))
                            .foregroundStyle(Color(UIColor.darkGray))
                    } else {
                        Text("Unknown Duration")
                            .foregroundStyle(Color(UIColor.darkGray))
                    }
                }
                Image(systemName: "arrow.right")
                    .foregroundStyle(Color(UIColor.darkGray))
                
                VStack(alignment:.leading){
                    Text(flight.itineraries?.first?.segments?.first?.arrival?.iataCode ?? "ARI")
                        .font(.subheadline)
                        .foregroundStyle(Color(UIColor.darkGray))
                    
                    Text(extractTime(from: (flight.itineraries?.first?.segments?.first?.arrival?.at)!))
                        .bold()
                    
                    if flight.itineraries?.first?.segments?.first?.numberOfStops == 0 {
                        Text("Nonstop")
                            .foregroundStyle(Color(UIColor.darkGray))
                    } else {
                        Text(flight.itineraries?.first?.segments?.first?.numberOfStops?.description ?? "NA")
                    }
                }
            }
            Spacer()
            VStack(alignment:.trailing){
                Text("Starting at")
                    .font(.caption)
                Text("\(String(describing: flight.price?.base ?? "NA"))")
                    .bold()
            }
            
            Image(systemName: "chevron.right")
        }
        .padding()
    }
    
    
    func formatDuration(_ duration: String) -> String {
        // Ensure the duration string starts with "PT"
        guard duration.hasPrefix("PT") else { return duration }
        
        // Remove the "PT" prefix
        let timeString = duration.dropFirst(2)
        
        // Variables to store hours and minutes
        var hours = ""
        var minutes = ""
        
        // Check if hours are present
        if let hIndex = timeString.firstIndex(of: "H") {
            hours = String(timeString[..<hIndex])
        }
        
        // Check if minutes are present
        if let mIndex = timeString.firstIndex(of: "M") {
            let minutesStart = timeString.index(after: timeString.firstIndex(of: "H") ?? timeString.startIndex)
            minutes = String(timeString[minutesStart..<mIndex])
        }
        
        // Format the result
        return "\(hours)h \(minutes)min"
    }
    
    
    func extractHourAndMinute(from durationString: String) -> String {
        // Remove the "PT" prefix and "M" suffix
        let timeString = durationString.replacingOccurrences(of: "PT", with: "").replacingOccurrences(of: "M", with: "")
        
        // Split the remaining string by "H" to separate hours and minutes
        let components = timeString.split(separator: "H")
        
        // Extract hours and minutes
        let hours = components[0]
        let minutes = components[1]
        
        return "\(hours)H \(minutes)M"
    }
    
    func extractTime(from dateTimeString: String) -> String {
        // Define the date format of the input string
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        // Convert the input string to a Date object
        let date = dateFormatter.date(from: dateTimeString)
        
        
        // Define the date format for the output string (time only)
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        
        // Convert the Date object to a time string
        let timeString = timeFormatter.string(from: date!)
        
        return timeString
    }
}

#Preview {
    List{
        FlightSelectionCard(flight: Datum(
            type: "flight-offer",
            id: "1",
            source: "GDS",
            instantTicketingRequired: false,
            nonHomogeneous: false,
            oneWay: false,
            lastTicketingDate: "2024-12-09",
            numberOfBookableSeats: 9,
            itineraries: [
                Itinerary(
                    duration: "PT14H15M",
                    segments: [
                        Segment(
                            departure: Arrival(iataCode: "SYD", terminal: "1", at: "2024-12-09T11:35:00"),
                            arrival: Arrival(iataCode: "MNL", terminal: "2", at: "2024-12-09T16:50:00"),
                            carrierCode: "PR",
                            number: "212",
                            aircraft: Aircraft(code: "333"),
                            operating: Operating(carrierCode: "PR"),
                            duration: "PT8H15M",
                            id: "1",
                            numberOfStops: 0,
                            blacklistedInEU: false
                        ),
                        Segment(
                            departure: Arrival(iataCode: "MNL", terminal: "1", at: "2024-12-09T19:20:00"),
                            arrival: Arrival(iataCode: "BKK", terminal: nil, at: "2024-12-09T21:50:00"),
                            carrierCode: "PR",
                            number: "732",
                            aircraft: Aircraft(code: "320"),
                            operating: Operating(carrierCode: "PR"),
                            duration: "PT3H30M",
                            id: "2",
                            numberOfStops: 0,
                            blacklistedInEU: false
                        )
                    ]
                )
            ],
            price: DatumPrice(
                currency: "EUR",
                total: "355.34",
                base: "255.00",
                fees: [
                    Fee(amount: "0.00", type: "SUPPLIER"),
                    Fee(amount: "0.00", type: "TICKETING")
                ],
                grandTotal: "355.34"
            ),
            pricingOptions: PricingOptions(
                fareType: ["PUBLISHED"],
                includedCheckedBagsOnly: true
            ),
            validatingAirlineCodes: ["PR"],
            travelerPricings: [
                TravelerPricing(
                    travelerID: "1",
                    fareOption: "STANDARD",
                    travelerType: "ADULT",
                    price: TravelerPricingPrice(
                        currency: "EUR",
                        total: "355.34",
                        base: "255.00"
                    ),
                    fareDetailsBySegment: [
                        FareDetailsBySegment(
                            segmentID: "1",
                            cabin: "ECONOMY",
                            fareBasis: "EOBAU",
                            fareDetailsBySegmentClass: "E",
                            includedCheckedBags: IncludedCheckedBags(weight: 25, weightUnit: "KG")
                        ),
                        FareDetailsBySegment(
                            segmentID: "2",
                            cabin: "ECONOMY",
                            fareBasis: "EOBAU",
                            fareDetailsBySegmentClass: "E",
                            includedCheckedBags: IncludedCheckedBags(weight: 25, weightUnit: "KG")
                        )
                    ]
                )
            ]
        )
        )
        
    }
    .listStyle(.plain)
}
