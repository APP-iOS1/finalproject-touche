//
//  CGFloat+.swift
//  ToucheFinal
//
//  Created by 조석진 on 2023/01/31.
//

import Foundation

extension CGPoint {
    func distance(from point: CGPoint) -> CGFloat {
        return hypot(point.x - x, point.y - y)
    }
}
