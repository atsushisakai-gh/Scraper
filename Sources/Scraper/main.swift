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

    ImageStore().all(onComplete: { result in
        for row in (result.asResultSet?.rows)! {
            print("\(row)")
            context["images"]?.append(
                ["url": row[2]!]
            )
        }
        
    })

    try response.render("images.mustache", context: context).end()
    next()
}

// Handle HTTP GET requests to /
router.get("/scrape") { request, response, next in
    let url = "http://lineblog.me/non_official"
    do {
        try CrawlingWorker.performAsync(CrawlingWorker.Args(url: url), to: Swiftkiq.Queue("default"))
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
