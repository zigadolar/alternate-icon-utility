//
//  Bundle+Utility.swift
//  AlternateIcons
//
//  Created by Dolar, Ziga on 07/22/2019.
//  Copyright (c) 2019 Dolar, Ziga. All rights reserved.
//

import Foundation

internal extension Bundle {
    static func resourceBundle(for type: AnyClass) -> Bundle? {
        let moduleBundle = Bundle(for: type)
        let moduleName = moduleBundle.resourceURL?.deletingPathExtension().lastPathComponent
        if let path = moduleBundle.path(forResource: moduleName, ofType: "bundle") {
            if let bundle = Bundle(path: path) {
                return bundle
            }
        }
        return nil
    }
}
