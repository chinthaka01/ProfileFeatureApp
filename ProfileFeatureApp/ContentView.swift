//
//  ContentView.swift
//  ProfileFeatureApp
//
//  Created by Chinthaka Perera on 12/22/25.
//

import SwiftUI
import PlatformKit

/// Minimal host view for the Profile feature demo app.
///
/// Embeds a single `MicroFeature` (the Profile feature) so it can be
/// run and tested in isolation from the main shell application.
struct ContentView: View {
    
    /// The profile micro feature provided by the app entry point.
    let feature: MicroFeature
    
    var body: some View {

        // Render the feature's root SwiftUI view with some outer padding
        // to keep it visually separated from the screen edges.
        feature.makeRootView()
        .padding()
    }
}
