import Foundation
import Kitura
import Kanna
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
    CrawlingService().call(URL(string: "http://lineblog.me/non_official")!)
    
    response.send("yeah")
    next()
}

// Add an HTTP server and connect it to the router
Kitura.addHTTPServer(onPort: 8090, with: router)

// Start the Kitura runloop (this call never returns)
Kitura.run()
