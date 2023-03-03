//
//  Collections.swift
//  Just Trains
//
//  Created by Reilly Freret on 2/22/23.
//

import Foundation

extension Collection {
  /// Returns the element at the specified index if it is within bounds, otherwise nil.
  subscript (safe index: Index) -> Element? {
    return indices.contains(index) ? self[index] : nil
  }
}
