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

    var responseTextsObservable = PublishSubject<[String]>()
    var responseTextObservable = PublishSubject<String>()
    private var responseTexts: [String] = []
    private var responseText: String = ""

    private var communicationApi = CommunicationApi()
    private let disposeBag = DisposeBag()

    init(inputTextFieldObservable: Observable<String>,
         searchButtonObservable: Observable<Void>,
         tableViewIndexPathObservable: Observable<IndexPath>){

        inputTextFieldObservable.asObservable()
            //.debounce(.seconds(), scheduler: MainScheduler.instance)
            .subscribe(onNext: { text in
                self.responseText = text
                if !self.responseText.isEmpty {
                    self.communicationApi.getAPI(text: self.responseText, { array in
                        self.responseTexts = array
                        self.responseTextsObservable.onNext(self.responseTexts)
                    })
                }
            })
            .disposed(by: disposeBag)

        tableViewIndexPathObservable.asObservable()
            .subscribe(onNext: { indexPath in
                self.responseTextObservable.onNext(self.responseTexts[indexPath.row])
            })
            .disposed(by: disposeBag)

        searchButtonObservable.asObservable()
            .subscribe(onNext: {
                self.responseTextObservable.onNext(self.responseText)
            })
            .disposed(by: disposeBag)

        
    }

}
