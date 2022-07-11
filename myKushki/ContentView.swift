//
//  ContentView.swift
//  myKushki
//
//  Created by Carlos O on 2022-07-11.
//
import Foundation
import SwiftUI

struct ContentView: View {
    @State var username = ""
    @State var password = ""
    
    var body: some View {
        VStack() {
                   Text("Welcome to myKushki!")
                       .font(.title)
                       .foregroundColor(Color.white)
                       .padding([.top, .bottom], 50)
                       .shadow(radius: 6.0, x: 10, y: 10)
                   
                   VStack(alignment: .leading, spacing: 15) {
                       TextField("Username", text: $username)
                           .autocapitalization(.none)
                           .disableAutocorrection(true)
                           .padding()
                           .background(Color(.white))
                           .cornerRadius(25.0)
                           .shadow(radius: 10.0, x: 5, y: 10)
                       
                       SecureField("Password", text: $password)
                           .textContentType(.password)
                           .padding()
                           .background(Color(.white))
                           .cornerRadius(25.0)
                           .shadow(radius: 10.0, x: 5, y: 10)
                   }
                   .padding([.leading, .trailing], 50)
                   Button(action: {} ) {
                       Text("Forgot password?")
                           .padding([.leading], 150)
                           .foregroundColor(.white)
                   }
                   
                   Button(action: { }) {
                       Text("Sign In")
                           .font(.headline)
                           .foregroundColor(.white)
                           .padding()
                           .frame(width: 200, height: 60)
                           .background(Color("Orange"))
                           .cornerRadius(20.0)
                           .shadow(radius: 10.0, x: 20, y: 10)
                   }.padding(.top, 50)
                   
                   Spacer()
                   HStack {
                       Text("Don't have an account? ")
                           .foregroundColor(.white)
                       Button(action: {}) {
                           Text("Sign Up")
                           .foregroundColor(.yellow)
                       }
                   }
               }
        .background(Color("myKushki"))
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
