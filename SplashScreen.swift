import SwiftUI

struct SplashScreen: View {
    @State private var pageIndex = 0
    private let pages: [Page] = Page.samplePages
    private let dotAppearance = UIPageControl.appearance()
    
    var body: some View {
        NavigationView {
            TabView(selection: $pageIndex) {
                ForEach(pages) { page in
                    VStack {
                        Spacer()
                        PageView(page: page)
                        Spacer()
                        if page == pages.last {
                            NavigationLink(destination: ContentView()) {
                                Text("Enter")
                            }
                            .buttonStyle(BorderedButtonStyle()) // Assuming custom button style
                            .padding()
                        } else {
                            Button("Next", action: { incrementPage() })
                                .buttonStyle(BorderedButtonStyle()) // Assuming custom button style
                                .padding()
                        }
                        Spacer()
                    }
                    .tag(page.tag)
                }
            }
            .animation(.easeInOut, value: pageIndex)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .onAppear {
                dotAppearance.currentPageIndicatorTintColor = .black
                dotAppearance.pageIndicatorTintColor = .gray
            }
        }
    }

    func incrementPage() {
        pageIndex += 1
    }
}


