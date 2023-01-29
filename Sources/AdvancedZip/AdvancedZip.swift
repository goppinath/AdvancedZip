//
//  AdvancedZip.swift
//
//
//  Created by Goppinath Thurairajah on 29.01.23.
//

import Foundation
import ObjCAdvancedZip

public struct AdvancedZip {
    
    public static func unzipFile(at sourceURL: URL,
                                 to destinationURL: URL,
                                 overwrite: Bool,
                                 password: String?) throws {
        try SSZipArchive.unzipFile(atPath: sourceURL.path,
                                   toDestination: destinationURL.path,
                                   overwrite: overwrite,
                                   password: password)
    }
}
