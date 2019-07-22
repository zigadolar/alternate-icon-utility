//
//  IconTableViewController.swift
//  AlternateIcons
//
//  Created by Dolar, Ziga on 07/22/2019.
//  Copyright (c) 2019 Dolar, Ziga. All rights reserved.
//

import UIKit

public protocol IconViewControllerDelegate: AnyObject {
    func iconViewController(_ viewController: UIViewController, didTapPremium icon: Icon)
}

public final class IconTableViewController: UITableViewController {

    private var iconSets: [IconsSet] = []
    private var utility: IconsUtility = IconsUtility()
    private var hasPremium: Bool = false

    public weak var delegate: IconViewControllerDelegate?

    public static func load(with iconSets: [IconsSet]? = nil, hasPremium: Bool = false, shouldHidePremium: Bool = false) -> IconTableViewController? {
        if #available(iOS 10.3, *) {
            let storyboard = UIStoryboard(name: "IconSelection", bundle: Bundle.resourceBundle(for: self.classForCoder()))

            guard
                let controller = storyboard.instantiateViewController(withIdentifier: String(describing: IconTableViewController.self)) as? IconTableViewController else {
                    return nil
            }

            controller.configure(with: iconSets, premium: hasPremium, hidePremium: shouldHidePremium)
            controller.view.frame = UIScreen.main.bounds

            return controller
        }

        return nil
    }

    override public func viewDidLoad() {
        super.viewDidLoad()

        view.layoutIfNeeded()
    }

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        tableView.reloadData()
    }

    private var current: Icon {
        return utility.currentIcon
    }

    private func configure(with iconSets: [IconsSet]? = nil, premium: Bool = false, hidePremium: Bool = false) {

        var sets = iconSets ?? utility.iconSets

        if hidePremium {
            var filteredSets: [IconsSet] = []

            sets.forEach { set in
                let icons = set.icons.filter { !$0.premium }

                filteredSets.append(IconsSet(name: set.name, icons: icons))
            }

            sets = filteredSets.filter { !$0.icons.isEmpty }
        }

        self.iconSets = sets

        self.hasPremium = premium

        tableView.reloadData()
    }

    // MARK: - Table view data source

    override public func numberOfSections(in tableView: UITableView) -> Int {
        return iconSets.count
    }

    override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return iconSets[section].icons.count
    }

    override public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
         return iconSets[section].name
    }

    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "IconTableViewCell", for: indexPath) as? IconTableViewCell {

            let icon = iconSets[indexPath.section].icons[indexPath.row]

            cell.nameLabel.text = icon.description
            cell.iconImage.image = icon.iconImage
            cell.accessoryView = nil
            cell.accessoryType = icon == current ? .checkmark : .none

            if icon.premium && !hasPremium {
                let lockImage = UIImageView(image: UIImage(named: "lockIcon", in: Bundle.resourceBundle(for: type(of: self)), compatibleWith: nil))
                lockImage.tintColor = UIColor.black.withAlphaComponent(0.15)
                cell.accessoryView = lockImage
            }

            return cell
        }

        return UITableViewCell()
    }

    override public func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        let icon = iconSets[indexPath.section].icons[indexPath.row]

        return icon != current
    }

    override public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let icon = iconSets[indexPath.section].icons[indexPath.row]

        guard icon != current else { return }

        if !hasPremium {
            guard !icon.premium else {
                delegate?.iconViewController(self, didTapPremium: icon)

                return
            }
        }

        icon.set()

        tableView.reloadData()
    }
}
