//
//  AlibcViewController.swift
//  flutter_alibc
//
//  Created by 吴兴 on 2021/5/15.
//

import Foundation
class AlibcViewController: UIViewController {
    var vc :AlibcWkWebView?;
    convenience init(webviewVc:AlibcWkWebView){
        self.init();
        self.vc = webviewVc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
