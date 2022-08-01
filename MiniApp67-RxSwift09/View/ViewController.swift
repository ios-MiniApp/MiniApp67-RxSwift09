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
    @IBOutlet private weak var searchButton: UIButton!
    @IBOutlet private weak var tableView: UITableView!

    private let disposeBag = DisposeBag()
    private var viewModel: ViewModel?
    private var dataSource = DataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupBinding()
    }

    private func setupTableView() {
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
    }

    private func setupBinding() {

        viewModel = ViewModel(
            inputTextFieldObservable: inputTextField.rx.text.orEmpty.asObservable(),
            searchButtonObservable: searchButton.rx.tap.asObservable(),
            tableViewIndexPathObservable: tableView.rx.itemSelected.asObservable()
        )

        viewModel?.responseTextsObservable
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        viewModel?.responseTextObservable
            .subscribe(onNext: {
                self.transitionScreen(text: $0)
            })
            .disposed(by: disposeBag)

    }

    private func transitionScreen(text: String) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewID") as! SecondViewController
        nextVC.searchedText = text
        self.navigationController?.pushViewController(nextVC, animated: true)
    }

}

