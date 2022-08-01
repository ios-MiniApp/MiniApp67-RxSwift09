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

    private var model = Model()
    private var secondViewModel: SecondViewModel?
    private let disposeBag = DisposeBag()

    init(text: Observable<String>,
         searchButton: Observable<Void>,
         tableViewIndexPath: Observable<IndexPath>){

        text.asObservable()
            //.debounce(.seconds(), scheduler: MainScheduler.instance)
            .subscribe(onNext: { text in
                self.responseText = text
                if !self.responseText.isEmpty {
                    self.model.getAPI(text: self.responseText, { array in
                        self.responseTexts = array
                        self.responseTextsObservable.onNext(self.responseTexts)
                    })
                }
            })
            .disposed(by: disposeBag)

        tableViewIndexPath.asObservable()
            .subscribe(onNext: { indexPath in
                self.responseTextObservable.onNext(self.responseTexts[indexPath.row])
            })
            .disposed(by: disposeBag)

        searchButton.asObservable()
            .subscribe(onNext: {
                self.responseTextObservable.onNext(self.responseText)
            })
            .disposed(by: disposeBag)

        
    }

}
