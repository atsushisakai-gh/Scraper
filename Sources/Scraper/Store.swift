//
//  Store.swift
//  Scraper
//
//  Created by atsushi.sakai on 2017/03/04.
//
//

import Foundation
import SwiftKuery

protocol Store { }

extension Store {
    func resultToRows(resultSet: ResultSet) -> [Fields] {
        let t = resultSet.rows.map { zip(resultSet.titles, $0) }
        let y: [Fields] = t.map {
            var dicts = [String: Any]()
            
            $0.forEach {
                let (title, value) = $0
                dicts[title] = value
            }
            return dicts
        }
        return y
    }
}
