//
//  ContentView.swift
//  myKushki
//
//  Created by Carlos O on 2022-07-11.
//
import Foundation
import SwiftUI

struct ContentView: View {
    
    @StateObject private var loginVM = LoginViewModel()
    @StateObject private var budgetListVM = BudgetListViewModel()
    
    var body: some View {
        if !loginVM.isAuthenticated {
            VStack() {
                Text("Welcome to myKushki")
                    .font(.title)
                    .bold()
                    .foregroundColor(Color.white)
                    .padding([.top, .bottom], 50)
                
                VStack(alignment: .leading, spacing: 15) {
                    TextField("Email", text: $loginVM.email)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .padding()
                        .background(Color(.white))
                        .cornerRadius(25.0)
                    
                    SecureField("Password", text: $loginVM.password)
                        .textContentType(.password)
                        .padding()
                        .background(Color(.white))
                        .cornerRadius(25.0)
                }
                .padding([.leading, .trailing], 50)
                
                Button(action: {
                    loginVM.login()
                    budgetListVM.getAllBudget()
                }) {
                    Text("Sign In")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 200, height: 60)
                        .background(Color("button"))
                        .cornerRadius(20.0)
                        .shadow(radius: 10.0, x: 10, y: 10)
                }.padding(.top, 50)
                
                Spacer()
                HStack {
                    Text("Don't have an account? ")
                        .foregroundColor(.white)
                    Button(action: {}) {
                        Text("Sign Up")
                            .foregroundColor(.white)
                            .bold()
                            .underline()
                    }
                }
            }
            .background(Color("mk-main"))
        } else {
            VStack() {
                Text("Expense Tracker")
                    .font(.title)
                    .bold()
                    .foregroundColor(Color.white)
                    .padding([.top, .bottom], 50)
                
                Text("There are \(budgetListVM.budget.count) items")
                
//                List(budgetListVM.budget, id: \.id) { budget in
//                    HStack {
//                        Text("\(budget.category)")
//                        Spacer()
//                        Text(String(format: "$%.2f", budget.amount))
//                    }
//                }
//                .listStyle(PlainListStyle())
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}
