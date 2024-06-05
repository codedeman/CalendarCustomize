
import SwiftUI

public struct CalendarView: View {
    @Binding public var selectedDate: Date?
    private var colorSelected: Color
    private var colorUnSelected: Color

    public init(
        selectedDate: Binding<Date?>,
        colorSelected: Color = .blue,
        colorUnSelected: Color = .clear
    ) {
        self.colorSelected = colorSelected
        self.colorUnSelected = colorUnSelected
        self._selectedDate = selectedDate
    }

    public var body: some View {
            VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Spacer()
                Button(action: {
                    selectedDate = Calendar.current.date(
                        byAdding: .month,
                        value: -1,
                        to: selectedDate ?? Date()
                    )
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.gray)
                }
                Text(selectedDate.map {
                    DateFormatter().monthSymbols[
                        Calendar.current.component(.month, from: $0) - 1] + " " + String(
                        Calendar.current.component(.year, from: $0)
                    )
                } ?? "")
                    .font(.title2)
                    .fontWeight(.bold)
                Button(action: {
                    selectedDate = Calendar.current.date(byAdding: .month, value: 1, to: selectedDate ?? Date())
                }) {
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
                Spacer()

            }.padding(.top)

            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7)) {
                ForEach(CalendarHelper.getCalendarGrid(for: selectedDate ?? Date()), id: \.self) { row in
                    ForEach(row, id: \.self) { date in
                        if let date = date {
                            Text(
                                Calendar.current.isDate(date, inSameDayAs: Date()) ? "Today" : String(
                                    Calendar.current.component(.day, from: date)
                                )
                            )
                            .frame(
                                width: 50,
                                height: 60
                            )
                            .foregroundColor(
                                selectedDate.flatMap {
                                    Calendar.current.isDate(date, inSameDayAs: $0) ? .white : .black } ?? .black)
                            .background(selectedDate.flatMap { Calendar.current.isDate(date, inSameDayAs: $0) ? colorSelected : colorUnSelected } ?? .clear)
                            .cornerRadius(15)
                            .onTapGesture {
                                selectedDate = date
                            }
                        } else {
                            Text("")
                                .frame(maxWidth: .infinity)
                        }
                    }
                }.frame(maxHeight: .infinity)
            }
            Spacer()
        }

    }
}

struct CalendarView_Previews: PreviewProvider {
    @State static var selectedDate: Date? = Date()

    static var previews: some View {
        CalendarView(selectedDate: $selectedDate)
    }
}

public class CalendarViewController: UIViewController {
    
}
