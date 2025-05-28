//
//  TodoModel.swift
//  TodoList
//
//  Created by Кирилл Антоненко on 28.05.2025.
//

import Foundation


struct TodoModel {
    var id: UUID = UUID() // Id задачи
    var title: String // Цель задачи
    var description: String? = nil // Описание задачи
    var isCompleted: Bool = false // Выполнена задача или нет
}
