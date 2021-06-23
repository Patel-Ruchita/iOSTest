//
//  Model.swift
//  RuchiTest
//
//  Created by iMac on 22/06/21.
//

import Foundation

struct ListData: Codable {
    let title: String?
    let description: String?
    let imageHref: String?
}

struct DemoData: Codable {
    let title: String?
    let rows: [ListData]
}
