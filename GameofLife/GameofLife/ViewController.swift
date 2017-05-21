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
    
    let refreshAlert = UIAlertController(title: "Clear", message: "All live fields will be lost.", preferredStyle: UIAlertControllerStyle.alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let screenSize: CGRect = UIScreen.main.bounds
        let frame  = parentView.frame
        parentView.frame = CGRect(x: frame.minX, y: frame.minY, width: screenSize.width, height: screenSize.width)
        gridView = GridView(gridWidth: 15, gridHeight: 15, width: Int(parentView.bounds.width), height: Int(parentView.bounds.width), minY: Float(parentView.frame.minY))
        view.addSubview(gridView!)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            self.gridView?.clear()
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Cancelled")
        }))
    }
    
    @IBAction
    private func next() {
        gridView?.next()
    }
    
    @IBAction
    private func clear() {
        present(refreshAlert, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

