//
//  OneViewController.swift
//  SQAutoScrollView
//
//  Created by ysq on 2017/10/17.
//  Copyright © 2017年 ysq. All rights reserved.
//

import UIKit

class OneViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        loadCycleView()
    }
    
    fileprivate func loadCycleView() {
        
        let urls = ["http://pic.qyer.com/public/mobileapp/homebanner/2017/10/09/15075430688640/w800",
                    "http://pic.qyer.com/ra/img/15064476767054",
                    "http://pic.qyer.com/public/mobileapp/homebanner/2017/10/09/15075432049166/w800",
                    "http://pic.qyer.com/public/mobileapp/homebanner/2017/10/10/15076301267252/w800"
        ]
        
        let cycleView = SQAutoScrollView(frame: CGRect.init(x: 0, y: 100, width: view.frame.size.width, height: 300))
        cycleView.clickCompletionHandler = {
            (view: SQAutoScrollView, index: Int) in
            print("view--->\(view), index-->\(index)")
        }
        cycleView.imageUrls = urls
        cycleView.interval = 1
        cycleView.pageControl?.alignment = .right
        cycleView.pageControl?.style = .rectangle
        cycleView.pageControl?.currentPageIndicatorTintColor = UIColor.blue
        cycleView.pageControl?.pageIndicatorTintColor = UIColor.red
        view.addSubview(cycleView)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
