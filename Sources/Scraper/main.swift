import Foundation
import Kitura
import Swiftkiq
import HeliumLogger
import KituraMustache

HeliumLogger.use()

// Create a new router
let router = Router()

router.add(templateEngine: MustacheTemplateEngine())

router.get("/") { request, response, next in

    var context: [String: [[String: Any]]] = ["images": []]

    RankingScrapingService().call("http://www.lineblog.me/ranking/")
    
    response.send("start crawling ranlking")

    //    try response.render("images.mustache", context: context).end()
    next()
}

// Handle HTTP GET requests to /
router.get("/scrape") { request, response, next in
    let url = "http://lineblog.me/non_official"
    do {
        try BlogCrawlingWorker.performAsync(BlogCrawlingWorker.Args(url: url), to: Swiftkiq.Queue("default"))
    } catch {
        print("error")
    }
    response.send("\(url)をクロールするぞ!!!")
    next()
}

// Add an HTTP server and connect it to the router
Kitura.addHTTPServer(onPort: 8090, with: router)

// Start the Kitura runloop (this call never returns)
Kitura.run()
