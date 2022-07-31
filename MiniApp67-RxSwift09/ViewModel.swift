//
//  ViewModel.swift
//  MiniApp67-RxSwift09
//
//  Created by 前田航汰 on 2022/07/30.
//

import Foundation
import RxCocoa
import RxSwift

class ViewModel {

    var responseTexts = PublishSubject<[String]>()
    var model = Model()
    let disposeBag = DisposeBag()

    init(text: Observable<String>){

        text.asObservable()
            //.debounce(.seconds(), scheduler: MainScheduler.instance)
            .subscribe(onNext: { text in
                if !text.isEmpty {
                    self.model.getAPI(text: text, { array in
                        self.responseTexts.onNext(array)
                    })
                }
            })
            .disposed(by: disposeBag)
    }

}
