//
//  Database.swift
//  Scraper
//
//  Created by atsushi.sakai on H29/03/02.
//
//

import Foundation
import PromiseKit
import SwiftKuery
import SwiftKueryPostgreSQL

class Database {
    
    let queue = DispatchQueue(label: "net.radioboo", attributes: .concurrent)
    
    static let blogsTable = BlogsTable()
    static let imagesTable = ImagesTable()
    
    public static func connection() -> PostgreSQLConnection {
        let connection = PostgreSQLConnection(
            host: "localhost",
            port: 5432,
            options: [ConnectionOptions.databaseName("scraper")]
        )
        return connection
    }
}

extension Connection {
    func connect() -> Promise<Void> {
        return Promise { fulfill, reject in
            self.connect() { error in
                if let error = error {
                    reject(error)
                } else {
                    fulfill()
                }
            }
        }
    }
}

public extension Query {
    func execute(_ connection: Connection ) -> Promise<QueryResult> {
        return Promise { fulfill, reject in
            self.execute( connection) { result in
                fulfill(result)
            }
        }
    }
}


