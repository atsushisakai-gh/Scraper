//
//  CrawlingWorker.swift
//  Scraper
//
//  Created by atsushi.sakai on H29/03/03.
//
//

import Foundation
import Swiftkiq

class CrawlingWorker: WorkerType {
    struct Argument : ArgumentType {
        let url: String

        static func from(_ dictionary: Dictionary<String, Any>) -> Argument {
            return Argument(
                url: dictionary["url"]! as! String
            )
        }
    }
 
    var jid: String?
    var queue: Queue?
    var retry: Int?
    
    required init() {}

    public func perform(_ argument: CrawlingWorker.Argument) throws {
        CrawlingService().call(URL(string: argument.url)!)
    }
}
