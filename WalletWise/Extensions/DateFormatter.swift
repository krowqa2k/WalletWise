//
//  DateFormatter.swift
//  WalletWise
//
//  Created by Mateusz Krówczyński on 23/08/2024.
//

import Foundation

extension Date {
    var displayFormat: String {
        self.formatted(
            .dateTime
                .year()
                .month(.wide)
                .day(.twoDigits)
        )
    }
}
