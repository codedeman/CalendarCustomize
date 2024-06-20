import SwiftUI

public struct CalendarSingleColumnView: View {

    @Binding public var selectedDate: Date?
    private var colorSelected: Color
    private var colorUnSelected: Color
    @State private var currentMonth: Date = Date()
    @State private var isLoadingNextMonth = false
    @State private var hasLoadedInitially = false
    @State private var hasScrolledToEnd = false
    @State private var isViewLoaded = false
    @State private var dates: [DateModel] = []

    public init(
        selectedDate: Binding<Date?>,
        colorSelected: Color = .red,
        colorUnSelected: Color = .blue.opacity(0.5)
    ) {
        self._selectedDate = selectedDate
        self.colorSelected = colorSelected
        self.colorUnSelected = colorUnSelected
        self._dates = State(
            initialValue: CalendarHelper.getCalendarGrid(
                for: selectedDate.wrappedValue ?? Date()
            ).flatMap { $0.map { DateModel(date: $0) } }
        )

    }

    public var body: some View {
        VStack {
            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(dates) { dateModel in
                            if let date = dateModel.date {
                                DateView(
                                    date: date,
                                    isSelected: Calendar.current.isDate(date, inSameDayAs: selectedDate ?? Date()),
                                    colorSelected: colorSelected,
                                    colorUnSelected: colorUnSelected
                                ) {
                                    selectedDate = date
                                }
                                .id(date)
                            }
                        }

                        GeometryReader { geometry in
                            Color.clear
                                .preference(
                                    key: ScrollOffsetPreferenceKey.self,
                                    value: geometry.frame(in: .global).maxX
                                )
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
                    }
                }
            }
        }
        .onAppear {
            updateDates()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                isViewLoaded = true
            }
        }
    }


    private func updateDates() {
        let newdate = CalendarHelper.getCalendarGrid(for: currentMonth)
        dates.append(contentsOf: newdate.flatMap{
            $0.map{DateModel(date: $0)}
        })
    }

    private func loadNextMonth() {
        guard !isLoadingNextMonth else { return }
        isLoadingNextMonth = true

        guard let nextMonth = Calendar.current.date(
            byAdding: .month,
            value: 1,
            to: currentMonth
        ) else { return }

        currentMonth = nextMonth
        updateDates()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            isLoadingNextMonth = false
        }
    }
}

struct CalendarSingleColumnView_Previews: PreviewProvider {
    @State static var selectedDate: Date? = Date()
    static var previews: some View {
        CalendarSingleColumnView(
            selectedDate: $selectedDate
        )
    }
}
