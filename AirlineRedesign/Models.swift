//
//  Models.swift
//  AirlineRedesign
//
//  Created by Logan Petree on 7/9/24.
//

import Foundation

struct Destination: Identifiable {
    var id = UUID()
    var title: String
    var description: String
    var price: Double?
    var image: String
    var buttonText: String?
    var buttonURL: String? 
}

struct Airport: Identifiable {
    var id = UUID()
    var code: String
    var city: String
    var state: String
}
