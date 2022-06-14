//
//  CGPoint+.swift
//  WorkItTalkIt
//
//  Created by 김수진 on 2022/06/14.
//

import CoreGraphics

extension CGPoint {

    /// Calculates the distance between two points in 2D space.
    /// + returns: The distance from this point to the given point.
    func distance(to point: CGPoint) -> CGFloat {
        return sqrt(pow(point.x - self.x, 2) + pow(point.y - self.y, 2))
    }

}
