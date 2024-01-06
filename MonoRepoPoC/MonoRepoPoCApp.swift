//
//  MonoRepoPoCApp.swift
//  MonoRepoPoC
//
//  Created by Enes Karaosman on 6.01.2024.
//

import SwiftUI
import MonoRepoLogger
import DI

@main
struct MonoRepoPoCApp: App {
    init() {
        let injectionModules: [FeatureResolver] = [LoggerPackageResolver()]
        
        for module in injectionModules {
            module.moduleInjection?.registerDependencies(injector: getIt)
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
