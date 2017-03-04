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

router.get("/blogs") { request, response, next in
    var context: [String: [[String: Any]]] = ["blogs": []]
    
    BlogStore().all(onComplete: { blogs in
        blogs.forEach { blog in
            if let name = blog.name {
                context["blogs"]?.append(["name": name, "id": blog.id, "url": blog.url])
            }
        }
    })
    
    try response.render("blogs.mustache", context: context).end()
    next()
}

router.get("/blogs/:id/images") { request, response, next in
    var context: [String: [[String: Any]]] = ["images": []]
    guard let id = request.parameters["id"] else { fatalError() }
    
    ImageStore().select(by: Int(id)!, onComplete: { images in
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
