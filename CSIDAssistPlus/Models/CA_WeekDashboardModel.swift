//
//  CA_WeekDashboardModel.swift
//  CSIDAssistPlus
//
//  Created by Vince Muller on 6/16/24.
//

import Foundation

struct CA_WeekDashboardModel: Hashable, Identifiable {
    
    let id = UUID()
    let dayOfWeek: String
    let calendarDay: Int
    
}

let calendarData = [
    CA_WeekDashboardModel(dayOfWeek: "SUN", calendarDay: 01),
    CA_WeekDashboardModel(dayOfWeek: "MON", calendarDay: 02),
    CA_WeekDashboardModel(dayOfWeek: "TUE", calendarDay: 03),
    CA_WeekDashboardModel(dayOfWeek: "WED", calendarDay: 04),
    CA_WeekDashboardModel(dayOfWeek: "THU", calendarDay: 05),
    CA_WeekDashboardModel(dayOfWeek: "FRI", calendarDay: 06),
    CA_WeekDashboardModel(dayOfWeek: "SAT", calendarDay: 07),
    CA_WeekDashboardModel(dayOfWeek: "SUN", calendarDay: 08),
    CA_WeekDashboardModel(dayOfWeek: "MON", calendarDay: 09),
    CA_WeekDashboardModel(dayOfWeek: "TUE", calendarDay: 10),
    CA_WeekDashboardModel(dayOfWeek: "WED", calendarDay: 11),
    CA_WeekDashboardModel(dayOfWeek: "THU", calendarDay: 12),
    CA_WeekDashboardModel(dayOfWeek: "FRI", calendarDay: 13),
    CA_WeekDashboardModel(dayOfWeek: "SAT", calendarDay: 14),
    CA_WeekDashboardModel(dayOfWeek: "SUN", calendarDay: 15),
    CA_WeekDashboardModel(dayOfWeek: "MON", calendarDay: 16),
    CA_WeekDashboardModel(dayOfWeek: "TUE", calendarDay: 17),
    CA_WeekDashboardModel(dayOfWeek: "WED", calendarDay: 18),
    CA_WeekDashboardModel(dayOfWeek: "THU", calendarDay: 19),
    CA_WeekDashboardModel(dayOfWeek: "FRI", calendarDay: 20),
    CA_WeekDashboardModel(dayOfWeek: "SAT", calendarDay: 21),
    CA_WeekDashboardModel(dayOfWeek: "SUN", calendarDay: 21),
    CA_WeekDashboardModel(dayOfWeek: "MON", calendarDay: 22),
    CA_WeekDashboardModel(dayOfWeek: "TUE", calendarDay: 23),
    CA_WeekDashboardModel(dayOfWeek: "WED", calendarDay: 24),
    CA_WeekDashboardModel(dayOfWeek: "THU", calendarDay: 25),
    CA_WeekDashboardModel(dayOfWeek: "FRI", calendarDay: 26),
    CA_WeekDashboardModel(dayOfWeek: "SAT", calendarDay: 27),
    CA_WeekDashboardModel(dayOfWeek: "SUN", calendarDay: 28),
    CA_WeekDashboardModel(dayOfWeek: "MON", calendarDay: 29),
    CA_WeekDashboardModel(dayOfWeek: "TUE", calendarDay: 30)
]
