//
//  ImageCellCollectionViewCell.swift
//  PinBoard
//
//  Created by echo on 5/12/18.
//  Copyright © 2018 echo. All rights reserved.
//

import UIKit
import Downloader

class ImageCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var likesCountLabel: UILabel!
    @IBOutlet weak var favIconImageView: UIImageView!
    @IBOutlet weak var gradientView: UIView!
    
    var gradientLayer: CAGradientLayer?
    
    var imageData: ImageData? {
        didSet {
            
            if imageData?.likedByUser ?? false {
                favIconImageView.image = UIImage(named: "fav-selected")?.withRenderingMode(.alwaysTemplate)
            } else {
                favIconImageView.image = UIImage(named: "fav")?.withRenderingMode(.alwaysTemplate)
            }
            
            favIconImageView.tintColor = UIColor.white
            likesCountLabel.text = "\(imageData?.likes ?? 0)"
            
            if let url = imageData?.urls?.thumb {
                let request = URLRequest(url: url)
                DownloadManager.shared().download(with: request) { [weak self] (image: UIImage?, request, error) in
                    
                    guard request?.url == self?.imageData?.urls?.thumb else {
                        return
                    }
                    
                    self?.imageView.image = image
                    if self?.imageView.image == nil {
                        self?.gradientLayer?.locations = [0.25]
                    } else {
                        self?.gradientLayer?.locations = [0.7]
                    }
                }.start()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // calls the setters
        imageData = nil
        
        //hidden in story board
        gradientView.isHidden = false
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer?.removeFromSuperlayer()
        
        if gradientLayer == nil {
            let layer = CAGradientLayer()
            
            gradientLayer = layer
        }
        
        gradientLayer?.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
//        gradientLayer?.locations = [0.55]
        
//        gradientLayer?.startPoint = CGPoint(x: gradientView.frame.size.width * 0.5, y: 0.0)
//        gradientLayer?.endPoint = CGPoint(x: gradientView.frame.size.width * 0.5, y: 100.0)
        gradientLayer?.frame = CGRect(x: 0.0, y: 0.0, width: self.frame.size.width, height: self.frame.size.height)
        
        if let layer = gradientLayer {
            gradientView.layer.addSublayer(layer)
        }
    }
    
    override var frame: CGRect {
        didSet {
            gradientLayer?.frame = CGRect(x: 0.0, y: 0.0, width: imageView.frame.size.width, height: imageView.frame.size.height)
        }
    }

}
