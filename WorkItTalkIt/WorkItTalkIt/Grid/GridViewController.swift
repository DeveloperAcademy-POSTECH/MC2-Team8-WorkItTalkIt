//
//  GridViewController.swift
//  WorkItTalkIt
//
//  Created by 김수진 on 2022/06/14.
//

import UIKit

class GridViewController: UIViewController {

    let gridMatrixSize: (Int, Int) = (6, 4)

    let unitSize: Int = Grid.shared.unitSize
    let unitSpace: Int = Grid.shared.unitSpace

    private var gridPositionViews: [UIView] = []
    private var gridPositions: [CGPoint] {
        var gridInnerPositions = gridPositionViews.map { $0.frame.origin }
        for index in 0..<gridInnerPositions.count {
            var position = gridInnerPositions[index]
            position.x = position.x + gridView.layer.position.x - gridView.frame.width / 2
            position.y = position.y + gridView.layer.position.y - gridView.frame.height / 2
            gridInnerPositions[index] = position
        }
        return gridInnerPositions
    }

    private let gridView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())

    var tools: [ToolView] = [] {
        didSet {
            for tool in tools {
                tool.translatesAutoresizingMaskIntoConstraints = false
                let gestureRecognizer = UIPanGestureRecognizer()
                tool.addGestureRecognizer(gestureRecognizer)
                gestureRecognizer.addTarget(self, action: #selector(toolPanned(recognizer:)))
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        layout()
        addGridDetailView()

        for toolSize in ToolSize.allCases[0...2] {
            let tool: ToolView = {
                return $0
            }(ToolView(size: toolSize))
            tool.setToolShadow()
            view.addSubview(tool)
            tools.append(tool)
        }

    }

    private func layout() {
        view.addSubview(gridView)
        NSLayoutConstraint.activate([
            gridView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gridView.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            gridView.widthAnchor.constraint(equalToConstant: CGFloat(Float(((unitSize) * gridMatrixSize.0) + (unitSpace * (gridMatrixSize.0 - 1))))),
            gridView.heightAnchor.constraint(equalToConstant: CGFloat(Float(((unitSize) * gridMatrixSize.1) + (unitSpace * (gridMatrixSize.1 - 1)))))
        ])

    }

    private var initialOffset: CGPoint = .zero

    @objc private func toolPanned(recognizer: UIPanGestureRecognizer) {
        let touchPoint = recognizer.location(in: view)
        guard let attachedView = recognizer.view as? ToolView else { return }
        switch recognizer.state {
        case .began:
            initialOffset = CGPoint(x: touchPoint.x - attachedView.frame.origin.x, y: touchPoint.y - attachedView.frame.origin.y)
        case .changed:
            attachedView.frame.origin = CGPoint(x: touchPoint.x - initialOffset.x, y: touchPoint.y - initialOffset.y)
        case .ended, .cancelled:
            let velocity = recognizer.velocity(in: view)
            let projectedPosition = CGPoint(x: attachedView.frame.origin.x, y: attachedView.frame.origin.y)
            let nearestCornerPosition = nearestCorner(to: projectedPosition, attachedView: attachedView)
            let relativeInitialVelocity = CGVector(
                dx: relativeVelocity(forVelocity: velocity.x, from: attachedView.frame.origin.x, to: nearestCornerPosition.x),
                dy: relativeVelocity(forVelocity: velocity.y, from: attachedView.frame.origin.y, to: nearestCornerPosition.y)
            )
            let timingParameters = UISpringTimingParameters(damping: 1, response: 0.4, initialVelocity: relativeInitialVelocity)
            let animator = UIViewPropertyAnimator(duration: 0, timingParameters: timingParameters)
            animator.addAnimations {
                attachedView.frame.origin = nearestCornerPosition
            }
            animator.startAnimation()

            addPreviousPositions(attachedView: attachedView)
            deleteSelectedPositions(attachedView: attachedView, originPosition: nearestCornerPosition)

        default: break
        }
    }

    /// Finds the position of the nearest corner to the given point.
    private func nearestCorner(to point: CGPoint, attachedView: ToolView) -> CGPoint {
        var minDistance = CGFloat.greatestFiniteMagnitude
        var closestPosition = CGPoint.zero
        var toolsGridPositions: [CGPoint] {
            var gridInnerPositions = attachedView.grids.map { $0.frame.origin }
            for index in 0..<gridInnerPositions.count {
                var position = gridInnerPositions[index]
                position.x = position.x + gridView.layer.position.x - gridView.frame.width / 2
                position.y = position.y + gridView.layer.position.y - gridView.frame.height / 2
                gridInnerPositions[index] = position
            }
            return gridInnerPositions
        }
        var validGridPostions = [CGPoint]()
        validGridPostions += gridPositions
        validGridPostions += toolsGridPositions

        for position in validGridPostions {
            let distance = point.distance(to: position)
            if distance < minDistance && checkGridIsMovable(attachedView: attachedView, movedPosition: position, validGridPostions: validGridPostions) {
                closestPosition = position
                minDistance = distance
            }
        }
        return closestPosition
    }

    private func checkGridIsMovable(attachedView: ToolView, movedPosition: CGPoint, validGridPostions: [CGPoint]) -> Bool {
        var coordinate: CGPoint
        var movable = true

        for row in 0...attachedView.size.row - 1 {
            coordinate = CGPoint(x: movedPosition.x, y: movedPosition.y + CGFloat(row * (unitSize + unitSpace)))
            if !validGridPostions.contains(coordinate) {
                movable = false
                break
            }
            coordinate = CGPoint(x: movedPosition.x + CGFloat((attachedView.size.col - 1) * (unitSize + unitSpace)), y: movedPosition.y + CGFloat(row * (unitSize + unitSpace)))
            if !validGridPostions.contains(coordinate) {
                movable = false
                break
            }
        }

        for col in 0...attachedView.size.col - 1 {
            coordinate = CGPoint(x: movedPosition.x + CGFloat(col * (unitSize + unitSpace)), y: movedPosition.y)
            if !validGridPostions.contains(coordinate) {
                movable = false
                break
            }
            coordinate = CGPoint(x: movedPosition.x + CGFloat(col * (unitSize + unitSpace)), y: movedPosition.y + CGFloat((attachedView.size.row - 1) * (unitSize + unitSpace)))
            if !validGridPostions.contains(coordinate) {
                movable = false
                break
            }
        }

        return movable
    }

    /// Calculates the relative velocity needed for the initial velocity of the animation.
    private func relativeVelocity(forVelocity velocity: CGFloat, from currentValue: CGFloat, to targetValue: CGFloat) -> CGFloat {
        guard currentValue - targetValue != 0 else { return 0 }
        return velocity / (targetValue - currentValue)
    }

    private func deleteSelectedPositions(attachedView: ToolView, originPosition: CGPoint) {
        var positionIndex: Int
        var coordinate: CGPoint

        if attachedView.size == .small {
            positionIndex = gridPositions.firstIndex(of: originPosition) ?? 0
            attachedView.grids.append(gridPositionViews.remove(at: positionIndex))
            print(attachedView.grids.count)
            return
        }

        for row in 0...attachedView.size.row - 1 {
            for col in 0...attachedView.size.col - 1 {
                coordinate = CGPoint(x: originPosition.x + CGFloat(col * (unitSize + unitSpace)), y: originPosition.y + CGFloat(row * (unitSize + unitSpace)))
                positionIndex = gridPositions.firstIndex(of: coordinate) ?? 0
                attachedView.grids.append(gridPositionViews.remove(at: positionIndex))
            }
        }
    }

    private func addPreviousPositions(attachedView: ToolView) {
        if attachedView.grids.isEmpty { return }
        for _ in attachedView.grids {
            gridPositionViews.append(attachedView.grids.removeFirst())
        }
    }

    private func addGridDetailView() {
        for row in 0..<gridMatrixSize.0 {
            for col in 0..<gridMatrixSize.1 {
                var startPoint: CGPoint = .zero // CGPoint(x: unitSize * row, y: unitSize * col)
                if col > 0 {
                    startPoint.x = CGFloat(Float(unitSize * col + unitSpace * (col - 0)))
                }
                if row > 0 {
                    startPoint.y = CGFloat(Float(unitSize * row + unitSpace * (row - 0)))
                }

                let endPoint = CGPoint(x: startPoint.x + CGFloat(Float(unitSize)), y: startPoint.y + CGFloat(Float(unitSize)))

                let unitView: UIView = {
                    $0.translatesAutoresizingMaskIntoConstraints = false
                    $0.layer.borderWidth = 1
                    $0.layer.borderColor = UIColor.systemGray.cgColor
                    return $0
                }(UIView())

                gridView.addSubview(unitView)
                NSLayoutConstraint.activate([
                    unitView.topAnchor.constraint(equalTo: gridView.topAnchor, constant: startPoint.x),
                    unitView.bottomAnchor.constraint(equalTo: gridView.topAnchor, constant: endPoint.x),
                    unitView.leadingAnchor.constraint(equalTo: gridView.leadingAnchor, constant: startPoint.y),
                    unitView.trailingAnchor.constraint(equalTo: gridView.leadingAnchor, constant: endPoint.y)
                ])
                gridPositionViews.append(unitView)
            }
        }
    }

}

extension UISpringTimingParameters {

    /// A design-friendly way to create a spring timing curve.
    ///
    /// - Parameters:
    ///   - damping: The 'bounciness' of the animation. Value must be between 0 and 1.
    ///   - response: The 'speed' of the animation.
    ///   - initialVelocity: The vector describing the starting motion of the property. Optional, default is `.zero`.
    public convenience init(damping: CGFloat, response: CGFloat, initialVelocity: CGVector = .zero) {
        let stiffness = pow(2 * .pi / response, 2)
        let damp = 4 * .pi * damping / response
        self.init(mass: 1, stiffness: stiffness, damping: damp, initialVelocity: initialVelocity)
    }

}
