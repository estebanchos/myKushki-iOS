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
    @StateObject private var expensesListVM = ExpenseListViewModel()
    
    var body: some View {
        if !loginVM.isAuthenticated {
            VStack() {
                Text("Welcome to myKushki")
                    .font(.title)
                    .bold()
                    .foregroundColor(Color.white)
                    .padding([.top, .bottom], 75)
                
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
                    expensesListVM.getAllExpenses()
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
                    .foregroundColor(.white)
                    .padding(.top, 20)
                    .padding(.bottom, 10)
                VStack(alignment: .leading, spacing: 15) {
                    
                    List {
                        Section(header: Text("Budget").foregroundColor(.white).bold()) {
                            HStack {
                                Text("Category").bold().underline()
                                Spacer()
                                Text("Amount").bold().underline()
                            }
                            ForEach(budgetListVM.budget, id: \.id) { budget in
                                HStack {
                                    Text("\(budget.category)")
                                    Spacer()
                                    Text(String(format: "$%.2f", budget.amount))
                                }
                            }
                        }
                        .headerProminence(.increased)
                        
                        Section(header: Text("Expenses").foregroundColor(.white).bold()) {
                            HStack {
                                Text("Item").bold().underline()
                                Spacer()
                                Text("Category").bold().underline()
                                Spacer()
                                Text("Amount").bold().underline()
                            }
                            ForEach(expensesListVM.expenses, id: \.id) { expense in
                                HStack {
                                    Text("\(expense.item)")
                                    Spacer()
                                    Text("\(expense.category)")
                                    Spacer()
                                    Text(String(format: "$%.2f", expense.amount))
                                }
                            }
                        }
                        .headerProminence(.increased)
                    }
                    .listStyle(.plain)
//                    List {
//
//                    }
//                    .listStyle(.plain)
                }
                .padding([.leading, .trailing], 10)
                .background(Color("mk-main"))
                Spacer()
            }
            .background(Color("mk-main"))
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}
