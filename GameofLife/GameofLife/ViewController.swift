//
//  ViewController.swift
//  GameofLife
//
//  Created by Chauhan, Yogesh on 5/14/17.
//  Copyright © 2017 Darshit, Vikas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var parentView: UIView!
    
    var gridView : GridView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gridView = GridView(gridWidth: 15, gridHeight: 15, width: Int(parentView.bounds.width), height: Int(parentView.bounds.height))
        view.addSubview(gridView!)
    }
    
    @IBAction
    private func _step() {
        gridView?.step()
    }
    
    @IBAction
    private func _clear() {
        gridView?.clear()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

