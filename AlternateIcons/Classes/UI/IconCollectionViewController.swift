//
//  IconCollectionViewController.swift
//  AlternateIcons
//
//  Created by Dolar, Ziga on 8/13/19.
//

import UIKit

//private let reuseIdentifier = "IconCollectionViewCell"

public class IconCollectionViewController: UICollectionViewController {

    private var iconSets: [IconsSet] = []
    private var utility: IconsUtility = IconsUtility()
    private var hasPremium: Bool = false

    public weak var delegate: IconViewControllerDelegate?

    public static func load(with iconSets: [IconsSet]? = nil, hasPremium: Bool = false, shouldHidePremium: Bool = false) -> IconCollectionViewController? {
        
        if #available(iOS 10.3, *) {
            let storyboard = UIStoryboard(name: "IconSelection", bundle: Bundle.resourceBundle(for: self.classForCoder()))

            guard
                let controller = storyboard.instantiateViewController(withIdentifier: String(describing: IconCollectionViewController.self)) as? IconCollectionViewController else {
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

        if #available(iOS 11.0, *) {
            collectionView?.contentInsetAdjustmentBehavior = .always
        }

        view.layoutIfNeeded()
    }

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        collectionView.reloadData()
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

        collectionView.reloadData()
    }

    // MARK: UICollectionViewDataSource

    override public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return iconSets.count
    }


    override public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return iconSets[section].icons.count
    }

    override public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "IconCollectionViewCell",
                for: indexPath
            ) as? IconCollectionViewCell
        else {
            return UICollectionViewCell()
        }

        let icon = iconSets[indexPath.section].icons[indexPath.row]

        cell.nameLabel.text = icon.description
        cell.iconImage.image = icon.iconImage

        cell.isCurrent = icon == current

        let premiumCell = icon.premium && !hasPremium

        cell.lockImage.tintColor = .white
        cell.lockImage.isHidden = !premiumCell
        cell.iconImage.alpha = premiumCell ? 0.5 : 1

        return cell
    }

    override public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        if kind == UICollectionView.elementKindSectionHeader,
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                             withReuseIdentifier: "IconCollectionReusableHeaderView",
                                                                             for: indexPath) as? IconCollectionReusableHeaderView {
            headerView.title.text = iconSets[indexPath.section].name
            headerView.title.backgroundColor = .white
            headerView.title.layer.cornerRadius = 6
            headerView.title.layer.masksToBounds = true

            return headerView
        }

        return UICollectionReusableView()
    }

    // MARK: UICollectionViewDelegate

    override public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)

        let icon = iconSets[indexPath.section].icons[indexPath.row]

        guard icon != current else { return }

        if !hasPremium {
            guard !icon.premium else {
                delegate?.iconViewController(self, didTapPremium: icon)

                return
            }
        }

        icon.set()

        collectionView.reloadData()
    }

    override public func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        let icon = iconSets[indexPath.section].icons[indexPath.row]

        return icon != current
    }
}
