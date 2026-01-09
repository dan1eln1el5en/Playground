//
//  ActivityAttributes.swift
//  PlaygroundSandbox
//
//  Created by Daniel Nielsen on 09/01/2026.
//

import ActivityKit
import Foundation

struct DeliveryActivityAttributes: ActivityAttributes {
	/// Dynamic content that updates
	public struct ContentState: Codable, Hashable {
		var status: DeliveryStatus
		var estimatedDeliveryTime: Date
		var currentLocation: String
		var driverName: String
	}
	
	/// Static content that doesn't update
	var orderNumber: String
	var restaurantName: String
	var orderItems: [String]
	var deliveryAddress: String
}

enum DeliveryStatus: String, CaseIterable, Codable {
	case confirmed = "Order confirmed"
	case preparing = "Food is being prepared"
	case ready = "Your food is ready, waiting for pickup"
	case picked = "Your food is out for delivery"
	case delivered = "Your food was delivered"
	
	var emoji: String {
		switch self {
			case .confirmed: return "✅"
			case .preparing: return "🧑🏻‍🍳"
			case .ready: return "🥡"
			case .picked: return "🚚"
			case .delivered: return "🎉"
		}
	}
}
