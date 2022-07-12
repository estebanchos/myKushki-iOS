//
//  File.swift
//  myKushki
//
//  Created by Carlos O on 2022-07-12.
//

import Foundation

struct Expense: Decodable {
    let item: String
    let category: String
    let amount: Double
    let id: String
}

