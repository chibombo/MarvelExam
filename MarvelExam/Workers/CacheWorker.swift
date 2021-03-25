//
//  CacheWorker.swift
//  MarvelExam
//
//  Created by Luis Genaro Arvizu Vega on 23/03/21.
//

import UIKit

class CacheWorker {
    static let shared = CacheWorker()

    let cache: NSCache<NSString, UIImage>

    private init() {
        cache = NSCache<NSString, UIImage>()
    }

    func getObject(key: String) -> UIImage? {
        guard let image: UIImage = cache.object(forKey: key as NSString)
            else {return nil}
        return image
    }

    func setObject(key: String, image: UIImage) {
        cache.setObject(image, forKey: key as NSString)
    }

    func resetCache() {
        cache.removeAllObjects()
    }

}
