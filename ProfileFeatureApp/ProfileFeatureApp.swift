//
//  ProfileFeatureApp.swift
//  ProfileFeatureApp
//
//  Created by Chinthaka Perera on 12/22/25.
//

import SwiftUI
import PlatformKit
import ProfileFeature

// Standalone demo host for the Profile feature.
///
/// Composes the platform dependencies and launches only the
/// Profile micro feature, without the full Wefriendz shell UI.
@main
struct ProfileFeatureApp: App {
    
    /// Shared analytics implementation for this demo app.
    let analytics = AnalyticsImpl()
    
    /// Shared networking implementation used by the profile API client.
    let networking = NetworkingImpl()
    
    /// Concrete API client used by the Profile feature.
    let profileAPI: ProfileFeatureAPIClient
    
    /// Dependency container injected into the Profile feature factory.
    let profileDependencies: ProfileDependenciesImpl
    
    /// Factory responsible for creating the Profile micro feature.
    let profileFactory: ProfileFeatureFactory
    
    /// The Profile `MicroFeature` instance rendered by this app.
    let feature: MicroFeature
    
    init() {
        profileAPI = ProfileFeatureAPIClient(networking: networking)
        profileDependencies = ProfileDependenciesImpl(profileAPI: profileAPI, analytics: analytics)
        profileFactory = ProfileFeatureFactory(dependencies: profileDependencies)
        feature = profileFactory.makeFeature()
    }
    
    var body: some Scene {
        WindowGroup {
            
            // Minimal host view that embeds only the Profile feature.
            ContentView(feature: feature)
        }
    }
}
