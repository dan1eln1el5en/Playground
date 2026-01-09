//
//  DataModel.swift
//  PlaygroundSandbox
//
//  Created by Daniel Nielsen on 09/01/2026.
//

import Foundation

struct Order {
	let number: String
	let restaurant: String
	let items: [String]
	let date: Date
	let deliveryAddress: String
	let estimatedDeliveryTime: Date = .now
}

