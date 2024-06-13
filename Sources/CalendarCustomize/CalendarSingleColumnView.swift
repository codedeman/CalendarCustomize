import SwiftUI

struct ScrollOffsetPreferenceKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

public struct CalendarSingleColumnView: View {
    @Binding public var selectedDate: Date?
    private var colorSelected: Color
    private var colorUnSelected: Color
    @State private var currentMonth: Date = Date()
    @State private var dates: [[Date?]] = []
    @State private var isLoadingNextMonth = false
    @State private var hasAppeared = false
    private let loadThreshold: CGFloat = 100 // Adjust this value to your needs

    public init(
        selectedDate: Binding<Date?>,
        colorSelected: Color = .red,
        colorUnSelected: Color = .blue
    ) {
        self._selectedDate = selectedDate
        self.colorSelected = colorSelected
        self.colorUnSelected = colorUnSelected
        self._dates = State(initialValue: CalendarHelper.getCalendarGrid(for: selectedDate.wrappedValue ?? Date()))
    }

    public var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(Array(dates.joined()), id: \.self) { date in
                        if let date = date {
                            VStack {
                                Text(CalendarHelper.weekdaySymbol(for: date))
                                    .font(.caption)
                                    .foregroundColor(.black)
                                    .fixedSize(horizontal: true, vertical: false)
                                Text(dateDisplayText(for: date))
                                    .padding(.horizontal)
                                    .fixedSize(horizontal: true, vertical: true)
                            }
                            .frame(height: 70)
                            .foregroundColor(dateTextColor(for: date))
                            .background(dateBackgroundColor(for: date))
                            .cornerRadius(15)
                            .padding(.vertical, 5)
                            .onTapGesture {
                                selectedDate = date
                            }
                            .frame(minWidth: 0, maxWidth: .infinity)
                        }
                    }
                    GeometryReader { geometry in
                        Color.clear.preference(key: ScrollOffsetPreferenceKey.self, value: geometry.frame(in: .global).maxX)
                    }
                    .frame(width: 1, height: 1)
                }
                .padding(.horizontal)
            }
            .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                guard hasAppeared else { return }
                let contentWidth = UIScreen.main.bounds.width // Adjust this if you have a different content width
                let offsetThreshold = contentWidth - loadThreshold
                if !isLoadingNextMonth && value >= offsetThreshold {
                    loadNextMonth()
                }
            }
            Spacer()
        }
        .onAppear {
            updateDates()
            hasAppeared = true
        }
    }

    private func dateDisplayText(for date: Date) -> String {
        let day = Calendar.current.component(.day, from: date)
        let month = Calendar.current.shortStandaloneMonthSymbols[Calendar.current.component(.month, from: date)-1]
        return Calendar.current.isDate(date, inSameDayAs: Date()) ? "Today" : "\(day) \(month)"
    }

    private func dateTextColor(for date: Date) -> Color {
        if let selectedDate = selectedDate, Calendar.current.isDate(date, inSameDayAs: selectedDate) {
            return .white
        } else {
            return .black
        }
    }

    private func dateBackgroundColor(for date: Date) -> Color {
        if let selectedDate = selectedDate, Calendar.current.isDate(date, inSameDayAs: selectedDate) {
            return colorSelected
        } else {
            return colorUnSelected
        }
    }

    private func updateDates() {
        dates = CalendarHelper.getCalendarGrid(for: currentMonth)
    }

    private func loadNextMonth() {
        guard !isLoadingNextMonth else { return }
        isLoadingNextMonth = true
        guard let nextMonth = Calendar.current.date(byAdding: .month, value: 1, to: currentMonth) else { return }
        print("Loading next month: \(nextMonth)")
        currentMonth = nextMonth
        updateDates()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { // Simulate loading delay
            isLoadingNextMonth = false
        }
    }
}


struct CalendarSingleColumnView_Previews: PreviewProvider {
    @State static var selectedDate: Date? = Date()

    static var previews: some View {
        CalendarSingleColumnView(selectedDate: $selectedDate)
    }
}
