//
//  covidRequest.swift
//  COVID19
//
//  Created by 張軒瑋 on 2022/5/6.
//

import Foundation

struct covidRequest: Codable{
    
    let country:String //國家
    let dateString:String //日期
    let totalGet:String //總確診數
    let todayGet:String //今日確診
    let totalDeaths:String //總死亡數
    let todayDeaths:String //今日死亡
    let beHealth:String //解除隔離
    let totalPopulation:String //總人口
    let totalVaccine:String //疫苗接總數
    
    enum CodingKeys: String, CodingKey {
        case country = "a03"
        case dateString = "a04"
        case totalGet = "a05"
        case todayGet = "a06"
        case totalDeaths = "a08"
        case todayDeaths = "a09"
        case beHealth = "a31"
        case totalPopulation = "a27"
        case totalVaccine = "a21"
    }
}
