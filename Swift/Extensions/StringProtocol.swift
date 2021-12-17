//
//  StringProtocol.swift
//
//  Created by Adil Umer on 2.11.2020.
//  Copyright © 2020. All rights reserved.
//

import Foundation

extension StringProtocol {
    // `where Index == String.Index`
    var byWords: [SubSequence] {
        var byWords: [SubSequence] = []
        enumerateSubstrings(in: startIndex..., options: .byWords) { _, range, _, _ in
            byWords.append(self[range])
        }
        return byWords
    }
}

