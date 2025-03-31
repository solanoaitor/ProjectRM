//
//  DateUtils.swift
//  ProjectRM
//
//  Created by Aitor Solano Rabines on 30/3/25.
//

import Foundation

func formattedDate(isoDate: String) -> String {
    let isoFormatter = ISO8601DateFormatter()
    isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds] // 👈 importante
    guard let date = isoFormatter.date(from: isoDate) else {
        return isoDate
    }
    let displayFormatter = DateFormatter()
    displayFormatter.locale = Locale.current
    displayFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
    return displayFormatter.string(from: date)
}
