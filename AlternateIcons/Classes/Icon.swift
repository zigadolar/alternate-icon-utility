//
//  Icon.swift
//  AlternateIcons
//
//  Created by Dolar, Ziga on 07/22/2019.
//  Copyright (c) 2019 Dolar, Ziga. All rights reserved.
//

import UIKit

public struct Icon: Equatable {
    public var key: String?
    public let imageName: String
    public let premium: Bool
    public let category: String?

    public var isDefaultIcon: Bool {
        return key == nil
    }

    public var iconImage: UIImage? {
        return UIImage(named: imageName)
    }

    public var description: String {
        return key ?? "Main Icon"
    }

    public func set() {
        if #available(iOS 10.3, *) {
            let application =  UIApplication.shared
            guard application.supportsAlternateIcons else { return }

            application.setAlternateIconName(key)
        }
    }
}

public struct IconsSet {
    public let name: String
    public let icons: [Icon]
}
