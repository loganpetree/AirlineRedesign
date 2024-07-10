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
    let tokenUrl = URL(string: "https://test.api.amadeus.com/v1/security/oauth2/token")!
    var request = URLRequest(url: tokenUrl)
    request.httpMethod = "POST"
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    
    let bodyParameters = [
        "grant_type": "client_credentials",
        "client_id": apiKey,
        "client_secret": apiSecret
    ]
    let bodyString = bodyParameters.map { "\($0.key)=\($0.value)" }.joined(separator: "&")
    request.httpBody = bodyString.data(using: .utf8)
    
    let (data, _) = try await URLSession.shared.data(for: request)
    let tokenResponse = try JSONDecoder().decode(TokenResponse.self, from: data)
    
    return tokenResponse.accessToken
}


















// Root model
struct FlightOffersResponse: Codable {
    let meta: Meta
    let data: [FlightOffer]
    let dictionaries: Dictionaries
}

// Meta information
struct Meta: Codable {
    let count: Int
    let links: CollectionLinks?
}

struct CollectionLinks: Codable {
    let selfLink: String
    let next: String?
    let previous: String?
    let last: String?
    let first: String?
    let up: String?

    enum CodingKeys: String, CodingKey {
        case selfLink = "self"
        case next
        case previous
        case last
        case first
        case up
    }
}

// Dictionaries
struct Dictionaries: Codable {
    let locations: [String: Location]
    let aircraft: [String: String]
    let currencies: [String: String]
    let carriers: [String: String]
}

struct Location: Codable {
    let cityCode: String
    let countryCode: String
}

// FlightOffer
struct FlightOffer: Codable {
    let type: String
    let id: String
    let source: String
    let instantTicketingRequired: Bool
    let nonHomogeneous: Bool
    let oneWay: Bool
    let lastTicketingDate: String
    let lastTicketingDateTime: String?
    let numberOfBookableSeats: Int
    let itineraries: [Itinerary]
    let price: ExtendedPrice
    let pricingOptions: PricingOptions
    let validatingAirlineCodes: [String]
    let travelerPricings: [TravelerPricing]
}

// Itinerary
struct Itinerary: Codable {
    let duration: String
    let segments: [Segment]
}

// Segment
struct Segment: Codable {
    let id: String
    let departure: FlightEndPoint
    let arrival: FlightEndPoint
    let carrierCode: String
    let number: String
    let aircraft: AircraftEquipment
    let operating: OperatingFlight
    let duration: String
    let numberOfStops: Int
    let blacklistedInEU: Bool
    let co2Emissions: [Co2Emission]?
}

// FlightEndPoint
struct FlightEndPoint: Codable {
    let iataCode: String
    let terminal: String?
    let at: String
}

// AircraftEquipment
struct AircraftEquipment: Codable {
    let code: String
}

// OperatingFlight
struct OperatingFlight: Codable {
    let carrierCode: String
}

// Co2Emission
struct Co2Emission: Codable {
    let weight: Int
    let weightUnit: String
    let cabin: String
}

// ExtendedPrice
struct ExtendedPrice: Codable {
    let currency: String
    let total: String
    let base: String
    let fees: [Fee]
    let taxes: [Tax]
    let refundableTaxes: String?
    let grandTotal: String
    let billingCurrency: String?
    let additionalServices: [AdditionalService]?
}

// Fee
struct Fee: Codable {
    let amount: String
    let type: String
}

// AdditionalService
struct AdditionalService: Codable {
    let amount: String
    let type: String
}

// PricingOptions
struct PricingOptions: Codable {
    let fareType: [String]
    let includedCheckedBagsOnly: Bool
    let refundableFare: Bool
    let noRestrictionFare: Bool
    let noPenaltyFare: Bool
}

// TravelerPricing
struct TravelerPricing: Codable {
    let travelerId: String
    let fareOption: String
    let travelerType: String
    let price: Price
    let fareDetailsBySegment: [FareDetailsBySegment]
}

// Price
struct Price: Codable {
    let currency: String
    let total: String
    let base: String
    let fees: [Fee]
    let taxes: [Tax]
    let refundableTaxes: String?
}

// Tax
struct Tax: Codable {
    let amount: String
    let code: String
}

// FareDetailsBySegment
struct FareDetailsBySegment: Codable {
    let segmentId: String
    let cabin: String
    let fareBasis: String
    let brandedFare: String?
    let `class`: String
    let isAllotment: Bool
    let allotmentDetails: AllotmentDetails?
    let sliceDiceIndicator: String?
    let includedCheckedBags: BaggageAllowance
}

// AllotmentDetails
struct AllotmentDetails: Codable {
    let tourName: String?
    let tourReference: String?
}

// BaggageAllowance
struct BaggageAllowance: Codable {
    let quantity: Int?
    let weight: Int?
    let weightUnit: String?
}

// Additional Models
struct SearchCriteria: Codable {
    let excludeAllotments: Bool?
    let addOneWayOffers: Bool?
    let maxFlightOffers: Int?
    let maxPrice: Int?
    let allowAlternativeFareOptions: Bool?
    let oneFlightOfferPerDay: Bool?
    let additionalInformation: AdditionalInformation?
    let pricingOptions: ExtendedPricingOptions?
    let flightFilters: FlightFilters?
}

struct AdditionalInformation: Codable {
    let chargeableCheckedBags: Bool?
    let brandedFares: Bool?
}

struct ExtendedPricingOptions: Codable {
    let includedCheckedBagsOnly: Bool
    let refundableFare: Bool
    let noRestrictionFare: Bool
    let noPenaltyFare: Bool
}

struct FlightFilters: Codable {
    let crossBorderAllowed: Bool?
    let moreOvernightsAllowed: Bool?
    let returnToDepartureAirport: Bool?
    let railSegmentAllowed: Bool?
    let busSegmentAllowed: Bool?
    let maxFlightTime: Int?
    let carrierRestrictions: CarrierRestrictions?
    let cabinRestrictions: [ExtendedCabinRestriction]?
    let connectionRestriction: ConnectionRestriction?
}

struct CarrierRestrictions: Codable {
    let blacklistedInEUAllowed: Bool
    let excludedCarrierCodes: [String]?
    let includedCarrierCodes: [String]?
}

struct ExtendedCabinRestriction: Codable {
    let cabin: String
    let originDestinationIds: [String]
    let coverage: String?
}

struct ConnectionRestriction: Codable {
    let maxNumberOfConnections: Int
    let nonStopPreferred: Bool
    let airportChangeAllowed: Bool
    let technicalStopsAllowed: Bool
}

struct OriginDestination: Codable {
    let id: String
    let originLocationCode: String
    let destinationLocationCode: String
    let departureDateTimeRange: DateTimeRange
    let originRadius: Int?
    let alternativeOriginsCodes: [String]?
    let destinationRadius: Int?
    let alternativeDestinationsCodes: [String]?
    let arrivalDateTimeRange: DateTimeRange?
}

struct DateTimeRange: Codable {
    let date: String
    let time: String?
    let dateWindow: String?
    let timeWindow: String?
}

struct TravelerInfo: Codable {
    let id: String
    let travelerType: String
    let associatedAdultId: String?
}

struct ServiceName: Codable {
    let serviceType: String
    let serviceCode: String
}

// TravelerType
enum TravelerType: String, Codable {
    case ADULT
    case CHILD
    case SENIOR
    case YOUNG
    case HELD_INFANT
    case SEATED_INFANT
    case STUDENT
}

