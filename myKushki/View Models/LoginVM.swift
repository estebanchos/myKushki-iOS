//
//  File.swift
//  myKushki
//
//  Created by Carlos O on 2022-07-12.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    @Published var isAuthenticated: Bool = false
    @Published var token:String = ""
    
    func login(email:String, password:String) {
        
        let defaults = UserDefaults.standard
        Webservice().login(email: email, password: password) { result in
            switch result {
                case .success(let token):
                    defaults.setValue(token, forKey: "token")
                    DispatchQueue.main.async {
                        self.isAuthenticated = true
                        self.token = token
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    func logout() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "token")
        DispatchQueue.main.async {
            self.isAuthenticated = false
            self.token = ""
        }
    }
    
}
