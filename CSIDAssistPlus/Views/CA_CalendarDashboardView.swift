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
    @StateObject var viewModel: HomeScreenViewModel
    
    var body: some View {
        (viewModel.expandSearch ? nil :
        HStack {

            LazyVGrid(columns: columns) {
                Image(systemName: "chevron.left")
                    .foregroundStyle(Color.black.opacity(0.3))
                    .font(.system(size: 25, weight: .semibold))
                    .onTapGesture {
                        viewModel.dashboardWeek = Calendar.current.date(byAdding: .day, value: -5, to: viewModel.dashboardWeek)!
                    }
                ForEach((1...5), id: \.self) {day in
                    let d = Calendar.current.date(byAdding: .day, value: day-1, to: viewModel.dashboardWeek)!
                    let weekDay = d.formatted(.dateTime.weekday())
                    let calendarDay = d.formatted(.dateTime.day(.twoDigits))
                    
                    VStack {
                        Text(calendarDay)
                            .font(.system(size: 18, weight: .medium, design: .default))
                            .foregroundStyle(Color.black.opacity(0.5))
                        Text(weekDay.uppercased())
                            .font(.system(size: 18, weight: .medium, design: .default))
                            .foregroundStyle(Color.black.opacity(0.5))
                    }
                }
                Image(systemName: "chevron.right")
                    .foregroundStyle(Color.black.opacity(0.3))
                    .font(.system(size: 25, weight: .semibold))
                    .onTapGesture {
                        viewModel.dashboardWeek = Calendar.current.date(byAdding: .day, value: 5, to: viewModel.dashboardWeek)!
                    }
            }
        })
    }
}

#Preview {
    CA_CalendarDashboardView(viewModel: HomeScreenViewModel())
}
