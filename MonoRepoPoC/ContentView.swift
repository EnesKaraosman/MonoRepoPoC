//
//  ContentView.swift
//  MonoRepoPoC
//
//  Created by Enes Karaosman on 6.01.2024.
//

import SwiftUI
import DI
import Swinjector
import MonoRepoLogger

struct ContentView: View {
    @Injected(Logger.self) private var logger
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            logger().i("Access by annotation")
            getIt(Logger.self)?.i("Access by getIt directly")
        }
    }
}

#Preview {
    ContentView()
}
