//
//  Webservice.swift
//  myKushki
//
//  Created by Carlos O on 2022-07-12.
//

import Foundation

enum AuthenticationError: Error {
    case invalidCredentials
    case custom(errorMessage: String)
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

struct LoginRequest: Codable {
    let email: String
    let password: String
}

struct LoginResponse: Codable {
    let token: String?
    let message: String?
    let validLogin:Bool?
}

class Webservice {
    
    func login(email: String, password:String, completion: @escaping (Result<String, AuthenticationError>) -> Void) {
        
        guard let url = URL(string: "https://mykushki-serv.herokuapp.com/users/login") else {
            completion(.failure(.custom(errorMessage: "URL is not correct")))
            return
        }
        
        let body = LoginRequest(email: email, password: password)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: "No data")))
                return
            }
            
            guard let loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: data) else {
                completion(.failure(.invalidCredentials))
                return
            }
            
            guard let token = loginResponse.token else {
                completion(.failure(.invalidCredentials))
                return
            }
            
            completion(.success(token))
            
        }.resume()
    }
    
    func getUserBudget(token: String, completion: @escaping (Result<[Budget], NetworkError>) -> Void) {
        
        guard let url = URL(string: "https://mykushki-serv.herokuapp.com/users/budget") else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completion(.failure(.noData))
                return
            }
            
            guard let budget = try? JSONDecoder().decode([Budget].self, from: data) else {
                completion(.failure(.decodingError))
                return
            }
            
            completion(.success(budget))
            
        }.resume()
    }
    
    func getUserExpenses(token: String, completion: @escaping (Result<[Expense], NetworkError>) -> Void) {
        
        guard let url = URL(string: "https://mykushki-serv.herokuapp.com/users/expenses") else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completion(.failure(.noData))
                return
            }
            
            guard let expenses = try? JSONDecoder().decode([Expense].self, from: data) else {
                completion(.failure(.decodingError))
                return
            }
            
            completion(.success(expenses))
            
        }.resume()
    }
    
}
