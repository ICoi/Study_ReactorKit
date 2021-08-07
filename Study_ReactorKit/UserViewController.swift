//
//  ViewController.swift
//  Study_ReactorKit
//
//  Created by DaunJoung on 2021/08/07.
//

import UIKit
import ReactorKit
import RxSwift
import RxCocoa

// ReactorKit의 View를 상속받는다.
// 뷰는 상태를 표현합니다. 뷰 컨트롤러나 셀도 모두 뷰에 해당합니다.
// 뷰는 사용자 인터랙션을 추상화하여 리액터에 전달하고, 리액터에서 전달받은 상태를 각각의 뷰 컴포넌트에 바인드합니다.
// 뷰는 비즈니스 로직을 수행하지 않습니다.
class UserViewController: UIViewController, View {
//    @IBOutlet weak var followButton: UIButton!
//    @IBOutlet weak var resultLabel: UILabel!
    
    var followButton: UIButton?
    var unFollowButton : UIButton?
    var resultLabel : UILabel?
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        followButton = UIButton(frame: CGRect(x: 100, y: 30, width: 150, height: 50))
        followButton?.setTitle("Follow Button", for: .normal)
        self.view.addSubview(followButton!)
        
        unFollowButton = UIButton(frame: CGRect(x: 100, y: 130, width: 150, height: 50))
        unFollowButton?.setTitle("UnFollow button", for: .normal)
        self.view.addSubview(unFollowButton!)
        
        resultLabel = UILabel(frame: CGRect(x: 100, y: 200, width: 150, height: 50))
        self.view.addSubview(resultLabel!)
        
    }
    
    func bind(reactor: UserViewReactor) {
        // Action
        self.followButton?.rx.tap
            .map { Reactor.Action.follow }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        // Action 2
        self.unFollowButton?.rx.tap
            .map { Reactor.Action.unfollow }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        // State
        reactor.state.map { $0.isFollowing }
            .distinctUntilChanged()
            .map {"isFollow ? \($0)" }
            .bind(to: self.resultLabel!.rx.text)
//            .map(print(""))
//            .bind(to: self.followButton.rx.isSelected)
            .disposed(by: self.disposeBag)
        
    }


}

