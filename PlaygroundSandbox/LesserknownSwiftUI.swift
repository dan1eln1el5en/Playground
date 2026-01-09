//
//  LesserknownSwiftUI.swift
//  PlaygroundSandbox
//
//  Created by Daniel Nielsen on 08/01/2026.
//

import SwiftUI

struct LesserknownSwiftUI: View {
	var body: some View {
		
		ZStack {
			Circle()
				.fill(Color(red: 1, green: 0, blue: 0))
				.frame(width: 300, height: 300)
				.offset(x: 0, y: 100)
			Circle()
				.fill(Color(red: 0, green: 1, blue: 0))
				.frame(width: 300, height: 300)
				.offset(x: 100, y: -100)
			Circle()
				.fill(Color(red: 0, green: 0, blue: 1))
				.frame(width: 300, height: 300)
				.offset(x: -100, y: -100)
		}
		.drawingGroup()
		.opacity(0.25)
	}
}

#Preview {
	LesserknownSwiftUI()
}

