//
//  GameInformationResponse+Extension.swift
//  Assignment
//
//  Created by Atlas on 2022/08/23.
//

import Foundation
import Alamofire

extension GameInformationResponse {
    //MARK: - GAME
    private func getRecent20GamesKills() -> Int {
        if games.isEmpty { return 0}
        var sum = 0
        for item in 0..<(summary.wins + summary.losses) {
            sum += games[item].stats.general.kill
        }
        return sum
    }
    
    func getAverageRecent20GamesKills() -> Double{
        return Double(self.getRecent20GamesKills()/(summary.wins + summary.losses))
    }
    
    private func getRecent20GamesDeaths() -> Int {
        if games.isEmpty { return 0}
        var sum = 0
        for item in 0..<(summary.wins + summary.losses) {
            sum += games[item].stats.general.death
        }
        return sum
    }
    
    func getAverageRecent20GamesDeaths() -> Double {
        return Double(self.getRecent20GamesDeaths()/(summary.wins + summary.losses))
    }
    
    private func getRecent20GamesAssists() -> Int {
        if games.isEmpty { return 0}
        var sum = 0
        for item in 0..<(summary.wins + summary.losses) {
            sum += games[item].stats.general.assist
        }
        return sum
    }
    
    func getAverageRecent20GamesAssists() -> Double {
        return Double(self.getRecent20GamesAssists()/(summary.wins + summary.losses))
    }
    
    
    func getKDA() -> String {
        if getRecent20GamesDeaths() > 0 {
            return String(format: "%.2f", (Double(getRecent20GamesKills() + getRecent20GamesAssists())) / Double(getRecent20GamesDeaths()))
        }else {
            return "-"
        }
    }
}


extension GameInformationResponse {
    //MARK: - Champions
    
    func sortByHighWinRate() -> [ChampionElement] {
        var tmp = [Int:ChampionElement]()
//        let tmpChamps = champions
        champions.forEach { Champ in
            tmp[getWinRate(wins: Champ.wins, losses: Champ.losses)] = Champ
        }
        let sorted = tmp.sorted{ $0.0 > $1.0 }
        let sortedChamps = sorted.map { $0.1 }
        if sortedChamps.count > 2 {
            return [sortedChamps[0], sortedChamps[1]]
        }else{
            return sortedChamps
        }
    }

    func getWinRate(wins: Int, losses: Int) -> Int {
        if wins != 0 && losses != 0 {
            return Int(((Double(wins) / Double(wins + losses)) * 100).rounded())
        }else{
            return 0
        }
    }
}

extension GameInformationResponse {
    
    func sortByHighWinRatePostion() -> Position? {
        var tmp = [Int: Position]()
        positions.forEach { position in
            tmp[getWinRate(wins: position.wins, losses: position.losses)] = position
        }
        
        let sorted = tmp.sorted{ $0.0 > $1.0 }
        let sortedChamps = sorted.compactMap { $0.1 }
        return sortedChamps.first ?? nil
        
    }
}
