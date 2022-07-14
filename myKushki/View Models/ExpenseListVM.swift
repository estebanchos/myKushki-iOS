//
//  ExpenseListVM.swift
//  myKushki
//
//  Created by Carlos O on 2022-07-12.
//

import Foundation

class ExpenseListViewModel: ObservableObject {
    
    @Published var expenses: [ExpenseViewModel] = []
    
    func getAllExpenses(token:String) {
        
//        let defaults = UserDefaults.standard
//        guard let token = defaults.string(forKey: "token") else {
//            print("token not found")
//            return
//        }
        
        Webservice().getUserExpenses(token: token) { (result) in
            switch result {
                case .success(let budget):
                    DispatchQueue.main.async {
                        self.expenses = budget.map(ExpenseViewModel.init)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
        
    }
    
}

struct ExpenseViewModel {
    let expense: Expense
    
    var id: String {
        return expense._id
    }
    
    var item: String {
        return expense.item
    }
    
    var category: String {
        return expense.category
    }
    
    var amount: Double {
        return expense.amount
    }
}
