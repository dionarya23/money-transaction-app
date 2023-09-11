//
//  PreviewData.swift
//  ExpenseTracker
//
//  Created by Dion Arya Pamungkas on 11/09/23.
//

import Foundation
import SwiftUI

var transactionPeviewData = Transaction(id: 1, date: "24/01/2022", institution: "BCA", account: "Bank BCA", merchant: "Apple Store", amount: 11000, type: "debit", categoryId: 801, category: "Software", isPending: false, isTransfer: false, isExpense: true, isEdited: false)

var transactionListPreviewData = [Transaction](repeating: transactionPeviewData, count: 10)
