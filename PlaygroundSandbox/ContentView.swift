//
//  ContentView.swift
//  PlaygroundSandbox
//
//  Created by Daniel Nielsen on 08/03/2025.
//

import ImagePlayground
import SwiftUI

struct ContentView: View {
	@State private var activityManager = DeliveryTrackingManager()
	
	@State private var description = "Dog in a party hat"
	@State private var images = [Image]()
	
    var body: some View {
        VStack {
			
			TextField("Type something", text: $description)
				.textFieldStyle(.roundedBorder)
				.padding()
			
			Button("Make") {
				Task(operation: makeImages)
			}
			
			ForEach(images.indices, id: \.self) {
				images[$0]
					.resizable()
					.frame(width: 200, height: 200)
			}
        }
        .padding()
    }
	
	func makeImages() async {
		do {
			let creator = try await ImageCreator()
			let results = creator.images(for: [.text(description)], style: .animation, limit: 4)
			
			images.removeAll()
			
			for try await result in results {
				let cgImage = result.cgImage
				let image = Image(cgImage, scale: 1, label: Text(description))
				images.append(image)
			}
		} catch {
			print(error.localizedDescription)
		}
	}
}

