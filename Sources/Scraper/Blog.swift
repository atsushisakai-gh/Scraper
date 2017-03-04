//
//  Blog.swift
//  Scraper
//
//  Created by atsushi.sakai on 2017/03/04.
//
//

import Foundation


struct Blog {
    enum Status: Int {
        case wait
        case crawling
        case finished
        case error
    }
    
    let id: Int
    let name: String?
    let url: String
    let status: Status
}

extension Blog: FieldMappable {

    init?(fields: Fields) {
        if let fieldId = fields["id"] {
            id = Int(fieldId as! String)!
        } else {
            return nil
        }
        name = fields["name"] as? String
        url = fields["url"] as! String
        status = Blog.Status(rawValue: Int(fields["status"] as! String)!)!
    }
}
