//
//  UILabel.swift
//  Stam Acasa
//
//  Created by Macbook on 4/14/20.
//  Copyright © 2020 IOs apps. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    func labelHeight() -> CGFloat{
        let labelWidth = self.frame.width
        let maxLabelSize = CGSize(width: labelWidth, height: CGFloat.greatestFiniteMagnitude)
        let actualLabelSize = self.text!.boundingRect(with: maxLabelSize, options: [.usesLineFragmentOrigin], attributes: [.font: self.font], context: nil)
        let labelHeight = actualLabelSize.height
        return labelHeight
    }
}
