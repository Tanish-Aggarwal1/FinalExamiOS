//
//  DatabaseManager.swift
//  AggataniFinalExam
//
//  Created by Tanish Aggarwal on 2026-08-04.
//

import Foundation
import SQLite3

final class DatabaseManager {

    static let shared = DatabaseManager()

    private var db: OpaquePointer?

    private init() {
        openDatabase()
        createTable()
    }

    private func openDatabase() {
        let fileURL = FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("SavedLocations.sqlite")

        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("Unable to open database at \(fileURL.path)")
        }
    }

    private func createTable() {
        let sql = """
        CREATE TABLE IF NOT EXISTS SavedLocation (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            latitude REAL NOT NULL,
            longitude REAL NOT NULL
        );
        """

        var statement: OpaquePointer?
        if sqlite3_prepare_v2(db, sql, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) != SQLITE_DONE {
                print("Could not create SavedLocation table")
            }
        }
        sqlite3_finalize(statement)
    }

    @discardableResult
    func insert(name: String, latitude: Double, longitude: Double) -> Int64? {
        let sql = "INSERT INTO SavedLocation (name, latitude, longitude) VALUES (?, ?, ?);"

        var statement: OpaquePointer?
        guard sqlite3_prepare_v2(db, sql, -1, &statement, nil) == SQLITE_OK else {
            sqlite3_finalize(statement)
            return nil
        }

        sqlite3_bind_text(statement, 1, (name as NSString).utf8String, -1, nil)
        sqlite3_bind_double(statement, 2, latitude)
        sqlite3_bind_double(statement, 3, longitude)

        guard sqlite3_step(statement) == SQLITE_DONE else {
            sqlite3_finalize(statement)
            return nil
        }

        sqlite3_finalize(statement)
        return sqlite3_last_insert_rowid(db)
    }

    func fetchAll() -> [SavedLocation] {
        let sql = "SELECT id, name, latitude, longitude FROM SavedLocation ORDER BY id DESC;"

        var statement: OpaquePointer?
        var results: [SavedLocation] = []

        guard sqlite3_prepare_v2(db, sql, -1, &statement, nil) == SQLITE_OK else {
            sqlite3_finalize(statement)
            return results
        }

        while sqlite3_step(statement) == SQLITE_ROW {
            let id = sqlite3_column_int64(statement, 0)
            let name = String(cString: sqlite3_column_text(statement, 1))
            let latitude = sqlite3_column_double(statement, 2)
            let longitude = sqlite3_column_double(statement, 3)
            results.append(SavedLocation(id: id, name: name, latitude: latitude, longitude: longitude))
        }

        sqlite3_finalize(statement)
        return results
    }
}
