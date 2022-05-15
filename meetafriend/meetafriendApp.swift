//
//  meetafriendApp.swift
//  meetafriend
//
//  Created by Luca on 21.03.22.
//

import Firebase
import SwiftUI

final class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        
        return true
    }
}

@main
struct meetafriendApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var sessionService = SessionServiceImpl()
    @StateObject var locationService = LocationServiceImpl()
    @StateObject var chatOverviewService = ChatOverviewServiceImpl()
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                switch sessionService.state {
                case .loggedIn:
                    switch locationService.state {
                    case .notJoined:
                        HomeView()
                            .environmentObject(sessionService)
                            .environmentObject(locationService)
                        
                    case .joined:
                        ChatOverviewView()
                            .environmentObject(sessionService)
                            .environmentObject(locationService)
                            .environmentObject(chatOverviewService)
                    }
                    
                case .loggedOut:
                    LoginView()
                }
            }
        }
    }
}
