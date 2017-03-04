//
//  RankingScrapingService.swift
//  Scraper
//
//  Created by atsushi.sakai on 2017/03/04.
//
//

import Foundation
import Kanna
import Swiftkiq

class RankingScrapingService {

    func call(_ url: String) {
        let blogUrl = URL(string: url)!
        
        // get LINE Blog top page
        let data: Data?
        do {
            data = try Data(contentsOf: blogUrl)
        } catch {
            print("cannot get non")
            return
        }
        
        let top = HTML(html: data!, encoding: String.Encoding.utf8)
        
        // get first archive urls from top page
        let blogLinks: [String] = (top?.css("div.mdMN03UserName"))!.map {
            var l: String?
            for link in ($0.css("a")) {
                l = link["href"]!
            }
            return l!
        }

        // FIXME: なぜか板野までしか取れないのであとで直す

        blogLinks.forEach { url in
            print("Start Scrape \(url)")
            do {
                try BlogCrawlingWorker.performAsync(BlogCrawlingWorker.Args(url: url), to: Swiftkiq.Queue("default"))
            } catch {
                print("error")
            }
        }

    }
}
