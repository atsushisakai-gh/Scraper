import Foundation
import Swiftkiq

class SKRouter: Routable {
    func dispatch(_ work: UnitOfWork) throws {
        switch work.workerClass {
        case "CrawlingWorker":
            try invokeWorker(workerClass: CrawlingWorker.self, work: work)
        default:
            break
        }
    }
    
    func invokeWorker<Worker: WorkerType>(workerClass: Worker.Type, work: UnitOfWork) throws {
        let worker = workerClass.init()
        let argument = workerClass.Argument.from(work.argument)
        worker.jid = work.jid
        worker.retry = work.retry
        worker.queue = work.queue
        print("[INFO]: \(work.workerClass) start")
        let start = Date()
        try worker.perform(argument)
        let interval = Date().timeIntervalSince(start)
        print(String(format: "[INFO]: jid=%@ %@ done - %.4f msec", work.jid, work.workerClass, interval))
    }
}

let router = SKRouter()
let options = LaunchOptions(
    concurrency: 1,
    queues: [Queue(rawValue: "default")],
    strategy: nil,
    router: router
)

let launcher = Launcher(options: options)
launcher.run()

let group = DispatchGroup()
group.enter()
group.wait()
