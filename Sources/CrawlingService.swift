//
//  CrawlingService.swift
//  Scraper
//
//  Created by atsushi.sakai on H29/03/03.
//
//

import Foundation
import HeliumLogger
import Kanna

class CrawlingService {

    public func call(_ url: URL) {
        var data: Data? = nil

        // get LINE Blog top page
        do {
            data = try Data(contentsOf: url)
        } catch {
            print("cannot get non")
            return
        }

        let top = HTML(html: data!, encoding: String.Encoding.utf8)

        // get first archive urls from top page
        let archiveLinks: [String] = (top?.css("h1.article-title"))!.map {
            var l: String? = nil
            for link in ($0.css("a")) {
                l = link["href"]!
            }
            return l!
        }

        // Crawling from latest entry to last entry
        var archiveUrl = URL(string: archiveLinks.first!)!

        while(true) {
            var entryData: Data? = nil
            do {
                entryData = try Data(contentsOf: archiveUrl)
            } catch {
                print("cannot get archive")
                break
            }

            let entry = HTML(html: entryData!, encoding: String.Encoding.utf8)

            // to ScrapingWorker
            for img in (entry?.css("img.pict"))! {
                ImageStore().create(blogId: 1, originalUrl: img["src"]!, onComplete: { result in
                    print("###### Image: \(img["src"])")
                })
            }
            
            // scrape next archive url
            let li = entry?.css("li.prev").first
            if li == nil {
                print("finish!!")
                break
            }
            let l = li?.css("a").first
            
            // next archive url
            archiveUrl = URL(string: (l?["href"]!)!)!
            
            sleep(3)
        }

    }
}
