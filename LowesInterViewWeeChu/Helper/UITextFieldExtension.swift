//
//  UITextFieldExtension.swift
//  LowesInterViewWeeChu
//
//  Created by Coding on 9/19/22.
//

import Foundation
import UIKit

extension UITextField {
    
    //MARK: set left icon in the search bar
    func setLeftIcon(imageName: String) {
        
        let size = 15
        let padding = 10
        
        let icon = UIImage(systemName: imageName)
        
        let imageView = UIImageView(frame: CGRect(x: padding, y: 0, width: size, height: size))
        imageView.image = icon
        let container = UIView(frame: CGRect(x: 0, y: 0, width: padding + size, height: size))
        container.addSubview(imageView)
        
        self.leftView = container
        self.leftViewMode = .always
    }

}
