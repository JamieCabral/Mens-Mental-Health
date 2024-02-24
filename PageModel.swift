import Foundation

struct Page: Identifiable, Equatable {
    let id = UUID()
    var name: String
    var description: String
    var imageUrl: String
    var tag: Int
    
    static var samplePage = Page(name: "Title Example", description: "This is a sample description for the purpose of debugging", imageUrl: "burntOut", tag: 0)
    
    static var samplePages: [Page] = [
        Page(name: "Welcome to BetterMe(n)", description: "When was the last time you expressed what's on your mind?", imageUrl: "confused" , tag: 0),
        Page(name: "I'm guessing not for a while?", description: "Men are 3 times as likely to die by suicide as women", imageUrl: "burntOut", tag: 1),
        Page(name: "But we can change that", description: "BetterMe(n) is a space for you to let your feelings out, and learn that you're not alone", imageUrl: "rain", tag: 2)]
    
}
