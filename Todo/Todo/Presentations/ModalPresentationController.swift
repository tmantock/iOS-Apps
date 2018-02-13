//
//  ModalPresentationController.swift
//  Todo
//
//  Created by Tevin Mantock on 2/11/18.
//  Copyright © 2018 Tevin Mantock. All rights reserved.
//

import UIKit

class ModalPresentationController: UIPresentationController {
	let blurEffectView : UIVisualEffectView
	var tapGestureRecognizer : UITapGestureRecognizer = UITapGestureRecognizer()

	override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
		let blurEffect = UIBlurEffect(style: .dark)
		blurEffectView = UIVisualEffectView(effect: blurEffect)

		super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
		tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismiss))
		blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		self.blurEffectView.isUserInteractionEnabled = true
		self.blurEffectView.addGestureRecognizer(tapGestureRecognizer)
	}

	@objc func dismiss() {
		self.presentedViewController.dismiss(animated: true, completion: nil)
	}

	override var frameOfPresentedViewInContainerView: CGRect {
		return CGRect(origin: CGPoint(x: 0, y: self.containerView!.frame.height * 0.05), size: CGSize(width: self.containerView!.frame.width, height: self.containerView!.frame.height * 0.95))
	}

	override func dismissalTransitionWillBegin() {
		self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) in
			self.blurEffectView.alpha = 0
		}, completion: { (UIViewControllerTransitionCoordinatorContext) in
			self.blurEffectView.removeFromSuperview()
		})
	}

	override func presentationTransitionWillBegin() {
		self.blurEffectView.alpha = 0
		self.containerView?.addSubview(blurEffectView)
		self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) in
			self.blurEffectView.alpha = 1
		}, completion: { (UIViewControllerTransitionCoordinatorContext) in

		})
	}

	override func containerViewWillLayoutSubviews() {
		super.containerViewWillLayoutSubviews()
		presentedView!.layer.masksToBounds = true
		presentedView!.layer.cornerRadius = 10
	}

	override func containerViewDidLayoutSubviews() {
		super.containerViewDidLayoutSubviews()
		self.presentedView?.frame = frameOfPresentedViewInContainerView
		blurEffectView.frame = containerView!.bounds
	}
}

class ModalTransitionDelegate : NSObject, UIViewControllerTransitioningDelegate {
	func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
		return ModalPresentationController(presentedViewController: presented, presenting: presenting)
	}
}
