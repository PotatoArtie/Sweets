//
//  ScoreViewModel.swift
//  Assignment
//
//  Created by Atlas on 2022/08/21.
//

import Foundation
import RxSwift
import RxRelay

class ScoreViewModel {
    
    struct Action {
        var summoner = PublishRelay<String>()
        var gameInformation = PublishRelay<GameInformationRequest>()
    }
    
    struct State {
        var isLoading = PublishRelay<Bool>()
        var gameInformation = PublishRelay<Void>()
    }
    
    let action = Action()
    let state = State()
    let disposeBag = DisposeBag()
    var summoner: Summoner?
    var gameInformation: GameInformationResponse?
    var games: [Game] = []
    var isLoading = false
    init(){
        binding()
    }
    
    private func binding(){
        self.action.summoner
            .flatMap({ name in
                return APIService.shared.request(.summoner(name: name), expectingReturnType: SummomerResponse.self)
            })
            .subscribe(onNext: { [weak self] result in
                guard let self = self else { return }
                self.state.isLoading.accept(false)
                switch result {
                case .success(let response):
                    self.summoner = response.summoner
                    let request = GameInformationRequest(name: response.summoner.name, lastMatch: Int64(Date().timeIntervalSince1970))
                    self.games.removeAll()
                    self.action.gameInformation.accept(request)
                default:
                    break
                }
                
            }).disposed(by: self.disposeBag)
        
        self.action.gameInformation
            .flatMap { request in
                APIService.shared.request(.gameInfomation(name: request.name
                                                          , lastMatch: request.lastMatch), expectingReturnType: GameInformationResponse.self)
            }
            .subscribe(onNext: { [weak self] result in
                guard let self = self else { return }
                self.isLoading = false
                self.state.isLoading.accept(false)
                switch result {
                case .success(let response):
                    if self.games.isEmpty {
                        self.gameInformation = response
                    }
                    self.games += response.games
                    self.state.gameInformation.accept(())
                default:
                    break
                }
                
            }).disposed(by: self.disposeBag)
    }
}
