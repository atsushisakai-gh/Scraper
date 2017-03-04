//
//  ImageStore.swift
//  Scraper
//
//  Created by atsushi.sakai on H29/03/02.
//
//

import Foundation
import SwiftKuery
import PromiseKit

class ImageStore: Store {

    func create(blogId: Int, uuid: String, originalUrl: String) {
        let table = Database.imagesTable
        let insert = Insert(into: table, columns: [table.blogId, table.uuid, table.originalUrl], values: [blogId, uuid, originalUrl])
        
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
    
    func select(by blogId: Int, onComplete: (@escaping ([Image])->Void)) {
        let table = Database.imagesTable
        
        let connection = Database.connection()

        connection.connect() { error in
            if let _ = error {
                fatalError()
            }
        }

        let select = Select(from: table).where ( table.blogId == blogId )

        connection.execute(query: select) { result in
            let resultSet = result.asResultSet
            let fields = self.resultToRows(resultSet: resultSet!)
            onComplete(fields.flatMap(Image.init(fields:)))
        }
        connection.closeConnection()
    }

}
