//
//  Views.swift
//  Todo
//
//  Created by Tevin Mantock on 2/11/18.
//  Copyright © 2018 Tevin Mantock. All rights reserved.
//

import UIKit

extension UIView {
	func anchor(top: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingRight: CGFloat, paddingBottom: CGFloat, paddingLeft: CGFloat, height: CGFloat, width: CGFloat) {
		translatesAutoresizingMaskIntoConstraints = false

		if let top = top {
			topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
		}

		if let right = right {
			rightAnchor.constraint(equalTo: right, constant: paddingRight).isActive = true
		}

		if let bottom = bottom {
			bottomAnchor.constraint(equalTo: bottom, constant: paddingBottom).isActive = true
		}

		if let left = left {
			leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
		}

		if height != 0 {
			heightAnchor.constraint(equalToConstant: height).isActive = true
		}

		if width != 0 {
			widthAnchor.constraint(equalToConstant: width).isActive = true
		}
	}
}
