//
//  CrawlingWorker.swift
//  Scraper
//
//  Created by atsushi.sakai on H29/03/03.
//
//

import Foundation
import Swiftkiq

class BlogCrawlingWorker: Worker {
    struct Args : Argument {
        let url: String
        
        public func toDictionary() -> [String : Any] {
            return ["url": url]
        }

        static func from(_ dictionary: Dictionary<String, Any>) -> Args {
            return Args(
                url: dictionary["url"]! as! String
            )
        }
    }
 
    var jid: String?
    var queue: Queue?
    var retry: Int?
    
    required init() {}

    public func perform(_ argument: BlogCrawlingWorker.Args) throws {
        BlogCrawlingService().call(URL(string: argument.url)!)
    }
}
