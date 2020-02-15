//
//  ImageService.swift
//  KinopoiskFilmsApp
//
//  Created by Oleg Sitnikov on 15.02.2020.
//  Copyright © 2020 Oleg Sitnikov. All rights reserved.
//

import Foundation
import UIKit

final class ImageService {
    static public let shared = ImageService()
    private init() {}
    
    let cache: NSCache = NSCache<NSString, UIImage>()
    
    func downloadImage(withURL url: URL, completion: @escaping (_ result: Result<UIImage, Error>) -> ()) {
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            var downloadedImage: UIImage?
            
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
            
            if let data = data {
                downloadedImage = UIImage(data: data)
            }
            if let downloadedImage = downloadedImage {
                self.cache.setObject(downloadedImage, forKey: url.absoluteString as NSString)
            }
            DispatchQueue.main.async {
                completion(.success(downloadedImage ?? #imageLiteral(resourceName: "no_image.jpg")))
            }
        }
        dataTask.resume()
    }
    
    func getImage(withURL url: URL, completion: @escaping (_ result: Result<UIImage, Error>) -> ()) {
        if let image = cache.object(forKey: url.absoluteString as NSString) {
            completion(.success(image))
        } else {
            downloadImage(withURL: url, completion: completion)
        }
    }
}
