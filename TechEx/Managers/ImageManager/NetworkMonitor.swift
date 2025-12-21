//
//  NetworkMonitor.swift
//  TechEx
//
//  Created by macbook on 21/12/2025.
//

import Network
import OSLog

final class NetworkMonitor {
    static let shared = NetworkMonitor()
    let networkLogger = Logger(subsystem: "com.gof.TechEx", category: "Network")
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")

    private(set) var isExpensive = false
    private(set) var isConstrained = false

    private init() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isExpensive = path.isExpensive
            self?.isConstrained = path.isConstrained
            self?.networkLogger.debug("Network path got expensive: \(path.isExpensive)")
            self?.networkLogger.debug("Network path got isConstrained: \(path.isConstrained)")
        }
        monitor.start(queue: queue)
    }
}

enum ImageQuality {
    case low, medium, high
}

struct ImageVariantSelector {
    static func selectFormat() -> ImageQuality {
        let network = NetworkMonitor.shared

        if network.isConstrained || network.isExpensive {
            return .low
        } else {
            return .high
        }
    }
}
