//
//  Model.swift
//  MiniApp67-RxSwift09
//
//  Created by 前田航汰 on 2022/07/30.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa

struct Articles: Codable {
    let AS: AS
}

struct AS: Codable{

    let Results: [Result]?

    struct Result: Codable {
        let Suggests: [Suggest]?
    }

    struct Suggest: Codable {
        let Txt: String
    }

}

class Model {

    func getAPI(text: String, _ after:@escaping ([String]) -> ()){

        let searchEncodeString = text.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)
        let urlString = "http://api.bing.com/qsonhs.aspx?mkt=ja-JP&q=\(searchEncodeString!)"
        var array: [String] = []

        guard let url = URL(string: urlString) else {
            return
        }

        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).response {
            response in

            array = []

            switch response.result{
            case .success:
                do{

                    let articles = try JSONDecoder().decode(Articles.self, from: response.data!).AS.Results?[0].Suggests

                    if let articles = articles {
                        for aaa in articles {
                            array.append(contentsOf: [aaa.Txt])
                        }
                    }
                    after(array)

                }
                catch{
                    print("取得失敗")
                }

            case .failure(_):
                print("失敗")
            }
        }

    }


}
