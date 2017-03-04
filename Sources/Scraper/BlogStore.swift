//
//  BlogModel.swift
//  Scraper
//
//  Created by atsushi.sakai on H29/03/02.
//
//

import Foundation
import SwiftKuery
import SwiftKueryPostgreSQL


class BlogStore {

    func find(id: Int, onComplete:@escaping (QueryResult) -> ()) {
        let connection = Database.connection()
        connection.connect { error in
            if let e = error {
                print("\(e)")
                return
            }
        }
        
        let blogsTable = BlogsTable()
        let query = Select(from: blogsTable)

        connection.execute(query: query, onCompletion: { result in
            onComplete(result)
        })
    }

}
