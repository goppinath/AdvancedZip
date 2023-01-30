//
//  AdvancedZip.swift
//
//
//  Created by Goppinath Thurairajah on 29.01.23.
//

import Foundation
import ObjCAdvancedZip

public struct AdvancedZip {
    
    public enum Error: Swift.Error {
        case couldNotCreateZipFile
    }
    
    public static func unzipFile(at sourceURL: URL,
                                 to destinationURL: URL,
                                 overwrite: Bool,
                                 password: String?) throws {
        try SSZipArchive.unzipFile(atPath: sourceURL.path,
                                   toDestination: destinationURL.path,
                                   overwrite: overwrite,
                                   password: password)
    }
    
    public static func zip(contentsOfDirectoryURL sourceURL: URL, to destinationURL: URL) throws {
        guard SSZipArchive.createZipFile(atPath: destinationURL.path, withContentsOfDirectory: sourceURL.path) else {
            throw Error.couldNotCreateZipFile
        }
    }
}
