//
//  PlayGroundWidgetLiveActivity.swift
//  PlayGroundWidget
//
//  Created by Daniel Nielsen on 09/01/2026.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct PlayGroundWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: DeliveryActivityAttributes.self) { context in
            // Lock screen/banner UI goes here
			DeliveryLiveActivityView(
				attributes: context.attributes,
				state: context.state
			)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
					HStack {
						Image(systemName: "bag.fill")
							.foregroundColor(.orange)
						Text(context.attributes.orderNumber)
							.font(.caption)
							.fontWeight(.semibold)
					}
                }
                DynamicIslandExpandedRegion(.center) {
					Text(context.state.estimatedDeliveryTime, style: .timer)
						.font(.caption2)
						.fontWeight(.semibold)
						.foregroundColor(.secondary)
                }
                DynamicIslandExpandedRegion(.trailing) {
					Text(context.state.status.rawValue)
						.font(.caption)
						.fontWeight(.medium)
                }
				DynamicIslandExpandedRegion(.bottom) {
					HStack {
						Text(context.attributes.restaurantName)
							.font(.caption2)
						Spacer()
						Text("Driver: \(context.state.driverName)")
							.font(.caption2)
					}
					.foregroundColor(.secondary)
				}
            } compactLeading: {
				Image(systemName: "bag.fill")
					.foregroundColor(.orange)
			} compactTrailing: {
				Text(context.state.estimatedDeliveryTime, style: .timer)
					.font(.caption2)
					.fontWeight(.semibold)
			} minimal: {
				Image(systemName: "bag.fill")
					.foregroundColor(.orange)
			}
        }
    }
}

struct DeliveryLiveActivityView: View {
	let attributes: DeliveryActivityAttributes
	let state: DeliveryActivityAttributes.ContentState
	
	var body: some View {
		VStack (spacing: 12) {
			HStack {
				Image(systemName: "bag.fill")
					.foregroundStyle(.orange)
					.font(.title2)
				VStack (alignment: .leading) {
					Text("Order #\(attributes.orderNumber)")
						.font(.headline)
						.fontWeight(.semibold)
					Text("From \(attributes.restaurantName)")
						.font(.subheadline)
						.foregroundColor(.secondary)
				}
				Spacer()
				VStack(alignment: .trailing) {
					Text("ETA")
						.font(.caption)
						.foregroundStyle(.secondary)
					Text(state.estimatedDeliveryTime, style: .timer)
						.font(.headline)
						.fontWeight(.bold)
						.foregroundColor(.orange)
				}
				/// Current state:
				HStack {
					Text("\(state.status.emoji) \(state.status.rawValue)")
						.font(.subheadline)
						.fontWeight(.medium)
					Spacer()
					if state.status == .picked {
						Text("📍 \(state.currentLocation)")
							.font(.caption)
							.foregroundColor(.secondary)
					}
				}
			}
			.padding(16)
			.background(Color(UIColor.systemBackground))
			.cornerRadius(12)
			.shadow(radius: 2)
		}
	}
}

private func shouldShowProgress(current: DeliveryStatus, target: DeliveryStatus) -> Bool {
	let allCases = DeliveryStatus.allCases
	guard let currentIndex = allCases.firstIndex(of: current),
		  let targetIndex = allCases.firstIndex(of: target) else {
		return false
	}
	return currentIndex > targetIndex
}
