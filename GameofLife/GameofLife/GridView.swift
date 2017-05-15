//
//  GridView.swift
//  GameofLife
//
//  Created by Chauhan, Yogesh on 5/14/17.
//  Copyright © 2017 Darshit, Vikas. All rights reserved.
//

import Foundation
import UIKit

public class GridView: UIView {
    private var _gridWidth = 10
    private var _gridHeight = 10
    private var _cellViews: [CellView]
    
    public init(gridWidth: Int, gridHeight: Int, width: Int, height: Int) {
        // Init values
        _gridWidth = gridWidth
        _gridHeight = gridHeight
        
        _cellViews = Array(repeating: CellView(), count: _gridWidth * _gridHeight)
        
        super.init(frame: CGRect(x: 0, y: 0, width: width, height: height))
        _init(gridWidth: gridWidth, gridHeight: gridHeight)
    }
    
    required public init(coder: NSCoder) {
        
        _cellViews = Array(repeating: CellView(), count: _gridWidth * _gridHeight)
        
        super.init(coder: coder)!
        _init(gridWidth: _gridWidth, gridHeight: _gridHeight)
    }
    
    private func _init(gridWidth: Int, gridHeight: Int) {
        
        // Fill the matrix with views
        for i in 0 ..< gridHeight {
            for j in 0 ..< gridWidth {
                let cellView = CellView(frame: CGRect.init())
                cellView.coordinates = (x: i, y: j)
                addSubview(cellView)
                
                _cellViews[(i * gridWidth) + j] = cellView
            }
        }
    }
    
    public func toggleCell(at: CellCoordinates) {
        // Toggle the state of the model
        let cell = _cellViews[(at.x * _gridWidth) + at.y]
        cell.setAlive(value: !cell.isAlive())
    }
    
    public func clear() {
        for i in 0 ..< _gridHeight {
            for j in 0 ..< _gridWidth {
                let cellView = _cellViews[(i * _gridWidth) + j]
                cellView.setAlive(value: false)
            }
        }
    }

    public func step() {
        // Find the tiles that must be toggled and mark them
        for i in 0 ..< _gridHeight {
            for j in 0 ..< _gridWidth {
                let neighbours = getAliveNeighbours(coordinates: (x: i, y: j))
                let cellView = _cellViews[(i * _gridWidth) + j]
                
                if cellView.isAlive() {
                    if neighbours.count < 2 || neighbours.count > 3 {
                        cellView.shouldToggleState = true
                        
                    }
                } else {
                    if neighbours.count == 3 { cellView.shouldToggleState = true }
                }
            }
        }
        
        for i in 0 ..< _gridHeight {
            for j in 0 ..< _gridWidth {
                let cellView = _cellViews[(i * _gridWidth) + j]
                
                if cellView.shouldToggleState {
                    cellView.setAlive(value: !cellView.isAlive())
                    cellView.shouldToggleState = false
                }
            }
        }
    }
    
    public func getAliveNeighbours(coordinates: CellCoordinates) -> [CellView] {
        var neighbours = [CellView]()
        let neighboursDelta = [(1, 0), (0, 1), (-1, 0), (0, -1),
                               (1, 1), (-1, 1), (-1, -1), (1, -1)]
        
        for (deltaX, deltaY) in neighboursDelta {
            let x = coordinates.x + deltaX
            let y = coordinates.y + deltaY
            
            if x < 0 || x >= _gridHeight { continue }
            if y < 0 || y >= _gridWidth { continue }
            
            let cellView = _cellViews[(x * _gridWidth) + y]
            if(cellView.isAlive()){
                neighbours.append(cellView)
            }
        }
        
        return neighbours
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        _layoutTiles()
    }
    
    private func _layoutTiles() {
        for i in 0 ..< _gridHeight {
            for j in 0 ..< _gridWidth {
                let cellView = _cellViews[(i * _gridWidth) + j]
                cellView.frame = cellFrame(coordinates: (x: i, y: j))
            }
        }
    }
    
    private var cellSize: CGSize {
        return CGSize(
            width: bounds.width / CGFloat(_gridWidth),
            height: bounds.height / CGFloat(_gridHeight)
        )
    }
    
    private func cellOrigin(coordinates: CellCoordinates) -> CGPoint {
        return CGPoint(
            x: CGFloat(coordinates.x) * cellSize.width,
            y: CGFloat(coordinates.y) * cellSize.height
        )
    }
    
    private func cellFrame(coordinates: CellCoordinates) -> CGRect {
        return CGRect(
            origin: cellOrigin(coordinates: coordinates),
            size: cellSize
        )
    }
    
}
