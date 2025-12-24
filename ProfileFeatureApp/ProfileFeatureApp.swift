//
//  ProfileFeatureApp.swift
//  ProfileFeatureApp
//
//  Created by Chinthaka Perera on 12/22/25.
//

import SwiftUI
import PlatformKit
import ProfileFeature

@main
struct ProfileFeatureApp: App {
    let analytics = AnalyticsImpl()
    let profileAPI = ProfileFeatureAPIClient()
    let profileDependencies: ProfileDependenciesImpl
    let profileFactory: ProfileFeatureFactory
    let feature: MicroFeature
    
    init() {
        profileDependencies = ProfileDependenciesImpl(profileAPI: profileAPI, analytics: analytics)
        profileFactory = ProfileFeatureFactory(dependencies: profileDependencies)
        feature = profileFactory.makeFeature()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(feature: feature)
        }
    }
}
