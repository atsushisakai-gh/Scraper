import Foundation
import Kitura
import Kanna
import HeliumLogger
import KituraMustache

HeliumLogger.use()

// Create a new router
let router = Router()

router.add(templateEngine: MustacheTemplateEngine())

// Handle HTTP GET requests to /
router.get("/") {
    request, response, next in
    
    // ブログトップページを取ってくる
    let url = URL(string: "http://lineblog.me/non_official")!
    let data = try Data(contentsOf: url)
    let top = HTML(html: data, encoding: String.Encoding.utf8)
    
    // トップページから最初のarchiveを取ってくる
    var archiveLinks: [String] = []
    for archiveLink in (top?.css("h1.article-title"))! {
        for link in (archiveLink.css("a")) {
            archiveLinks.append(link["href"]!)
        }
    }
    
    let latestEntryUrl = archiveLinks.first!
    
    // 最新のEntryから順番にアクセスして、「前の記事」があれば遡る、「前の記事」がなくなったら終了する
    var url2 = URL(string: latestEntryUrl)!

    var context: [String: [Any] ] = [ "images": [] ]
    
    while(true) {
        let data2 = try Data(contentsOf: url2)
        let entry = HTML(html: data2, encoding: String.Encoding.utf8)
        
        // Entry内の記事写真を集める
        for img in (entry?.css("img.pict"))! {
            print("\(img["src"])")
            context["images"]?.append(["url": img["src"]!])
        }

        // 前の記事を見つける
        let li = entry?.css("li.prev").first
        if li == nil {
            print("finish!!")
            break
        }
        let l = li?.css("a").first
        url2 = URL(string: (l?["href"]!)!)!

        sleep(3)
    }
    
    try response.render("images.mustache", context: context).end()
    next()
}

// Add an HTTP server and connect it to the router
Kitura.addHTTPServer(onPort: 8090, with: router)

// Start the Kitura runloop (this call never returns)
Kitura.run()
