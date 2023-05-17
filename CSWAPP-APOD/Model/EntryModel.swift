//
//  EntryModel.swift
//  CSWAPP-APOD
//
//  Created by Colton Swapp on 5/17/23.
//

import Foundation
import Combine
import SwiftUI

struct Entry: Decodable, Hashable {
    var title: String
    var copyright: String?
    var date: String
    var explanation: String
    var url: String
}
