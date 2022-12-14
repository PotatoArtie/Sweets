//
//  SummomerResponse.swift
//  Assignment
//
//  Created by Dongju on 2022/08/19.
//

import Foundation

// MARK: - Welcome
struct SummomerResponse: Codable {
    let summoner: Summoner
}

// MARK: - Summoner
struct Summoner: Codable {
    let name: String
    let level: Int
    let profileImageURL: String
    let profileBorderImageURL: String
    let url: String
    let leagues: [League]
    let previousTiers: [PreviousTier]
    let ladderRank: LadderRank
    let profileBackgroundImageURL: String

    enum CodingKeys: String, CodingKey {
        case name, level
        case profileImageURL = "profileImageUrl"
        case profileBorderImageURL = "profileBorderImageUrl"
        case url, leagues, previousTiers, ladderRank
        case profileBackgroundImageURL = "profileBackgroundImageUrl"
    }
}

// MARK: - LadderRank
struct LadderRank: Codable {
    let rank, rankPercentOfTop: Int
}

// MARK: - League
struct League: Codable {
    let hasResults: Bool
    let wins, losses: Int
    let tierRank: PreviousTier
}

// MARK: - PreviousTier
struct PreviousTier: Codable {
    let name, tier, tierDivision, string: String
    let shortString, division: String
    let imageURL: String
    let lp, tierRankPoint: Int
    let season: Int?

    enum CodingKeys: String, CodingKey {
        case name, tier, tierDivision, string, shortString, division
        case imageURL = "imageUrl"
        case lp, tierRankPoint, season
    }
}
