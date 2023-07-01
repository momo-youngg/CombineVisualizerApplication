//
//  CombineVisualizerServer.swift
//  CombineVisualizerApplication
//
//  Created by momo on 2023/05/18.
//

import Foundation

final class CombineVisualizerServer {
    static let shared = CombineVisualizerServer()
    private init() { }
    
    var webServer: GCDWebServer?
    var port: UInt = 8080
    
    func start() {
        let webServer = GCDWebServer()
        webServer.addHandler(
            forMethod: "POST",
            path: "/add",
            request: GCDWebServerDataRequest.self,
            processBlock: { request in
                let body = self.getBody(from: request)
                let result = self.addNewEdge(body)
                return GCDWebServerDataResponse(jsonObject: ["result": result ? "success" : "fail"])
            }
        )
        webServer.start(withPort: self.port, bonjourName: "GCD Web Server")
        self.webServer = webServer
    }
    
    func restart() {
        self.webServer?.stop()
        self.start()
    }
    
    private func getBody(from request: GCDWebServerRequest) -> [String: Any] {
        guard let dataRequest = request as? GCDWebServerDataRequest,
           let jsonObject = dataRequest.jsonObject,
           let jsonDict = jsonObject as? Dictionary<String, Any> else {
            return [:]
        }
        return jsonDict
    }
    
    private func addNewEdge(_ body: [String: Any]) -> Bool {
        guard let trid = body["trid"] as? String,
              let uuid = body["uuid"] as? String,
              let element = body["element"] as? String,
              let elementName = body["elementName"] as? String,
              let queue = body["queue"] as? String,
              let thread = body["thread"] as? String,
              let methodName = body["methodName"] as? String
        else {
            return false
        }
        let methodParameter = body["methodParameter"] as? String ?? ""
        Task { @MainActor in
            CombineManager.shared.add(
                trid: trid,
                uuid: uuid,
                element: element,
                elementName: elementName,
                queue: queue,
                thread :thread,
                methodName: methodName,
                methodParameter :methodParameter
            )
        }
        return true
    }
}
