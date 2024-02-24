import SwiftUI

@main
struct MyApp: App {
    @State var textFieldText: String = ""
    @State private var isFirstLaunch = UserDefaults.standard.bool(forKey: "isFirstLaunch")
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            SplashScreen()
                .environment(\.managedObjectContext, dataController.container.viewContext)
            
        }
    }
}
