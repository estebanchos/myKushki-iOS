//
//  ContentView.swift
//  myKushki
//
//  Created by Carlos O on 2022-07-11.
//
import Foundation
import SwiftUI

struct ContentView: View {
    
    @State var email = ""
    @State var password = ""
    
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
                    TextField("Email", text: $email)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .padding()
                        .background(Color(.white))
                        .cornerRadius(25.0)
                    
                    SecureField("Password", text: $password)
                        .textContentType(.password)
                        .padding()
                        .background(Color(.white))
                        .cornerRadius(25.0)
                }
                .padding([.leading, .trailing], 50)
                
                Button(action: {
                    loginVM.login(email: email, password: password)
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
        } else if (loginVM.isAuthenticated && budgetListVM.budget.count < 1) {
            VStack {
                Text("Your Dashboard")
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
                    .padding(.top, 20)
                    .padding(.bottom, 10)
                
                Button(action: {
                    budgetListVM.getAllBudget(token: loginVM.token)
                    expensesListVM.getAllExpenses(token: loginVM.token)
                }) {
                    Text("Open Tracker")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 200, height: 60)
                        .background(Color("button"))
                        .cornerRadius(20.0)
                        .shadow(radius: 10.0, x: 10, y: 10)
                }.padding(.top, 30)
                Button(action: {}) {
                    Text("Start Budget")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 200, height: 60)
                        .background(Color("button"))
                        .cornerRadius(20.0)
                        .shadow(radius: 10.0, x: 10, y: 10)
                }.padding(.top, 30)
                Button(action: {}) {
                    Text("Continue Learning")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 200, height: 60)
                        .background(Color("button"))
                        .cornerRadius(20.0)
                        .shadow(radius: 10.0, x: 10, y: 10)
                }.padding(.top, 30)
                Spacer()
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
                
                List {
                    Section(header: Text("Budget").bold()) {
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
                    
                    Section(header: Text("Expenses").bold()) {
                        HStack {
                            Text("Item").bold().underline()
                                .frame(width: 100, alignment: .leading)
                            Spacer()
                            Text("Category").bold().underline()
                                .frame(width: 100)
                            Spacer()
                            Text("Amount").bold().underline()
                                .frame(width: 100, alignment: .trailing)
                        }
                        ForEach(expensesListVM.expenses, id: \.id) { expense in
                            HStack {
                                Text("\(expense.item)")
                                    .frame(width: 100, alignment: .leading)
                                Spacer()
                                Text("\(expense.category)")
                                    .frame(width: 100)
                                Spacer()
                                Text(String(format: "$%.2f", expense.amount))
                                    .frame(width: 100, alignment: .trailing)
                            }
                        }
                    }
                    .headerProminence(.increased)
                }
                .listStyle(.plain)
                Spacer()
                
                Button {
                    Task {
                        loginVM.logout()
                        email = ""
                        password = ""
                    }
                }label: {
                    Image(systemName:  "rectangle.portrait.and.arrow.right")
                        .foregroundColor(.white)
                    Text("Sign Out")
                        .font(.headline)
                        .foregroundColor(.white)
                }
            }
            .padding([.leading, .trailing], 10)
            .background(Color("mk-main"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}
