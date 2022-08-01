//
//  DataSource.swift
//  MiniApp67-RxSwift09
//
//  Created by 前田航汰 on 2022/08/01.
//

import RxSwift
import RxCocoa
import UIKit

class DataSource: NSObject, UITableViewDataSource, RxTableViewDataSourceType {

    typealias Element = [String]
    var candidates: [String] = []

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        candidates.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
        let element = candidates[indexPath.row]
        cell.textLabel?.text = element
        return cell
    }

    func tableView(_ tableView: UITableView, observedEvent: Event<[String]>) {
        Binder(self) { dataSource, element in
            dataSource.candidates = element
            tableView.reloadData()
        }
        .on(observedEvent)
    }


}
