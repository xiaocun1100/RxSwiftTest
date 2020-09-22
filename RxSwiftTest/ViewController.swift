//
//  ViewController.swift
//  RxSwiftTest
//
//  Created by 蒋小寸 on 2020/5/25.
//  Copyright © 2020 蒋小寸. All rights reserved.
//

import UIKit
//import SnapKit
import RxSwift
import RxCocoa
import SnapKit
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        // Do any additional setup after loading the view.
        let textfield = UITextField(frame: CGRect.init(x: 0, y: 100, width: 200, height: 40))
        textfield.borderStyle = .line
        textfield.placeholder = "请输入名称"
        self.view.addSubview(textfield)
        textfield.snp.makeConstraints { (maker) in
            maker.top.equalTo(100)
            maker.centerX.equalToSuperview()
            maker.left.equalTo(20)
            maker.right.equalTo(-20)
        }
        let textfieldNotEmpty = textfield.rx.text.orEmpty.map { !$0.isEmpty
        }
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 140, width: 200, height: 40)
        button.backgroundColor = .gray
        self.view.addSubview(button)
        button.snp.makeConstraints { (maker) in
            maker.top.equalTo(textfield.snp.bottom).offset(20)
            maker.centerX.equalToSuperview()
            maker.left.equalTo(20)
            maker.right.equalTo(-20)
        }
        _ = button.rx.tap.subscribe { (event :Event<Void>) in
            print(textfield.text ?? "")
        }//.disposed(by: DisposeBag()) //.dispose() 取消绑定
        //可监听序列 文本框是否为空
        //观察者 按钮是否可用和按钮背景色切换
        _ = textfieldNotEmpty.bind(to: button.rx.isEnabled)
        _ = textfield.rx.text.asObservable().subscribe { event in
            let text = event.element
            if (((text ?? "")?.count ?? 0) > 0) {
                button.backgroundColor = .green
            } else {
                button.backgroundColor = .gray
            }
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
