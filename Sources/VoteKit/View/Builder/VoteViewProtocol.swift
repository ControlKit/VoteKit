//
//  VoteViewProtocol.swift
//
//
//  Created by Maziar Saadatfar on 10/16/23.
//

import Foundation
import UIKit
import ControlKitBase
public protocol VoteViewProtocol: UIView {
    var delegate: VoteDelegate? { get set }
    func setIcon(color: UIColor?, image: String?, imageType: ImageType, imageView: UIImageView)
    func closeButtonIcon(color: UIColor?, image: UIImage?) -> UIImage
}

public extension VoteViewProtocol {
    func setIcon(color: UIColor?, image: String?, imageType: ImageType, imageView: UIImageView) {
        if let color = color, let image = image {
            if image.contains("http"), let url = URL(string: image) {
                imageView.networkImage(from: url)
            } else if let img = UIImage(named: image)?.imageWithColor(color: color) {
                imageView.image = img
            } else {
                let img = ImageHelper.image(imageType.rawValue)?.imageWithColor(color: color)
                imageView.image = img
            }
        } else {
            if let img = image {
                if img.contains("http"), let url = URL(string: img) {
                    imageView.networkImage(from: url)
                } else {
                    imageView.image = UIImage(named: img)
                }
            } else {
                let img = ImageHelper.image(imageType.rawValue)
                imageView.image = img
            }
        }
    }
    
    func closeButtonIcon(color: UIColor?, image: UIImage?) -> UIImage {
        if let color = color, let image = image?.imageWithColor(color: color) {
            return image
        } else if let image = image {
            return image
        } else {
            return ImageHelper.image("close") ?? UIImage()
        }
    }
}
