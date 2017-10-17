//
//  ViewController.swift
//  SQAutoScrollView
//
//  Created by ysq on 2017/10/16.
//  Copyright © 2017年 ysq. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let barButton = UIBarButtonItem(title: "other style", style: .plain, target: self, action: #selector(push))
        navigationItem.rightBarButtonItem = barButton
        
        loadCycleView()
        
    }
    
    @objc func push() {
        navigationController?.pushViewController(OneViewController(), animated: true)
    }
    
    fileprivate func loadCycleView() {
        
        let urls = ["http://pic.qyer.com/public/mobileapp/homebanner/2017/10/09/15075430688640/w800",
                    "http://pic.qyer.com/ra/img/15064476767054",
                    "http://pic.qyer.com/public/mobileapp/homebanner/2017/10/09/15075432049166/w800",
                    "http://pic.qyer.com/public/mobileapp/homebanner/2017/10/10/15076301267252/w800"
        ]
        
        let cycleView = SQAutoScrollView(frame: CGRect.init(x: 0, y: 100, width: view.bounds.size.width, height: 300), urls: urls, didItemCallBack: { (view, index) in
            print("view--->\(view), index-->\(index)")
        })
        view.addSubview(cycleView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

