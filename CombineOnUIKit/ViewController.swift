//
//  ViewController.swift
//  CombineOnUIKit
//
//  Created by Rajesh Kumar Sahil on 13/08/2022.
//

import UIKit

class ViewController: UIViewController {
    
    let viewModel = LoginViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        viewModel.fetchingComments_WithCombine()
        viewModel.fetchingComments_WithAwaitAsync()
    }
}

