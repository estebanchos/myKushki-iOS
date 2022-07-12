//
//  File.swift
//  myKushki
//
//  Created by Carlos O on 2022-07-12.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    var email: String = ""
    var password: String = ""
    @Published var isAuthenticated: Bool = false
    
    func login() {
        
        let defaults = UserDefaults.standard
        
        Webservice().login(email: email, password: password) { result in
            switch result {
            case .success(let token):
                defaults.setValue(token, forKey: "token")
                DispatchQueue.main.async {
                    self.isAuthenticated = true
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
