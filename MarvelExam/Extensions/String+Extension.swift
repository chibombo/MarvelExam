//
//  String+Extension.swift
//  MarvelExam
//
//  Created by Luis Genaro Arvizu Vega on 23/03/21.
//

import Foundation
import CryptoKit

extension String {
    var MD5: String {
        let computed = Insecure.MD5.hash(data: self.data(using: .utf8)!)
        return computed.map { String(format:"%02hhx", $0)}.joined()
    }
}
