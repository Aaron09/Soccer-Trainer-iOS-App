//
//  extensionUIView.swift
//  Soccer Trainer
//
//  Created by Aaron Green on 7/31/16.
//  Copyright © 2016 Aaron Green. All rights reserved.
//

import UIKit

extension UIView {
    func addBackground(imageName: String, imageView: UIImageView){
        
        imageView.image = UIImage(named: imageName)
        
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        
        self.addSubview(imageView)
        self.sendSubviewToBack(imageView)
    }
}


