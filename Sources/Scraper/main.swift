import Foundation
import Kitura
import Swiftkiq
import PromiseKit
import HeliumLogger
import KituraMustache

HeliumLogger.use()

// Create a new router
let router = Router()

router.add(templateEngine: MustacheTemplateEngine())

router.get("/") { request, response, next in

    RankingScrapingService().call("http://www.lineblog.me/ranking/")
    
    response.send("start crawling ranlking")

    next()
}

router.get("/images") { request, response, next in
    var context: [String: [[String: Any]]] = ["images": []]
    
    ImageStore().select(by: 0, onComplete: { images in
        images.forEach { image in
            context["images"]?.append(["url": image.originalUrl])
        }
    })
    
    try response.render("images.mustache", context: context).end()
    next()
}

// Add an HTTP server and connect it to the router
Kitura.addHTTPServer(onPort: 8090, with: router)

// Start the Kitura runloop (this call never returns)
Kitura.run()
