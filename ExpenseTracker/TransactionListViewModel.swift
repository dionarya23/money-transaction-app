//
//  TransactionListViewModel.swift
//  ExpenseTracker
//
//  Created by Dion Arya Pamungkas on 11/09/23.
//

import Foundation
import Combine

typealias TransactionGroup = [String: [Transaction]]

final class TransactionListViewModel: ObservableObject {
    @Published var transactions: [Transaction] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        getTransaction()
    }
    
    
    func getTransaction() {
        guard let url = URL(string: "https://designcode.io/data/transaction.json") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data, response) -> Data in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    dump(response)
                    throw URLError(.badServerResponse)
                }
                
                return data
            }
            .decode(type: [Transaction].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("error fetching transaction:", error.localizedDescription)
                case .finished:
                    print("Finished fetching transaction")
                    }
                } receiveValue: { [weak self] result in
                    self?.transactions = result
                }
                .store(in: &cancellables)
    }
    
    func groupTransactionByMonth() -> TransactionGroup {
        guard !transactions.isEmpty else { return [:] }
        
        let groupTransaction = TransactionGroup(grouping: transactions) { $0.month }
        
        return groupTransaction
    }
}
