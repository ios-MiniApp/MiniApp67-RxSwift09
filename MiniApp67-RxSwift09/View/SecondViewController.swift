//
//  SecondViewController.swift
//  MiniApp67-RxSwift09
//
//  Created by 前田航汰 on 2022/08/01.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var searchedLabel: UILabel!
    var searchedText = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        searchedLabel.text = searchedText
    }

}
