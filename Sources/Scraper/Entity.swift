//
//  Entity.swift
//  Scraper
//
//  Created by atsushi.sakai on 2017/03/04.
//
//

import Foundation

public typealias Fields = [String: Any]

public protocol FieldMappable {
    init?( fields: Fields )
}
