//
//  APIModels.swift
//  AirlineRedesign
//
//  Created by Logan Petree on 7/10/24.
//

import Foundation

struct TokenResponse: Codable {
    let accessToken: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
    }
}

func requestAccessToken(apiKey: String, apiSecret: String) async throws -> String {
    // setting URL
    let tokenUrl = URL(string: "https://test.api.amadeus.com/v1/security/oauth2/token")!
    
    // setting Request Type
    var request = URLRequest(url: tokenUrl)
    request.httpMethod = "POST"
    
    // setting Header Value
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    
    // setting body value
    let bodyParameters = [
        "grant_type": "client_credentials",
        "client_id": apiKey,
        "client_secret": apiSecret
    ]
    let bodyString = bodyParameters.map { "\($0.key)=\($0.value)" }.joined(separator: "&")
    
    request.httpBody = bodyString.data(using: .utf8)
    
    // executing request
    let (data, _) = try await URLSession.shared.data(for: request)
    let tokenResponse = try JSONDecoder().decode(TokenResponse.self, from: data)
    
    
    // returning request
    return tokenResponse.accessToken
}


func fetchFlightOffers(clientId: String, clientSecret: String, origin: String, destination: String, departureDate: String, adults: Int, maxResults: Int) async throws -> [Datum] {
    let token = try await requestAccessToken(apiKey: clientId, apiSecret: clientSecret)
    
    guard let url = URL(string: "https://test.api.amadeus.com/v2/shopping/flight-offers?originLocationCode=\(origin)&destinationLocationCode=\(destination)&departureDate=\(departureDate)&adults=\(adults)&max=\(maxResults)") else {
        throw URLError(.badURL)
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    
    let (data, response) = try await URLSession.shared.data(for: request)
    
    guard (response as? HTTPURLResponse)?.statusCode == 200 else {
        throw URLError(.badServerResponse)
    }
    
    let decoder = JSONDecoder()
    do {
        let flightOffersResponse = try decoder.decode(Flights.self, from: data)
        return flightOffersResponse.data ?? []
    } catch {
        print("Error decoding JSON: \(error)")
        throw error
    }
}

// MARK: - Flights
struct Flights: Codable {
    let meta: Meta?
    let data: [Datum]?
    let dictionaries: Dictionaries?
}

// MARK: - Datum
struct Datum: Codable, Identifiable {
    let type, id, source: String?
    let instantTicketingRequired, nonHomogeneous, oneWay: Bool?
    let lastTicketingDate: String?
    let numberOfBookableSeats: Int?
    let itineraries: [Itinerary]?
    let price: DatumPrice?
    let pricingOptions: PricingOptions?
    let validatingAirlineCodes: [String]?
    let travelerPricings: [TravelerPricing]?
}

// MARK: - Itinerary
struct Itinerary: Codable {
    let duration: String?
    let segments: [Segment]?
}

// MARK: - Segment
struct Segment: Codable {
    let departure, arrival: Arrival?
    let carrierCode, number: String?
    let aircraft: Aircraft?
    let operating: Operating?
    let duration, id: String?
    let numberOfStops: Int?
    let blacklistedInEU: Bool?
}

// MARK: - Aircraft
struct Aircraft: Codable {
    let code: String?
}

// MARK: - Arrival
struct Arrival: Codable {
    let iataCode, terminal, at: String?
}

// MARK: - Operating
struct Operating: Codable {
    let carrierCode: String?
}

// MARK: - DatumPrice
struct DatumPrice: Codable {
    let currency, total, base: String?
    let fees: [Fee]?
    let grandTotal: String?
}

// MARK: - Fee
struct Fee: Codable {
    let amount, type: String?
}

// MARK: - PricingOptions
struct PricingOptions: Codable {
    let fareType: [String]?
    let includedCheckedBagsOnly: Bool?
}

// MARK: - TravelerPricing
struct TravelerPricing: Codable {
    let travelerID, fareOption, travelerType: String?
    let price: TravelerPricingPrice?
    let fareDetailsBySegment: [FareDetailsBySegment]?

    enum CodingKeys: String, CodingKey {
        case travelerID = "travelerId"
        case fareOption, travelerType, price, fareDetailsBySegment
    }
}

// MARK: - FareDetailsBySegment
struct FareDetailsBySegment: Codable {
    let segmentID, cabin, fareBasis, fareDetailsBySegmentClass: String?
    let includedCheckedBags: IncludedCheckedBags?

    enum CodingKeys: String, CodingKey {
        case segmentID = "segmentId"
        case cabin, fareBasis
        case fareDetailsBySegmentClass = "class"
        case includedCheckedBags
    }
}

// MARK: - IncludedCheckedBags
struct IncludedCheckedBags: Codable {
    let weight: Int?
    let weightUnit: String?
}

// MARK: - TravelerPricingPrice
struct TravelerPricingPrice: Codable {
    let currency, total, base: String?
}

// MARK: - Dictionaries
struct Dictionaries: Codable {
    let locations: [String: Location]?
    let aircraft: [String: String]?
    let currencies: Currencies?
    let carriers: Carriers?
}

// MARK: - Carriers
struct Carriers: Codable {
    let pr: String?

    enum CodingKeys: String, CodingKey {
        case pr = "PR"
    }
}

// MARK: - Currencies
struct Currencies: Codable {
    let eur: String?

    enum CodingKeys: String, CodingKey {
        case eur = "EUR"
    }
}

// MARK: - Location
struct Location: Codable {
    let cityCode, countryCode: String?
}

// MARK: - Meta
struct Meta: Codable {
    let count: Int?
    let links: Links?
}

// MARK: - Links
struct Links: Codable {
    let linksSelf: String?

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
    }
}

