//
//  FormatDateProtocol.swift
//  LowesInterViewWeeChu
//
//  Created by Coding on 9/20/22.
//

import Foundation

protocol FormatDateProtocol {
    func formatDate(fromString: String, dateFormat: String) -> String
}

extension FormatDateProtocol {
    func formatDate(fromString: String, dateFormat: String) -> String {
        let string = fromString
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        guard let date = dateFormatter.date(from: string) else {
            return "Invalid Date"
        }
        return date.formatted(.dateTime.day().month(.wide).year())
    }
}
