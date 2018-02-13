//
//  ModalViewController.swift
//  Todo
//
//  Created by Tevin Mantock on 2/11/18.
//  Copyright © 2018 Tevin Mantock. All rights reserved.
//

import UIKit

class ModalViewController: UIViewController {
	weak var delegate : ModalViewControllerDelegate?

	let modalTransition = ModalTransitionDelegate()

	let cancelButton : UIButton = {
		let button = UIButton(type: .system)
		button.setTitle("Cancel", for: .normal)
		button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
		button.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)

		return button
	}()

	let submitButton : UIButton = {
		let button = UIButton(type: .system)
		button.setTitle("Submit", for: .normal)
		button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
		button.addTarget(self, action: #selector(submitButtonPressed), for: .touchUpInside)

		return button
	}()

	let actionBar : UIView = {
		let view = UIView()
		view.backgroundColor = UIColor.flatGray().withAlphaComponent(0.6)

		return view
	}()

	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

		transitioningDelegate = modalTransition
		modalPresentationStyle = .custom
		modalTransitionStyle = .coverVertical
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

    override func viewDidLoad() {
        super.viewDidLoad()

		view.backgroundColor = .white
		let stackView = UIStackView(arrangedSubviews: [cancelButton, submitButton])
		stackView.axis = .horizontal
		stackView.distribution = .fillEqually
		stackView.spacing = 200
		actionBar.addSubview(stackView)
		stackView.anchor(top: actionBar.topAnchor, right: actionBar.rightAnchor, bottom: nil, left: actionBar.leftAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, height: 0, width: 0)
		view.addSubview(actionBar)
		actionBar.anchor(top: view.topAnchor, right: view.rightAnchor, bottom: nil, left: view.leftAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, height: 35, width: view.frame.width)
    }

	// Available for overrides
	@objc func cancelButtonPressed() {
		dismiss(animated: true, completion: nil)
	}
	// Available for overrides
	@objc func submitButtonPressed() {
		delegate?.modalIsClosing()
		dismiss(animated: true, completion: nil)
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
	}
}

protocol ModalViewControllerDelegate : class {
	func modalIsClosing()
}
