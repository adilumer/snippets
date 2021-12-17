//
//  Data.swift
//
//  Created by Adil Umer on 8.09.2020.
//  Copyright © 2020. All rights reserved.
//

import Foundation
extension Data {

    mutating func append(_ string: String, using encoding: String.Encoding = .utf8) {
        if let data = string.data(using: encoding) {
            append(data)
        }
    }
    
    private static let mimeTypeSignatures: [UInt8 : String] = [
            0xFF : "image/jpeg",
            0x89 : "image/png",
            0x47 : "image/gif",
            0x49 : "image/tiff",
            0x4D : "image/tiff",
            0x25 : "application/pdf",
            0xD0 : "application/vnd",
            0x46 : "text/plain",
            ]

    var mimeType: String {
        var c: UInt8 = 0
        copyBytes(to: &c, count: 1)
        return Data.mimeTypeSignatures[c] ?? "application/octet-stream"
    }
}
