//
//  DiskCacheManager.swift
//  TechEx
//
//  Created by macbook on 21/12/2025.
//

import Foundation
import OSLog

final class DiskCache: DiskCacheProtocol {
    static let shared = DiskCache()
    let pathLogger = Logger(subsystem: "com.gof.TechEx", category: "diskCache")
    private let directory: URL

    private init() {
        directory = FileManager.default
            .urls(for: .cachesDirectory, in: .userDomainMask)[0]
            .appending(path: "ImageCache")
        try? FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
    }

    func fileURL(for url: URL) -> URL {
//        pathLogger.debug("\(self.directory.appending(path: url.lastPathComponent))")
        return directory.appending(path: url.lastPathComponent)
    }
}
