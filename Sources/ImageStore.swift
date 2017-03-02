//
//  ImageStore.swift
//  Scraper
//
//  Created by atsushi.sakai on H29/03/02.
//
//

import Foundation
import SwiftKuery

class Images : Table {
    let tableName = "images"
    let id = Column("id")
    let blogId = Column("blog_id")
    let originalUrl = Column("original_url")
}

class ImageStore {
    
    func create(blogId: Int, originalUrl: String, onComplete:@escaping (QueryResult) -> ()) {
        let connection = Database.connection()
        connection.connect { error in
            if let e = error {
                print("\(e)")
                return
            }
        }
        
        let images = Images()
        let query = Insert(
            into: images,
            columns: [images.blogId, images.originalUrl],
            values: [blogId, originalUrl])
        
        connection.execute(query: query, onCompletion: { result in
            onComplete(result)
        })
    }
    
    func all(onComplete:@escaping (QueryResult) -> ()) {
        let connection = Database.connection()
        connection.connect { error in
            if let e = error {
                print("\(e)")
                return
            }
        }
        
        let images = Images()
        let query = Select(from: images)
        
        connection.execute(query: query, onCompletion: { result in
            onComplete(result)
        })
    }
    
}
