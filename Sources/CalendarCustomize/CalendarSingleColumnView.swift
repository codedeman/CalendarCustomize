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
    @State private var hasLoadedInitially = false
    @State private var hasScrolledToEnd = false
    @State private var isViewLoaded = false

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
            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(Array(dates.joined()), id: \.self) { date in
                            if let date = date {
                                DateView(date: date, isSelected: Calendar.current.isDate(date, inSameDayAs: selectedDate ?? Date()), colorSelected: colorSelected, colorUnSelected: colorUnSelected) {
                                    selectedDate = date
                                    proxy.scrollTo(date, anchor: .leading)
                                }
                                .id(date)
                            }
                        }

                        GeometryReader { geometry in
                            Color.clear
                                .preference(key: ScrollOffsetPreferenceKey.self, value: geometry.frame(in: .global).maxX)
                        }
                        .frame(width: 1, height: 1)
                    }
                    .padding(.horizontal)
                    .onPreferenceChange(ScrollOffsetPreferenceKey.self) { maxX in
                        if isViewLoaded && !hasScrolledToEnd && maxX < UIScreen.main.bounds.width {
                            loadNextMonth()
                            hasScrolledToEnd = true
                        }
                    }
                    .onChange(of: dates) { _ in
                        hasScrolledToEnd = false
                        if let firstDate = dates.joined().compactMap({ $0 }).first {
                            proxy.scrollTo(firstDate, anchor: .leading)
                        }
                    }
                }
            }
            Spacer()
        }
        .onAppear {
            updateDates()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                isViewLoaded = true
            }
        }
    }


    private func updateDates() {
        dates = CalendarHelper.getCalendarGrid(for: currentMonth)
    }

    private func loadNextMonth() {
        guard !isLoadingNextMonth else { return }
        isLoadingNextMonth = true
        guard let nextMonth = Calendar.current.date(byAdding: .month, value: 1, to: currentMonth) else { return }
        currentMonth = nextMonth
        updateDates()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            isLoadingNextMonth = false
        }
    }
}

struct DateView: View {
    let date: Date
    let isSelected: Bool
    let colorSelected: Color
    let colorUnSelected: Color
    let action: () -> Void

    var body: some View {
        VStack {
            Text(CalendarHelper.weekdaySymbol(for: date))
                .font(.caption)
                .foregroundColor(.black)
            Text(CalendarHelper.dateDisplayText(for: date))
                .padding(.horizontal)
        }
        .frame(height: 70)
        .foregroundColor(isSelected ? .white : .black)
        .background(isSelected ? colorSelected : colorUnSelected)
        .cornerRadius(15)
        .onTapGesture(perform: action)
    }
}

struct CalendarSingleColumnView_Previews: PreviewProvider {
    @State static var selectedDate: Date? = Date()

    static var previews: some View {
        CalendarSingleColumnView(selectedDate: $selectedDate)
    }
}
