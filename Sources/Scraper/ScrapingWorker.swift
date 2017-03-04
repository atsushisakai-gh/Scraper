//
//  ScrapingWorker.swift
//  Scraper
//
//  Created by atsushi.sakai on 2017/03/04.
//
//

import Foundation
import Swiftkiq

class ScrapingWorker: Worker {

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
    
    public func perform(_ argument: ScrapingWorker.Args) throws {
        ScrapingService().call(URL(string: argument.url)!)
    }

}
