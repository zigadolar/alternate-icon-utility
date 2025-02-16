//
//  IconCollectionViewCell.swift
//  AlternateIcons
//
//  Created by Dolar, Ziga on 8/13/19.
//

import UIKit

public class IconCollectionViewCell: UICollectionViewCell {

    @IBOutlet private(set) var nameLabel: UILabel!
    @IBOutlet private(set) var iconImage: UIImageView!
    @IBOutlet private(set) var lockImage: UIImageView!

    public override func awakeFromNib() {
        super.awakeFromNib()

        layer.cornerRadius = 8
        layer.masksToBounds = true

        selectedBackgroundView = UIView()

        lockImage.layer.shadowOffset = CGSize(width: 1, height: 1)
        lockImage.layer.shadowColor = UIColor.black.cgColor
        lockImage.layer.shadowOpacity = 0.1
    }

    var isCurrent: Bool = false {
        didSet {
            contentView.backgroundColor = self.isCurrent ? tintColor.withAlphaComponent(0.1): .clear
        }
    }

    public override var isSelected: Bool {
        didSet {
            configureSelection(self.isSelected)
        }
    }

    public override var isHighlighted: Bool {
        didSet {
            configureSelection(self.isHighlighted || self.isSelected)
        }
    }

    private func configureSelection(_ selected: Bool) {
        selectedBackgroundView?.backgroundColor = tintColor.withAlphaComponent(0.2)

        layer.borderColor = tintColor.withAlphaComponent(0.5).cgColor
        layer.borderWidth = selected ? 1 : 0
    }
}
