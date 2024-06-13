import SwiftUI

public struct CalendarSingleColumnView: View {
    @Binding public var selectedDate: Date?
    private var colorSelected: Color
    private var colorUnSelected: Color
    @State private var currentMonth: Date = Date()
    @State private var dates: [[Date?]] = []
    @State private var scrollViewOffset: CGFloat = .zero

    public init(
        selectedDate: Binding<Date?>,
        colorSelected: Color = .primary,
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
                ScrollViewReader { scrollViewProxy in
                    HStack(spacing: 10) {
                        ForEach(Array(dates.joined()), id: \.self) { date in
                            if let date = date {
                                Text(Calendar.current.isDate(date, inSameDayAs: Date()) ? "Today" : "\(Calendar.current.component(.day, from: date))")
                                    .frame(width: 50, height: 60)
                                    .foregroundColor(self.dateTextColor(for: date))
                                    .background(self.dateBackgroundColor(for: date))
                                    .cornerRadius(15)
                                    .onTapGesture {
                                        selectedDate = date
                                    }
                            }
                        }
                    }
                    .background(GeometryReader { geometry -> Color in
                        let minX = geometry.frame(in: .named("scrollView")).minX
                        DispatchQueue.main.async {
                            if minX < scrollViewOffset {
                                // The scroll view is scrolling right
                                if let lastDate = dates.joined().last, lastDate == dates.joined().last {
                                    loadNextMonth()
                                }
                            }
                            scrollViewOffset = minX
                        }
                        return Color.clear
                    })
                }
                .coordinateSpace(name: "scrollView")
            }
            Spacer()
        }
        .onAppear {
            updateDates()
        }
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
        guard let nextMonth = Calendar.current.date(byAdding: .month, value: 1, to: currentMonth) else { return }
        currentMonth = nextMonth
        updateDates()
    }
}

struct CalendarSingleColumnView_Previews: PreviewProvider {
    @State static var selectedDate: Date? = Date()

    static var previews: some View {
        CalendarSingleColumnView(selectedDate: $selectedDate)
    }
}
