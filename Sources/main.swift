import Foundation
import Kitura
import HeliumLogger
import PostgreSQL

HeliumLogger.use()

let host = "localhost"
let port = Int32(5432)
let database = "tryswift"
let username = "radioboo"
let password = "qwe12345"

var postgreConnection: PostgreSQL.Connection!

// Create a new router
let router = Router()

// Handle HTTP GET requests to /
router.get("/") {
    request, response, next in

    let connectionString = URL(string: "postgres://\(username):\(password)@\(host):\(port)/\(database)")!
    postgreConnection = try PostgreSQL.Connection(info: .init(connectionString))
    
    try postgreConnection.open()
    
    guard postgreConnection.internalStatus == PostgreSQL.Connection.InternalStatus.OK else {
        return
    }
    
    let query = "SELECT * FROM blogs;"
    let result = try postgreConnection.execute(query)
    
    var url: String? = nil
    for i in 0 ..< result.count {
        url = try String(describing: result[i].data("url"))
    }

    response.send(url!)
    next()
}

// Add an HTTP server and connect it to the router
Kitura.addHTTPServer(onPort: 8090, with: router)

// Start the Kitura runloop (this call never returns)
Kitura.run()
