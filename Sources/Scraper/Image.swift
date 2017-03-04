//
//  Image.swift
//  Scraper
//
//  Created by atsushi.sakai on 2017/03/04.
//
//

import Foundation

struct Image {
    let id: Int
    let blogId: Int
    let uuid: String
    let originalUrl: String
}

extension Image: FieldMappable {
    
    init?(fields: Fields) {
        id = Int(fields["id"] as! String)!
        blogId = Int(fields["blog_id"] as! String)!
        uuid = fields["uuid"] as! String
        originalUrl = fields["original_url"] as! String
    }

}
