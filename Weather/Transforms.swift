//
//  Transforms.swift
//  Weather
//
//  Created by Vladislav Dorfman on 30/04/2017.
//  Copyright © 2017 Vladislav Dorfman. All rights reserved.
//

import Foundation
import ObjectMapper
class DateTransform : TransformType {
    func transformFromJSON(_ value: Any?) -> Date? {
        return Date(dateString: value as! String, format: Config.dateFormat)
    }
    func transformToJSON(_ value: Date?) -> String? {
        return value?.format(with: Config.dateFormat)
    }
}
