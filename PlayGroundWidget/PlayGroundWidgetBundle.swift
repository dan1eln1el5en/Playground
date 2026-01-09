//
//  PlayGroundWidgetBundle.swift
//  PlayGroundWidget
//
//  Created by Daniel Nielsen on 09/01/2026.
//

import WidgetKit
import SwiftUI

@main
struct PlayGroundWidgetBundle: WidgetBundle {
    var body: some Widget {
        PlayGroundWidget()
        PlayGroundWidgetControl()
        PlayGroundWidgetLiveActivity()
    }
}
