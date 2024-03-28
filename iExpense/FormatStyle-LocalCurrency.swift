//
//  FormatStyle-LocalCurrency.swift
//  iExpense
//
//  Created by Umair on 28/03/24.
//

import Foundation

extension FormatStyle where Self == FloatingPointFormatStyle<Double>.Currency {
    static var localCurrency: Self {
        .currency(code: Locale.current.currency?.identifier ?? "INR")
    }
}
