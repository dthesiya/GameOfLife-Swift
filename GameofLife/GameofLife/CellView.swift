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
    
    var circle = UIView()
    
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
            self.addSubview(circle)
//            layer.backgroundColor = UIColor.red.cgColor;
        }else{
            circle.removeFromSuperview()
            layer.backgroundColor = UIColor.white.cgColor;
        }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.borderWidth = 1.0
        layer.borderColor = UIColor(white: 0.0, alpha: 0.03).cgColor
        layer.backgroundColor = UIColor.white.cgColor
        
        circle = UIView(frame: CGRect(x: 3, y: 3, width: frame.width - 6, height: frame.height - 6))
        
        circle.layer.cornerRadius = 10
        circle.backgroundColor = UIColor.red
        circle.clipsToBounds = true
    }
    
    required public init(coder: NSCoder) {
        super.init(coder: coder)!
    }
    
}
