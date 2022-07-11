//
//  ContentView.swift
//  myKushki
//
//  Created by Carlos O on 2022-07-11.
//

import SwiftUI

struct ContentView: View {
    @State var username = ""
    @State var password = ""
    
    var body: some View {
        VStack{
            TextField("Username", text: $username)
                .textContentType(.username)
            
            TextField("Password", text: $password)
                .textContentType(.password)
        }
        .padding([.leading, .trailing], 50)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
