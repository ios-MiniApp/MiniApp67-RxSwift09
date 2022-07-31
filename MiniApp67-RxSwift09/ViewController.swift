//
//  ViewController.swift
//  MiniApp67-RxSwift09
//
//  Created by 前田航汰 on 2022/07/30.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet private weak var inputTextField: UITextField!
    @IBOutlet private weak var textView: UITextView!
    private let disposeBag = DisposeBag()

    var viewModel: ViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = ViewModel(text: inputTextField.rx.text.orEmpty.asObservable())

        viewModel?.responseTexts
            .map { text in
                return text
                    .map { "・\($0)" }
                    .joined(separator: "\n")
            }
            .bind(to: textView.rx.text)
            .disposed(by: disposeBag)
    }

}

