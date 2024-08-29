//
//  String+Extension.swift
//  CSTV
//
//  Created by Lucas Brandão on 29/08/24.
//

import Foundation

extension String {
    func formatDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)

        guard let date = dateFormatter.date(from: self) else {
            return "Invalid date"
        }

        let calendar = Calendar.current
        var todayString = ""
        if calendar.isDateInToday(date) {
            todayString = "Hoje, "
            dateFormatter.dateFormat = "HH:mm"
        } else {
            dateFormatter.dateFormat = "EEE, HH:mm"
        }

        dateFormatter.timeZone = TimeZone.current

        return todayString.appending(dateFormatter.string(from: date)) 
    }
}
