//
//  CalendarTestView.swift
//  CSIDAssistPlus
//
//  Created by Vince Muller on 6/17/24.
//

import SwiftUI

let columns: [GridItem] = [GridItem(.flexible()),
                           GridItem(.flexible()),
                           GridItem(.flexible()),
                           GridItem(.flexible()),
                           GridItem(.flexible()),
                           GridItem(.flexible()),
                           GridItem(.flexible())]

struct CA_CalendarDashboardView: View {

    @Binding var dashboardWeek: Date
    @Binding var selectedDay: Date
    
    var body: some View {

        HStack {
            LazyVGrid(columns: columns) {
                Image(systemName: "chevron.left")
                    .foregroundStyle(Color.black.opacity(0.3))
                    .font(.system(size: 25, weight: .semibold))
                    .onTapGesture {
                        dashboardWeek = Calendar.current.date(byAdding: .day, value: -5, to: dashboardWeek)!
                        selectedDay = Calendar.current.date(byAdding: .day, value: -5, to: dashboardWeek)!
                    }
                ForEach((1...5), id: \.self) {day in
                    let d = Calendar.current.date(byAdding: .day, value: day-3, to: dashboardWeek)!
                    let weekDay = d.formatted(.dateTime.weekday())
                    let calendarDay = d.formatted(.dateTime.day(.twoDigits))
                    let sD = selectedDay.formatted(.dateTime.weekday()) == weekDay
                    
                    ZStack {
                        sD ?
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.caTurqBlue)
                            .frame(width: 55, height: 60)
                        : nil
                        VStack {
                            Text(calendarDay)
                                .font(.system(size: 18, weight: .medium, design: .default))
                                .foregroundStyle(sD ? .white : Color.black.opacity(0.5))
                            Text(weekDay.uppercased())
                                .font(.system(size: 18, weight: .medium, design: .default))
                                .foregroundStyle(sD ? .white : Color.black.opacity(0.5))
                        }
                        .onTapGesture {
                            selectedDay = d
                            print(selectedDay.formatted())
                        }
                    }
                }
                Image(systemName: "chevron.right")
                    .foregroundStyle(Color.black.opacity(0.3))
                    .font(.system(size: 25, weight: .semibold))
                    .onTapGesture {
                        dashboardWeek = Calendar.current.date(byAdding: .day, value: 5, to: dashboardWeek)!
                        selectedDay = Calendar.current.date(byAdding: .day, value: 5, to: dashboardWeek)!
                    }
            }
        }
    }
}

//#Preview {
//    CA_CalendarDashboardView(viewModel: HomeScreenViewModel())
//}
