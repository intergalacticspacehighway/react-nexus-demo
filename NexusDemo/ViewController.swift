//
//  ViewController.swift
//  NexusDemo
//
//  Created by Nishan Bende on 05/07/23.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    let runtimeWrapper = InitialiseJSRuntime();
    runtimeWrapper.initialiseJSRuntime(self);
    
  }

}

