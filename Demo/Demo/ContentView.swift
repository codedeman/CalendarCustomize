import SwiftUI
import Combine
import CalendarCustomize

enum CalendarType {
    case single
    case basic
    case multiple
}

class CalendarViewModel: ObservableObject {
    @Published var selectedDate: Date? = Date()
    @Published var selectedEndDate: Date? = nil
    func resetSelectedDate() {
        selectedDate = Date()
        selectedEndDate = nil
    }
}

struct Items: Identifiable {
    var id = UUID()
    var title: String
    var type: CalendarType
}

struct ContentView: View {
    @StateObject private var viewModel = CalendarViewModel()

    var items: [Items] = [
        Items(
            title: "Calendar Basic",
            type: .basic
        ),
        Items(
            title: "Calendar Single Column",
            type: .single
        ),
        Items(
            title: "Calendar Mutiple Select",
            type: .multiple
        )
    ]

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(items) { item in
                        NavigationLink(
                            destination: destinationView(for: item.type)
                                .environmentObject(viewModel)
                                .onDisappear(perform: {
                                    viewModel.resetSelectedDate()
                                })
                        ) {
                            Text(item.title)
                        }
                    }
                }
            }
            .padding()
            .navigationTitle("Calendar Options")
        }
    }

    @ViewBuilder
    private func destinationView(for type: CalendarType) -> some View {
        switch type {
        case .basic:
            CalendarCustomizeViewBasic(
                selectedDate: $viewModel.selectedDate,
                selectedEndDate: .constant(nil)
            )
        case .multiple:
            CalendarCustomizeViewBasic(
                selectedDate: $viewModel.selectedDate,
                selectedEndDate: $viewModel.selectedEndDate,
                config: .init(width: 60, height: 70, calendarType: .multiple)
            )
        case .single:
            CalendarCustomizeSingleColumnView(
                selectedDate: $viewModel.selectedDate
            )
        }

    }
}

// Preview provider for ContentView
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
