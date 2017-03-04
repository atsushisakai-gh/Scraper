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
import Swiftkiq

class BlogCrawlingService {

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

        BlogStore().create(name: (top?.title)!, url: url.absoluteString, status: Blog.Status.wait.rawValue)

        var blogId: Int?
        BlogStore().select(by: url.absoluteString) { (blogs: [Blog]) in
            blogId = blogs.first?.id
        }

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

            // scrape next archive url
            let li = entry?.css("li.prev").first
            if li == nil {
                print("finish!!")
                break
            }
            let l = li?.css("a").first
            
            // Job
            guard let targetUrl = l?["href"] else { break }
            let args = ScrapingWorker.Args(blogId: blogId!, url: targetUrl)
            print("Add ScrapingWorker: \(targetUrl)")
            do {
                try? ScrapingWorker.performAsync(args, to: Swiftkiq.Queue("scraping"))
            } catch {
                continue
            }

            // next archive url
            archiveUrl = URL(string: (l?["href"]!)!)!
            
            usleep(150)
        }

    }
}
