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

        lockImage.layer.shadowOffset = CGSize(width: 1, height: 1)
        lockImage.layer.shadowColor = UIColor.black.cgColor
        lockImage.layer.shadowOpacity = 0.1
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
        selectedBackgroundView?.isHidden = !selected

        layer.borderColor = tintColor.cgColor
        layer.borderWidth = selected ? 1 : 0
    }
}
