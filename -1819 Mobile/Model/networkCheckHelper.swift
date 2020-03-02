//
//  NetworkHelper.swift
//  -1819 Mobile
//
//  Created by Chris Holschuh on 3/1/20.
//  Copyright © 2020 Chris Holschuh. All rights reserved.
//

import Network

enum Reachable {
    case yes, no
}

class networkCheckHelper {
    
    private let networkMonitor: NWPathMonitor =  NWPathMonitor()
    
    init() {
        let queue = DispatchQueue.global(qos: .background)
        networkMonitor.start(queue: queue)
    }
}
extension networkCheckHelper {
    func startMonitor ( callBack: @escaping (_ rechable: Reachable) -> Void ) -> Void {
        networkMonitor.pathUpdateHandler = { path in
            
            let reachable = (path.status == .unsatisfied || path.status == .requiresConnection)  ? Reachable.no  : Reachable.yes
            
            return callBack(reachable)
        }
    }
}
extension networkCheckHelper {
    func cancel(){
        
        networkMonitor.cancel()
    }
}
