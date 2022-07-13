//
//  BudgetListVM.swift
//  myKushki
//
//  Created by Carlos O on 2022-07-12.
//

import Foundation

class BudgetListViewModel: ObservableObject {
    
    @Published var budget: [BudgetViewModel] = []
    
    func getAllBudget(token:String) {
        
//        let defaults = UserDefaults.standard
//        guard let token = defaults.string(forKey: "token") else {
//            return
//        }
        
        Webservice().getUserBudget(token: token) { (result) in
            switch result {
                case .success(let budget):
                    print("successful budget fetch")
                    DispatchQueue.main.async {
                        self.budget = budget.map(BudgetViewModel.init)
                    }
                case .failure(let error):
                    print("unsuccessful budget fetch")
                    print(error.localizedDescription)
            }
        }
        
    }
    
}

struct BudgetViewModel {
    let budget: Budget
    
    var id: String {
        return budget._id
    }
    
    var category: String {
        return budget.category
    }
    
    var amount: Double {
        return budget.amount
    }
}
