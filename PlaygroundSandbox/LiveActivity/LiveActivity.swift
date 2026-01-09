//
//  LiveActivity.swift
//  PlaygroundSandbox
//
//  Created by Daniel Nielsen on 09/01/2026.
//

import SwiftUI
import ActivityKit
import WidgetKit

class DeliveryTrackingManager: ObservableObject {
	@Published var currentActivity: Activity<DeliveryActivityAttributes>?
	
	func startLiveActivity (for order: Order) {
		let attributes = DeliveryActivityAttributes(
			orderNumber: order.number,
			restaurantName: order.restaurant,
			orderItems: order.items,
			deliveryAddress: order.deliveryAddress
		)
		
		let initialState = DeliveryActivityAttributes.ContentState(
			status: .confirmed,
			estimatedDeliveryTime: order.estimatedDeliveryTime,
			currentLocation: order.restaurant,
			driverName: "Driver will be assigned"
		)
		
		do {
			currentActivity = try Activity<DeliveryActivityAttributes>.request(
				attributes: attributes,
				content: .init(state: initialState, staleDate: nil),
				pushType: .token
			)
		} catch {
			print("Error starting Live Activity: \(error.localizedDescription)")
		}
	}
	
	func updateLiveActivity(status: DeliveryStatus, location: String, driver: String, eta: Date) {
		guard let activity = currentActivity else { return }
		
		let updatedState = DeliveryActivityAttributes.ContentState(
			status: status,
			estimatedDeliveryTime: eta,
			currentLocation: location,
			driverName: driver
		)
		
		Task {
			await activity.update(
				.init(state: updatedState, staleDate: nil)
			)
		}
	}
	
	func endLiveActivity() {
		guard let activity = currentActivity else { return }
		
		let finalState = DeliveryActivityAttributes.ContentState(
			status: .delivered,
			estimatedDeliveryTime: Date(),
			currentLocation: "Delivered",
			driverName: "Delivery Complete"
		)
		
		Task {
			await activity.end(
				.init(state: finalState, staleDate: nil),
				dismissalPolicy: .after(.now.addingTimeInterval(5))
			)
			
			DispatchQueue.main.async {
				self.currentActivity = nil
			}
		}
	}
}
