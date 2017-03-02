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

class Blogs : Table {
    let tableName = "blogs"
    let id = Column("id")
    let name = Column("name")
    let url = Column("url")
}

class BlogStore {

    func find(id: Int, onComplete:@escaping (QueryResult) -> ()) {
        let connection = Database.connection()
        connection.connect { error in
            if let e = error {
                print("\(e)")
                return
            }
        }
        
        let blogs = Blogs()
        let query = Select(from: blogs)

        connection.execute(query: query, onCompletion: { result in
            onComplete(result)
        })
    }

}
