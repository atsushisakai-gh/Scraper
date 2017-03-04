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
import PromiseKit

class BlogStore: Store {
    
    func create(name: String, url: String, status: Int) {
        let table = Database.blogsTable
        let insert = Insert(into: table, columns: [table.name, table.url, table.status], values: [name, url, status])

        let connection = Database.connection()
        let queue = Database.queue

        firstly {
            connection.connect()
        }
        .then(on: queue) { result -> Promise<QueryResult> in
            insert.execute(connection)
        }
        .always(on: queue) {
            connection.closeConnection()
        }
    }

    func select(by url: String, onComplete: (@escaping ([Blog])->Void)) {
        let table = Database.blogsTable
        
        let connection = Database.connection()
        
        connection.connect() { error in
            if let _ = error {
                fatalError()
            }
        }
        
        let select = Select(from: table).where ( table.url == url )
        
        connection.execute(query: select) { result in
            let resultSet = result.asResultSet
            let fields = self.resultToRows(resultSet: resultSet!)
            onComplete(fields.flatMap(Blog.init(fields:)))
        }
    }
}
