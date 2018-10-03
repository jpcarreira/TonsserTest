//: Playground - noun: a place where people can play

import Foundation

struct Match {
    let slug: String
    let date: Date
    let homeTeamName: String
    let awayTeamName: String
}

extension Match: CustomStringConvertible {
    var description: String {
        return "\(homeTeamName) vs \(awayTeamName) at \(date)"
    }
}

// Utility functions

func createDate(from dateString: String) -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
    return dateFormatter.date(from: dateString)
}

// Return the closest match index to [dateTapped], return 0 otherwise, [matchList] is s​orted​ by date.
func findClosestMatch(dateTapped: Date, matchList: [Match]) -> Int {
    let datesOnly = matchList.map { abs($0.date.timeIntervalSince(dateTapped)) }
    if let closestDate = datesOnly.sorted().first(where: { $0 > 0 }) {
        return datesOnly.index(of: closestDate) ?? 0
    }
    
    return 0
}

let now = Date()
let date = createDate(from: "2018-10-27 19:00")
let date2 = createDate(from: "2018-11-03 19:00")

let matchList = [
    Match(slug: "game 1", date: createDate(from: "2018-10-02 20:00")!, homeTeamName: "AEK Athen", awayTeamName: "Benfica"),
    Match(slug: "game 2", date: createDate(from: "2018-10-07 17:30")!, homeTeamName: "Benfica", awayTeamName: "Porto"),
    Match(slug: "game 3", date: createDate(from: "2018-10-23 20:00")!, homeTeamName: "Ajax", awayTeamName: "Benfica"),
    Match(slug: "game 4", date: createDate(from: "2018-10-27 20:30")!, homeTeamName: "Belenenses", awayTeamName: "Benfica"),
    Match(slug: "game 5", date: createDate(from: "2018-11-02 20:30")!, homeTeamName: "Benfica", awayTeamName: "Moreirense"),
    Match(slug: "game 6", date: createDate(from: "2018-11-07 20:00")!, homeTeamName: "Benfica", awayTeamName: "Ajax")
    ]


print("Index of closest match to \(now): \(findClosestMatch(dateTapped: now, matchList: matchList)) \(matchList[findClosestMatch(dateTapped: now, matchList: matchList)])")
print("Index of closest match to \(date!): \(findClosestMatch(dateTapped: date!, matchList: matchList)) \(matchList[findClosestMatch(dateTapped: date!, matchList: matchList)])")
print("Index of closest match to \(date2!): \(findClosestMatch(dateTapped: date2!, matchList: matchList)) \(matchList[findClosestMatch(dateTapped: date2!, matchList: matchList)])")
