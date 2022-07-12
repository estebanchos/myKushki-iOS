//
//  Budget.swift
//  myKushki
//
//  Created by Carlos O on 2022-07-12.
//

import Foundation

struct Budget: Decodable {
    let category: String
    let amount: Double
    let id: String
}
