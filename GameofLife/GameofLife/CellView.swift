//
//  CellView.swift
//  GameofLife
//
//  Created by Chauhan, Yogesh on 5/14/17.
//  Copyright © 2017 Darshit, Vikas. All rights reserved.
//

import Foundation
import UIKit


/// Holds the data of the tile coordinates
public typealias CellCoordinates = (x: Int, y: Int)

public class CellView: UIView {
    
    public var coordinates: CellCoordinates!
    
    public dynamic var alive = false
    public var shouldToggleState = false
    
    override open var canBecomeFirstResponder : Bool {
        return true
    }
    
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        setAlive(value: !isAlive())
    }
    
    public func isAlive() -> Bool{
        return alive;
    }
    
    public func setAlive(value: Bool){
        alive = value;
        if(alive){
            layer.backgroundColor = UIColor.red.cgColor;
        }else{
            layer.backgroundColor = UIColor.white.cgColor;
        }
    }
    
    override public init(frame: CGRect) {        super.init(frame: frame)
        
        // Init design
        layer.borderWidth = 1.0
        layer.borderColor = UIColor(white: 0.0, alpha: 0.03).cgColor
        layer.backgroundColor = UIColor.white.cgColor
    }
    
    required public init(coder: NSCoder) {
        super.init(coder: coder)!
    }
    
}
