//
//  Table.swift
//  Scraper
//
//  Created by atsushi.sakai on 2017/03/03.
//
//

import SwiftKuery

class BlogsTable : Table {
    let tableName = "blogs"
    
    let id = Column("id")
    let name = Column("name")
    let url = Column("url")
    let status = Column("status")
}

class ImagesTable: Table {
    let tableName = "images"

    let id = Column("id")
    let blogId = Column("blog_id")
    let uuid = Column("uuid")
    let originalUrl = Column("original_url")
}
