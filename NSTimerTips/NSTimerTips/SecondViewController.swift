//
//  SecondViewController.swift
//  NSTimerTips
//
//  Created by luckytantanfu on 4/13/16.
//  Copyright © 2016 futantan. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
  
  weak var timer: NSTimer?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  deinit {
    print("in deinit")
    timer?.invalidate()
  }
  
  @IBAction func onFireButtonClicked(sender: AnyObject) {
//    timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: #selector(sayHello), userInfo: nil, repeats: true)
    
//    timer = NSTimer.scheduledTimerWithTimeInterval(2, repeats: true, block: { 
//      print("hey, our block")
//    })
    
    timer = NSTimer.scheduledTimerWithTimeInterval(2, repeats: true, block: { [weak self] in
      self?.test()
    })
  }
  
  func test() {
    print("in test")
  }
  
  func sayHello(timer: NSTimer) {
    print("hello")
    print(timer)
  }
  
  @IBAction func onInvalidateButtonClicked(sender: AnyObject) {
    timer?.invalidate()
  }
  
}
