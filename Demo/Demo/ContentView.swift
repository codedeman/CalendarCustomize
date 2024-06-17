import SwiftUI
import CalendarCustomize

enum CalendarType {
    case single
    case basic
}

struct Items: Identifiable {
    var id: UUID = UUID() // This will give each instance a unique id by default
    var title: String = ""
    var type: CalendarType = .basic
}

struct ContentView: View {
    @State private var selectedDate: Date?
    var items: [Items] = [
        .init(
            title: "Calendar Basic",
            type: .basic
        ),
        .init(
            title: "Calendar Single Column",
            type: .single
        )
    ]

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(items) { item in
                        if item.type == .basic {
                            NavigationLink(destination: CalendarViewBasic(selectedDate: $selectedDate)) {
                                Text(item.title)
                            }
                        } else {
                            NavigationLink(destination: CalendarSingleColumnView(selectedDate: $selectedDate)) {
                                Text(item.title)
                            }
                        }
                    }
                }
            }
            .padding()
        }
    }
}

// Preview provider for ContentView
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
