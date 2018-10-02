//: Playground - noun: a place where people can play

import Foundation

struct Match {
    let slug: String
    let date: Date
    let homeTeamName: String
    let awayTeamName: String
}

// Utility functions

func createDate(from dateString: String) -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
    return dateFormatter.date(from: dateString)
}

// Return the closest match index to [dateTapped], return 0 otherwise, [matchList] is s​orted​ by date.
func findClosestMatch(dateTapped: Date, matchList: [Match]) -> Int {
    // TODO: implement...
    return 0
}

let date = Date()
let matchList = [
    Match(slug: "game 1", date: createDate(from: "2018-10-02 20:00")!, homeTeamName: "AEK Athen", awayTeamName: "Benfica"),
    Match(slug: "game 2", date: createDate(from: "2018-10-07 17:30")!, homeTeamName: "Benfica", awayTeamName: "Porto"),
    Match(slug: "game 3", date: createDate(from: "2018-10-23 20:00")!, homeTeamName: "Ajax", awayTeamName: "Benfica"),
    Match(slug: "game 4", date: createDate(from: "2018-10-27 20:30")!, homeTeamName: "Belenenses", awayTeamName: "Benfica"),
    Match(slug: "game 5", date: createDate(from: "2018-11-02 20:30")!, homeTeamName: "Benfica", awayTeamName: "Moreirense"),
    Match(slug: "game 6", date: createDate(from: "2018-11-07 20:00")!, homeTeamName: "Benfica", awayTeamName: "Ajax")
    ]

print("Index of closest match: \(findClosestMatch(dateTapped: date, matchList: matchList))")
