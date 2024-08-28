//
//  Array+Extension.swift
//  CSTV
//
//  Created by Lucas Brandão on 28/08/24.
//

import Foundation

extension Array {
    /// Safely returns the element at the specified index if it is within bounds, otherwise returns `nil`.
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
