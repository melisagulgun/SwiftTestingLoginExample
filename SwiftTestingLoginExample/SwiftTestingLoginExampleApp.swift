//
//  SwiftTestingLoginExampleApp.swift
//  SwiftTestingLoginExample
//
//  Created by Melisa Gülgün on 31.07.2024.
//

import SwiftUI

@main
struct SwiftTestingLoginExampleApp: App {
    @State var password: String = ""
    @State var email: String = ""
    var body: some Scene {
        WindowGroup {
            ContentView(emailText: $email, passwordText: $password)
        }
    }
}
