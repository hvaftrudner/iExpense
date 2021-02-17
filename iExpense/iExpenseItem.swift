//
//  iExpenseItem.swift
//  iExpense
//
//  Created by Kristoffer Eriksson on 2021-02-16.
//

import Foundation
import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Int
}
