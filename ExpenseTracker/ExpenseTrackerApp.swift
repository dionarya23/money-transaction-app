//
//  ExpenseTrackerApp.swift
//  ExpenseTracker
//
//  Created by Dion Arya Pamungkas on 11/09/23.
//

import SwiftUI

@main
struct ExpenseTrackerApp: App {
    @StateObject var transactionListVM = TransactionListViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(transactionListVM)
        }
    }
}
