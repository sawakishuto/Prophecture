//
//  ShareOnXViewModel.swift
//  Yumemi_internTest
//
//  Created by 澤木柊斗 on 2024/01/02.
//

import Foundation
import UIKit

final class OpenURLViewModel: ObservableObject {
    func ShareOnX(name: String) {
        let text = "占いの結果、\(name)が相性がいいらしい！！今度行ってみようかな〜！"
        let hashTag = "#Prophecture\n#都道府県占い\n#占い"
        let completedText = text + "\n" + hashTag
        let encodedText = completedText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        if let encodedText = encodedText, let url = URL(string: "https://twitter.com/intent/tweet?text=\(encodedText)") { UIApplication.shared.open(url) }
    }
}
