// JournalView

import SwiftUI
import NaturalLanguage

class UserData: ObservableObject {
    @Published var dataArray: [String] = []
}

struct JournalView: View {
    @EnvironmentObject var userData: UserData
    @State private var textFieldText: String = ""
    @Environment(\.managedObjectContext) var moc

    var body: some View {
        NavigationView {
            VStack {
                Text("In a world that encourages men to contain their feelings, it is vital that you have a space to let them out. Anything you enter here is only visible to you.")
                    .bold()
                    .padding(.bottom, 25)

                TextField("Type something here", text: $textFieldText, axis: .vertical)
                    .padding()
                    .background(Color.gray.opacity(0.3).cornerRadius(10))
                    .foregroundColor(.black)
                    .font(.headline)

                Button(action: {
                    if textIsAppropriate() {
                        saveText()
                    }
                }, label: {
                    Text("Save".uppercased())
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(textIsAppropriate() ? Color.blue : Color.gray)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .font(.headline)
                })
                .disabled(!textIsAppropriate())
                .padding()
                Spacer()
            }
            .navigationTitle("Your Space")
            .padding()
        }
        .padding()
    }
    
    func textIsAppropriate() -> Bool {
        return textFieldText.count > 0
    }

    func saveText() {
        // Save to Core Data
        let entry = JournalData(context: moc)
        entry.textEntered = textFieldText
        entry.date = Date()
        
        // Calculate sentiment score
        
        let tagger = NLTagger(tagSchemes: [.sentimentScore])
        tagger.string = textFieldText

        let (sentiment, _) = tagger.tag(at: textFieldText.startIndex, unit: .paragraph, scheme: .sentimentScore)
        let sentimentScore = Double(sentiment?.rawValue ?? "0") ?? 0

        
        entry.sentimentScore = sentimentScore
        
        try? moc.save()
        
        // Append to userData after saving to Core Data
        userData.dataArray.append(textFieldText)
        textFieldText = ""

        // Close the keyboard
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let keyWindow = windowScene.windows.first(where: { $0.isKeyWindow }) {
            keyWindow.endEditing(true)
        }

    }
}

// HomeView

struct HomeView: View {
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \JournalData.date, ascending: false)]) var textEntries: FetchedResults<JournalData>
    @Environment(\.managedObjectContext) var moc

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(textEntries, id: \.self) { entry in
                        VStack {
                            let formattedDate = formatDate(entry.date ?? Date())
                            Text("\(formattedDate)\n\n Positivity Score: \(String(format: "%.2f", entry.sentimentScore))\n\n \(entry.textEntered ?? "")")
                                .foregroundColor(.white)
                                .font(.headline)
                                .padding(10)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.gray)
                                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                                )
                                .frame(maxWidth: .infinity)
                                .padding(.horizontal)
                            // Button to delete the entry
                            Button(action: {
                                deleteEntry(entry)
                            }, label: {
                                Text("Delete")
                                    .foregroundColor(.red)
                            })
                            
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("You")
            
        }
    }

    // Function to format the date
    private func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        return dateFormatter.string(from: date)
    }
    
    private func deleteEntry(_ entry: JournalData) {
        // Delete the entry
        moc.delete(entry)
        
        //Save the managed object context
        do {
            try moc.save()
        } catch {
            print("Error saving context after deleting: \(error)")
        }
    }
}

//THIRD PAGE

struct EmotionsView: View {
    let emotionsList = ["Stressed","Jealous", "Angry","Remorseful", "Sad","Guilty", "Undervalued","Lonely", "Happy"]
    @State var buttonCounter = 0
    @State private var selectedButton: Int? = nil
    @State var showSheet: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("This space is dedicated to providing support and promoting open conversations about well-being among men. You're not alone on this journey – together, we're rewriting the narrative of men's mental health.")
                    .bold()
                    .padding(.top,20)
                    .padding(.bottom,20)
                    .padding(.horizontal)
                VStack(spacing: 15) {
                    ForEach(0..<3) { row in
                        HStack(spacing: 15) {
                            ForEach(0..<3) { column in
                                let index = row * 3 + column
                                Button(action: {
                                    selectedButton = index
                                    showSheet.toggle()
                                }) {
                                    Text(emotionsList[index])
                                        .foregroundColor(.white)
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 100)
                                        .background(Color.gray)
                                        .cornerRadius(10)
                                        .lineLimit(1)
                                        .minimumScaleFactor(0.5)
                                        .allowsTightening(true)
                                }
                                .sheet(isPresented: Binding(
                                    get: {showSheet && selectedButton == index},
                                    set: {showSheet = $0}
                                ), content: {
                                    EmotionsSheetView(emotion:emotionsList[index])
                                })
                            }
                        }
                    }
                }
                .padding(10)
                Spacer()
            }
            .navigationTitle("How are you feeling?")
        }
    }
}
