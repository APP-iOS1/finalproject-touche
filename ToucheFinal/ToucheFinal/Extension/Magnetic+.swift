//
//  Magnetic+.swift
//  ToucheFinal
//
//  Created by 조석진 on 2023/01/31.
//

import Magnetic
import SpriteKit

extension Magnetic {
    func skip() {
        let speed = physicsWorld.speed
        physicsWorld.speed = 0
        let actions = skipActions()
        run(.sequence(actions)) { [unowned self] in
            self.physicsWorld.speed = speed
        }
    }
    
    func sortedNodes() -> [Node] {
        return children.compactMap { $0 as? Node }.sorted { node, nextNode in
            let distance = node.position.distance(from: magneticField.position)
            let nextDistance = nextNode.position.distance(from: magneticField.position)
            return distance < nextDistance && node.isSelected
        }
    }
    
    func skipActions() -> [SKAction] {
        var actions = [SKAction]()
        for (index, node) in sortedNodes().enumerated() {
            node.physicsBody = nil
            let action = SKAction.run { [unowned self, unowned node] in
                let point = CGPoint(x: self.size.width / 2, y: self.size.height + 40)
                let movingXAction = SKAction.moveTo(x: point.x, duration: 0.2)
                let movingYAction = SKAction.moveTo(y: point.y, duration: 0.4)
                let resize = SKAction.scale(to: 0.3, duration: 0.4)
                let throwAction = SKAction.group([movingXAction, movingYAction, resize])
                node.run(throwAction) { [unowned node] in
                    node.removeFromParent()
                }
            }
            actions.append(action)
            let delay = SKAction.wait(forDuration: TimeInterval(index) * 0.002)
            actions.append(delay)
        }
        return actions
    }
}
