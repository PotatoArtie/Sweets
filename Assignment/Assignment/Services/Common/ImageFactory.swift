//
//  ImageFactory.swift
//  Assignment
//
//  Created by Atlas on 2022/08/26.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(url: String) {
        let imageView = UIImageView()
        imageView.kf.setImage(with: URL(string: url),placeholder: UIImage(named: "iconLolAll")) { result in
            switch result {
            case .success(let response):
                self.image = response.image
            case .failure(_):
                self.image = UIImage(systemName: "exclamationmark.triangle")
            }
        }
    }
}


