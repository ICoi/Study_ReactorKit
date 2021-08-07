//
//  ViewUnitTest.swift
//  Study_ReactorKitTests
//
//  Created by DaunJoung on 2021/08/07.
//

import XCTest

// View 테스트 해야할 항목
// * 사용자 인터랙선이 발생했을 때 Action이 리액터로 잘 전달되는지
// * 리액터의 상태가 바뀌었을 때 뷰의 컴포넌트 속성이 잘 변경되는지

// 리액터의 stub기능을 이용하면 뷰를 쉽게 테스트 할 수 있음
// stub기능을 활성화 하면 리액터가 받은 Action을 모두 기록하고, mutate()와 reduce()를 실행하는 대신 외부에서 상태를 설정 할 수 있게 됨

class ViewUnitTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    func testAction_follow() {
        // 사용자 인터랙션이 발생했을 때 Action이 리액터로 잘 전달되는지 테스트
        
        // 1. Stub 리액터를 준비합니다.
        let reactor = UserViewReactor()
        reactor.stub.isEnabled = true
        
        // 2. Stub된 리액터를 주입한 뷰를 준비합니다.
        let view = UserViewController()
        view.followButton = UIButton()
        view.unFollowButton = UIButton()
        view.resultLabel = UILabel()
        view.reactor = reactor
        
        // 3. 사용자 인터랙션을 발생시킵니다.
        view.followButton?.sendActions(for: .touchUpInside)
        
        // 4. Reactor에 액션이 잘 전달되었는지를 검증합니다.
        XCTAssertEqual(reactor.stub.actions.last, .follow)
    }

    
    func testAction_isFollowing() {
        // 리액터의 상태가 바뀌었을 때 뷰의 컴포넌트 속성이 잘 변경되는지 테스트
        
        // 1. Stub 리액터를 준비합니다.
        let reactor = UserViewReactor()
        reactor.stub.isEnabled = true
        
        // 2. Stub된 리액터를 주입한 뷰를 준비합니다.
        let view = UserViewController()
        view.followButton = UIButton()
        view.unFollowButton = UIButton()
        view.resultLabel = UILabel()
        view.reactor = reactor
        
        // 3. 리액터의 상태를 임의로 설정합니다.
        reactor.stub.state.value = UserViewReactor.State(isFollowing: false)
        
        // 4. 그 때 뷰 컴포넌트의 속성이 잘 변하는지를 검증합니다.
        XCTAssertEqual(view.resultLabel?.text, "isFollow ? false")
    }
}
