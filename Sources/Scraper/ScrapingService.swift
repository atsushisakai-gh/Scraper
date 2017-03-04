//
//  ScrapingService.swift
//  Scraper
//
//  Created by atsushi.sakai on 2017/03/04.
//
//

import Foundation
import Kanna

class ScrapingService {
    
    func call(_ url: URL) {
        print("Start Scraping Service: \(url.absoluteString)")
        var data: Data? = nil
        
        do {
            data = try Data(contentsOf: url)
        } catch {
            print("cannot get non")
            return
        }

        let top = HTML(html: data!, encoding: String.Encoding.utf8)

        for img in (top?.css("img.pict"))! {
            ImageStore().create(blogId: 0, uuid: UUID().uuidString, originalUrl: img["src"]!)
            print("###### Image: \(img["src"])")
        }
    }
}
