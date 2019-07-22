//
//  IconUtility.swift
//  AlternateIcons
//
//  Created by Dolar, Ziga on 07/22/2019.
//  Copyright (c) 2019 Dolar, Ziga. All rights reserved.
//

import UIKit

public final class IconsUtility {
    public let defaultIcon: Icon
    public let alternateIcons: [Icon]

    public var currentIcon: Icon {
        if #available(iOS 10.3, *) {
            guard let name = UIApplication.shared.alternateIconName else {
                return defaultIcon
            }

            return alternateIcons.first { $0.key == name } ?? defaultIcon
        }

        return defaultIcon
    }

    public lazy var iconSets: [IconsSet] = {
        let allIcons = [self.defaultIcon] + self.alternateIcons
        let iconCategories: [String: [Icon]] = allIcons.reduce(into: [:]) { result, icon in
            let category = icon.category ?? "Default"

            var iconArray = result[category] ?? []
            iconArray.append(icon)

            result[category] = iconArray.sorted {
                if $0.isDefaultIcon {
                    return true
                } else if $1.isDefaultIcon {
                    return false
                } else {
                    return $0.description < $1.description
                }
            }
        }

        return iconCategories.map { IconsSet(name: $0.key, icons: $0.value) }.sorted {
            if $0.name == "Default" {
                return true
            } else if $1.name == "Default" {
                return false
            } else {
                return $0.name < $1.name
            }
        }
    }()

    public init() {
        guard let infoDictionary = Bundle.main.infoDictionary,
            let bundleIcons = infoDictionary["CFBundleIcons"] as? [String: Any] else {
                self.defaultIcon = IconsUtility.fallbackDefaultIcon
                self.alternateIcons = []
                return
        }

        self.defaultIcon = IconsUtility.icon(with: nil, from: bundleIcons["CFBundlePrimaryIcon"] as? [String: Any]) ?? IconsUtility.fallbackDefaultIcon
        self.alternateIcons = IconsUtility.alternateIcons(from: bundleIcons["CFBundleAlternateIcons"] as? [String: Any])
    }

    // MARK: - Private

    private static func alternateIcons(from dictionary: [String: Any]?) -> [Icon] {
        guard let dictionary = dictionary else { return [] }

        return dictionary.compactMap {
            return IconsUtility.icon(with: $0.key, from: $0.value as? [String: Any])
        }
    }

    private static func icon(with key: String?, from dictionary: [String: Any]?) -> Icon? {
        guard let dictionary = dictionary,
            let iconFiles = dictionary["CFBundleIconFiles"] as? [String],
            let iconImageName = iconFiles.last
            else {
                return nil
        }

        let icon = Icon(key: key,
                        imageName: iconImageName,
                        premium: dictionary["AIUIsIconPremium"] as? Bool ?? false,
                        category: dictionary["AIUIconCategory"] as? String)

        return icon.iconImage != nil ? icon : nil
    }

    private static var fallbackDefaultIcon: Icon {
        let size = UIDevice.current.userInterfaceIdiom == .pad ? "76" : "60"
        let name = "AppIcon\(size)x\(size)"

        return Icon(key: nil, imageName: name, premium: false, category: nil)
    }
}
