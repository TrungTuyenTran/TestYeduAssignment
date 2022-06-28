//
//  UIImageView+Extensions.swift
//  TestAsignment
//
//  Created by Tran Tuyen on 27/06/2022.
//

import Foundation
import UIKit

extension UIImageView {
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func getOrDownloadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        if let data = UserDefaults.standard.data(forKey: url.absoluteString) {
            self.image = UIImage(data: data)
            return
        }
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            UserDefaults.standard.set(data, forKey: url.absoluteString)
            // always update the UI from the main thread
            DispatchQueue.main.async() { [weak self] in
                self?.image = UIImage(data: data)
            }
        }
    }
}
