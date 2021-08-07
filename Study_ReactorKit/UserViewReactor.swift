//
//  UserViewReactor.swift
//  Study_ReactorKit
//
//  Created by DaunJoung on 2021/08/07.
//

import UIKit
import ReactorKit

// 리액터는 뷰의 상태를 관리합니다.
// 뷰에서 액션을 전달받으면 비즈니스 로직을 수행한 뒤 상태를 변경하여 다시 뷰에 전달합니다.
// 리액터는 UI레이어에서 독립적이기 때문에 비교적 테스트하기 쉽습니다.
// Reactor 프로토콜은 Action, Mutation, State, initialState 필수.
class UserViewReactor: Reactor {
    
    // 사용자 인터랙션을 표현하는 Action
    enum Action {
        case follow
        case unfollow
    }
    
    // 상태를 변경하는 가장 작은 단위인 Mutation
    enum Mutation {
        case setFollowing(Bool)
    }
    
    // 뷰의 상태를 표혀하는 State
    struct State {
        var isFollowing: Bool
    }
    
    // 최초 상태를 나타냄
    let initialState: State = State(isFollowing: false)
    
    // mutate 함수에서는 Action 스트림을 Mutation 스트림으로 변환
    // 이곳에서 네트워킹이나 비동기 로직 등의 사이드 이펙트를 처리함
    // 여기서 방출한 Mutation 값은 reduce함수로 전달됨
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .follow:
            return Observable.just(Mutation.setFollowing(true))
        case .unfollow:
            return Observable.just(Mutation.setFollowing(false))
        }
    }
    
    // reduce 함수는 이전 상태와 Mutation을 받아서 다음 상태를 반환
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state

        switch mutation {
        case .setFollowing(let isFollowing):
            newState.isFollowing = isFollowing
        }
        return newState
    }
    
}
