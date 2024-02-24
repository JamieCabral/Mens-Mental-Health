import SwiftUI

enum Tabby: String, CaseIterable {
    case journal
    case home
    case emotion
}

struct ContentView: View {
    @State private var selectedTab: Tabby = .home
    @State var textFieldText: String = ""
    @StateObject private var userData = UserData()
    
    private var tabbyColor: Color {
        switch selectedTab {
        case .journal:
            return .blue
        case .home:
            return .green
        case .emotion:
            return .red
        }
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            JournalView()
                .environmentObject(userData)
                .tabItem {
                    VStack {
                        Image(systemName: "book")
                            .foregroundColor(selectedTab == .journal ? tabbyColor : .gray)
                            .scaleEffect(selectedTab == .journal ? 1.25 : 1.0)
                        Text("Journal")
                    }
                }
                .tag(Tabby.journal)
            
            HomeView()
                .environmentObject(userData)
                .tabItem {
                    VStack {
                        Image(systemName: "house")
                        Text("Home")
                            .foregroundColor(selectedTab == .home ? tabbyColor : .gray)
                            .scaleEffect(selectedTab == .home ? 1.25 : 1.0)
                    }
                }
                .tag(Tabby.home)
            
            EmotionsView()
                .tabItem {
                    VStack {
                        Image(systemName: "brain")
                            .foregroundColor(selectedTab == .emotion ? tabbyColor : .gray)
                        Text("Emotions")
                    }
                }
                .tag(Tabby.emotion)
        }
    }
}

