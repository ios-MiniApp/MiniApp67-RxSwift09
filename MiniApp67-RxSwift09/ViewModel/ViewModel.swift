//
//  ViewModel.swift
//  MiniApp67-RxSwift09
//
//  Created by 前田航汰 on 2022/07/30.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit

class ViewModel {

    var searchTextArrayObservable = PublishSubject<[String]>()
    var searchTextObservable = PublishSubject<String>()
    private var searchTextArray: [String] = []
    private var searchText: String = ""

    private var communicationApi = CommunicationApi()
    private let disposeBag = DisposeBag()

    init(inputTextFieldObservable: Observable<String>,
         searchButtonObservable: Observable<Void>,
         tableViewIndexPathObservable: Observable<IndexPath>){

        inputTextFieldObservable.asObservable()
        //.debounce(.seconds(), scheduler: MainScheduler.instance)
            .subscribe(onNext: { text in
                self.searchText = text

                if !self.searchText.isEmpty {
                    self.communicationApi.getAPI(text: self.searchText, { array in
                        self.searchTextArray = array
                        self.searchTextArrayObservable.onNext(self.searchTextArray)
                    })
                }
            })
            .disposed(by: disposeBag)

        tableViewIndexPathObservable.asObservable()
            .subscribe(onNext: { indexPath in
                self.searchTextObservable.onNext(self.searchTextArray[indexPath.row])
            })
            .disposed(by: disposeBag)

        searchButtonObservable.asObservable()
            .subscribe(onNext: {
                self.searchTextObservable.onNext(self.searchText)
            })
            .disposed(by: disposeBag)
    }

}
