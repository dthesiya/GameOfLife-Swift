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
    private var gridWidth = 10
    private var gridHeight = 10
    private var cellViews: [CellView]
    
    public init(gridWidth: Int, gridHeight: Int, width: Int, height: Int, minY: Float) {
        // Init values
        self.gridWidth = gridWidth
        self.gridHeight = gridHeight
        
        cellViews = Array(repeating: CellView(), count: gridWidth * gridHeight)
        
        super.init(frame: CGRect(x: 0, y: Int(minY), width: width, height: height))
        _init(gridWidth: gridWidth, gridHeight: gridHeight, cellWidth:Float(width/gridWidth), minY: minY)
    }
    
    required public init(coder: NSCoder) {
        
        cellViews = Array(repeating: CellView(), count: gridWidth * gridHeight)
        
        super.init(coder: coder)!
        _init(gridWidth: gridWidth, gridHeight: gridHeight, cellWidth: 20, minY: 30)
    }
    
    private func _init(gridWidth: Int, gridHeight: Int, cellWidth: Float, minY: Float) {
        
        // Fill the matrix with views
        for i in 0 ..< gridHeight {
            for j in 0 ..< gridWidth {
                let x = Float(j) * cellWidth
                let y = Float(i) * cellWidth + minY
                let cellView = CellView(frame: CGRect(x: CGFloat(x), y: CGFloat(y), width: CGFloat(cellWidth), height: CGFloat(cellWidth)))
                cellView.coordinates = (x: i, y: j)
                addSubview(cellView)
                
                cellViews[(i * gridWidth) + j] = cellView
            }
        }
    }
    
    public func toggleCell(at: CellCoordinates) {
        // Toggle the state of the model
        let cell = cellViews[(at.x * gridWidth) + at.y]
        cell.setAlive(value: !cell.isAlive())
    }
    
    public func clear() {
        for i in 0 ..< gridHeight {
            for j in 0 ..< gridWidth {
                let cellView = cellViews[(i * gridWidth) + j]
                cellView.setAlive(value: false)
            }
        }
    }

    public func next() {
        // Find the tiles that must be toggled and mark them
        for i in 0 ..< gridHeight {
            for j in 0 ..< gridWidth {
                let neighbours = getAliveNeighbours(coordinates: (x: i, y: j))
                let cellView = cellViews[(i * gridWidth) + j]
                
                if cellView.isAlive() {
                    if neighbours.count < 2 || neighbours.count > 3 {
                        cellView.shouldToggleState = true
                        
                    }
                } else {
                    if neighbours.count == 3 { cellView.shouldToggleState = true }
                }
            }
        }
        
        for i in 0 ..< gridHeight {
            for j in 0 ..< gridWidth {
                let cellView = cellViews[(i * gridWidth) + j]
                
                if cellView.shouldToggleState {
                    cellView.setAlive(value: !cellView.isAlive())
                    cellView.shouldToggleState = false
                }
            }
        }
    }
    
    public func getAliveNeighbours(coordinates: CellCoordinates) -> [CellView] {
        var neighbours = [CellView]()
        let neighboursArr = [(1, 0), (0, 1), (-1, 0), (0, -1),
                               (1, 1), (-1, 1), (-1, -1), (1, -1)]
        
        for (arrX, arrY) in neighboursArr {
            let x = coordinates.x + arrX
            let y = coordinates.y + arrY
            
            if x < 0 || x >= gridHeight { continue }
            if y < 0 || y >= gridWidth { continue }
            
            let cellView = cellViews[(x * gridWidth) + y]
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
        for i in 0 ..< gridHeight {
            for j in 0 ..< gridWidth {
                let cellView = cellViews[(i * gridWidth) + j]
                cellView.frame = cellFrame(coordinates: (x: i, y: j))
            }
        }
    }
    
    private var cellSize: CGSize {
        return CGSize(
            width: bounds.width / CGFloat(gridWidth),
            height: bounds.height / CGFloat(gridHeight)
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
