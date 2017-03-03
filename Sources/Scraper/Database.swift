//
//  Database.swift
//  Scraper
//
//  Created by atsushi.sakai on H29/03/02.
//
//

import Foundation
import SwiftKuery
import SwiftKueryPostgreSQL

class Database {
    
    public static func connection() -> PostgreSQLConnection {
        let connection = PostgreSQLConnection(
            host: "localhost",
            port: 5432,
            options: [ConnectionOptions.databaseName("scraper")]
        )
        return connection
    }
}
