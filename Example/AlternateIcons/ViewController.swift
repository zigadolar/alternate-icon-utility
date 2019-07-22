//
//  ViewController.swift
//  AlternateIcons
//
//  Created by Dolar, Ziga on 07/22/2019.
//  Copyright (c) 2019 Dolar, Ziga. All rights reserved.
//

import UIKit

import AlternateIcons

class ViewController: UIViewController {

    @IBOutlet var currentIcon: UIImageView!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        currentIcon.image = IconsUtility().currentIcon.iconImage
    }

    @IBAction func showIconPicker(_ sender: UIButton) {
        guard let iconController = IconTableViewController.load() else {
            return
        }

        iconController.delegate = self
        iconController.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(dismissController))

        let navigationController = UINavigationController(rootViewController: iconController)

        show(navigationController, sender: self)
    }

    @objc func dismissController() {
        dismiss(animated: true)
    }
}

extension ViewController: IconViewControllerDelegate {
    func iconViewController(_ viewController: UIViewController, didTapPremium icon: Icon) {
        debugPrint(icon.description)
    }
}

