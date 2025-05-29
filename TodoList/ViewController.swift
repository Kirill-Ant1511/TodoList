//
//  ViewController.swift
//  TodoList
//
//  Created by Кирилл Антоненко on 28.05.2025.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var todos: [TodoModel] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableViewConstraints()
        configTableView()
        view.addSubview(button)
        addButtonConstraints()
        
    }
    
    var button: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.frame = CGRect(x: 100, y: 0, width: 70, height: 40)
        button.layer.cornerRadius = 15
        button.setTitle("Add", for: .normal)
        button.setTitleColor(.gray, for: .highlighted)
        button.backgroundColor = .systemGreen
        button.titleLabel?.textColor = .white
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()
    
    @objc func didTapButton() {
        let alert = UIAlertController(title: "Create Todo", message: "Enter your todo", preferredStyle: .alert)
        alert.addTextField()
        let saveButton = UIAlertAction(title: "Create", style: .default) { _ in
            guard let textTitle = alert.textFields?[0].text else { return }
            self.addItem(textTitle)
        }
        alert.addAction(saveButton)
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelButton)
        present(alert, animated: true)
    }
    
    func addItem(_ title: String) {
        self.todos.append(TodoModel(title: title, description: description))
        self.tableView.reloadData()
    }
    
    func addButtonConstraints() {
        NSLayoutConstraint.activate([
            self.button.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 300),
            self.button.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            self.button.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
        ])
    }
    
    // Создание таблицы
    var tableView: UITableView = {
        var tableView = UITableView() // Создаём талицу
        tableView.translatesAutoresizingMaskIntoConstraints = false // Указываем что мы в ручную будем указывать констрейны
        return tableView
    }()
    
    // Настройка Constraints для таблицы
    func tableViewConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 60),
            tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    // Конфигурация для tableView
    func configTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "todoCell")
    }
    
    // Указываем кол-во элементов в таблице
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.todos.count // Размер таблицы будет зависить от кол-ва элеменитов в массиве
    }
    
    // Создание ячеек для таблицы
    // В данной функции мы описываем как будет выглядеть ячейка нашей таблицы
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "todoCell")
        cell.textLabel?.text = self.todos[indexPath.row].title
        if self.todos[indexPath.row].isCompleted {
            cell.accessoryType = .checkmark
            cell.backgroundColor = .systemGreen
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        self.todos[indexPath.row].isCompleted.toggle()
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

