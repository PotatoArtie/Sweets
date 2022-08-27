//
//  GameInformationResponse.swift
//  Assignment
//
//  Created by Atlas on 2022/08/22.
//

import Foundation

// MARK: - GameInformationResponse
struct GameInformationResponse: Codable {
    let games: [Game]
    let champions: [ChampionElement]
    let positions: [Position]
    let summary: Summary
    
}

// MARK: - ChampionElement
struct ChampionElement: Codable {
    let id: Int
    let key, name: String
    let imageURL: String
    let games, kills, deaths, assists: Int
    let wins, losses: Int

    enum CodingKeys: String, CodingKey {
        case id, key, name
        case imageURL = "imageUrl"
        case games, kills, deaths, assists, wins, losses
    }
}

// MARK: - Game
struct Game: Codable {
    let mmr: Int?
    let champion: GameChampion
    let spells, items: [Item]
    let needRenew: Bool
    let gameID: String
    let createDate, gameLength: Int
    let gameType: String
    let summonerID: String
    let summonerName: String
    let tierRankShort: String
    let stats: Stats
//    let mapInfo: JSONNull?
    let peak: [String]
    let isWin: Bool

    enum CodingKeys: String, CodingKey {
        case mmr, champion, spells, items, needRenew
        case gameID = "gameId"
        case createDate, gameLength, gameType
        case summonerID = "summonerId"
        case summonerName, tierRankShort, stats, peak, isWin
    }
}

// MARK: - GameChampion
struct GameChampion: Codable {
    let imageURL: String
    let level: Int

    enum CodingKeys: String, CodingKey {
        case imageURL = "imageUrl"
        case level
    }
}

// MARK: - Item
struct Item: Codable {
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case imageURL = "imageUrl"
    }
}

// MARK: - Stats
struct Stats: Codable {
    let general: General
    let ward: Ward
}

// MARK: - General
struct General: Codable {
    let kill, death, assist: Int
    let kdaString: String
    let cs: Int
    let csPerMin: Double
    let contributionForKillRate: String
    let goldEarned, totalDamageDealtToChampions: Int
    let largestMultiKillString: String
    let opScoreBadge: String
}

// MARK: - Ward
struct Ward: Codable {
    let sightWardsBought, visionWardsBought: Int
}

// MARK: - Position
struct Position: Codable {
    let games, wins, losses: Int
    let position, positionName: String
}

// MARK: - Summary
struct Summary: Codable {
    let wins, losses, kills, deaths: Int
    let assists: Int

    func getRecentAnalyzedGameCount() -> Int {
        return wins + losses
    }
    
    //MARK: - need to check data
    func getAverageRecentGamesKills() -> Double {
        return Double(kills/(wins + losses))
    }
    
    func getAverageRecentGamesDeaths() -> Double {
        return Double(deaths/(wins + losses))
    }
    
    func getAverageRecentGamesAssits() -> Double {
        return Double(assists/(wins + losses))
    }
}
