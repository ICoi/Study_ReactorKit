//
//  ReactorUnitTest.swift
//  Study_ReactorKitTests
//
//  Created by DaunJoung on 2021/08/07.
//

import XCTest

// Reactor 테스트 해야 할 항목
// * Action을 받았을 때 원하는 State로 잘 변경되는지

class ReactorUnitTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFollowing() {
        // 1. 리액터를 준비합니다.
        let reactor = UserViewReactor()
        
        // 2. 리액터에 액션을 전달합니다.
        reactor.action.onNext(.follow)
        
        // 3. 리액터의 상태가 변경되었는지를 검증합니다.
        XCTAssertEqual(reactor.currentState.isFollowing, true)
    }
    
    func testUnFollowing() {
        // 1. 리액터를 준비합니다. 액션을 미리 한 번 전달해서 테스트 환경을 만들어줍니다.
        let reactor = UserViewReactor()
        reactor.action.onNext(.follow)
        
        // 2. 리액터에 액션을 한 번 더 전달합니다.
        reactor.action.onNext(.unfollow)
        
        // 3. 리액터의 상태가 변경되는지를 검증합니다.
        XCTAssertEqual(reactor.currentState.isFollowing, false)
    }

}
