//
//  DataManager.swift
//  Tracker
//
//  Created by Kirill Gontsov on 18.11.2023.
//

import UIKit

final class DataManager {
    static let shared = DataManager()
    
    var categories: [TrackerCategory] = [
        TrackerCategory(
            name: "Тренировка",
            trackers: [
                Tracker(
                    name: "Интервалы манеж",
                    color: UIColor.green,
                    emoji: "🏃‍♂️",
                    schedule: [WeekDay.tuesday, WeekDay.thursday]
                ),
                Tracker(
                    name: "Силовая",
                    color: UIColor.blue,
                    emoji: "🏋️‍♂️",
                    schedule:[WeekDay.tuesday, WeekDay.friday]
                ),
            ]
        ),
        TrackerCategory(
            name: "Сделать спринт",
            trackers: [
                Tracker(
                    name: "Спринт",
                    color: UIColor.green,
                    emoji: "😢",
                    schedule: [WeekDay.monday, WeekDay.sunday]
                ),
                Tracker(
                    name: "Опять спринт",
                    color: UIColor.blue,
                    emoji: "😭",
                    schedule: [WeekDay.wednesday, WeekDay.saturday]
                ),
            ]
        ),
    ]
}
