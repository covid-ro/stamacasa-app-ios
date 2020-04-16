//
//  PaddingLabel.swift
//  Stam Acasa
//
//  Created by Macbook on 4/16/20.
//  Copyright © 2020 IOs apps. All rights reserved.
//

import Foundation
import UIKit

class PaddingLabel: UILabel {

   @IBInspectable var topInset: CGFloat = 15.0
   @IBInspectable var bottomInset: CGFloat = 15.0
   @IBInspectable var leftInset: CGFloat = 20.0
   @IBInspectable var rightInset: CGFloat = 20.0

   override func drawText(in rect: CGRect) {
      let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
    super.drawText(in: rect.inset(by: insets))
   }

   override var intrinsicContentSize: CGSize {
      get {
         var contentSize = super.intrinsicContentSize
         contentSize.height += topInset + bottomInset
         contentSize.width += leftInset + rightInset
         return contentSize
      }
   }
}
