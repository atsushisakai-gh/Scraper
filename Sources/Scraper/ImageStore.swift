//
//  ImageStore.swift
//  Scraper
//
//  Created by atsushi.sakai on H29/03/02.
//
//

import Foundation
import SwiftKuery

class ImageStore {
    
    func create(blogId: Int, originalUrl: String, onComplete:@escaping (QueryResult) -> ()) {
        let connection = Database.connection()
        connection.connect { error in
            if let e = error {
                print("\(e)")
                return
            }
        }
        
        let imagesTable = ImagesTable()
        let query = Insert(
            into: imagesTable,
            columns: [imagesTable.blogId, imagesTable.originalUrl],
            values: [blogId, originalUrl])
        
        connection.execute(query: query, onCompletion: { result in
            onComplete(result)
        })
        connection.closeConnection()
    }
    
    func all(onComplete:@escaping (QueryResult) -> ()) {
        let connection = Database.connection()
        connection.connect { error in
            if let e = error {
                print("\(e)")
                return
            }
        }
        
        let imagesTable = ImagesTable()
        let query = Select(from: imagesTable)
        
        connection.execute(query: query, onCompletion: { result in
            onComplete(result)
        })
        connection.closeConnection()
    }
    
}
