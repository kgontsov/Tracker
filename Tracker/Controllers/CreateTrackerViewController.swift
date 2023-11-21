//
//  CreateTrackerViewController.swift
//  Tracker
//
//  Created by Kirill Gontsov on 12.11.2023.
//

import UIKit

final class CreateTrackerViewController: UIViewController {
    private var trackerOptions: [String] = []
    private var weekSchedule = [WeekDay]()
    
    private var pageTitle: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        return label
    }()
    
    private lazy var trackerNameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor(red: 0.9, green: 0.91, blue: 0.92, alpha: 0.3)
        textField.placeholder = "Введите название трекера"
        textField.layer.cornerRadius = 16
        textField.delegate = self
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        return textField
    }()
    
    private let trackerOptionsTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Отменить", for: .normal)
        button.setTitleColor(UIColor(red: 0.96, green: 0.42, blue: 0.42, alpha: 1.0), for: .normal)
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 1
        button.layer.borderColor = CGColor(red: 0.96, green: 0.42, blue: 0.42, alpha: 1.0)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var createButton: UIButton = {
        let button = UIButton()
        button.setTitle("Создать", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 16
        button.backgroundColor = .lightGray
        button.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupViews()
        setupTableView()
        setupButtonStackView()
    }
    
    func configTitleAndOptions(_ title: String, _ options: [String]) {
        self.pageTitle.text = title
        self.trackerOptions = options
    }
        
    private func setupViews() {
        [pageTitle, trackerNameTextField, trackerOptionsTableView, buttonStackView].forEach { view.falseAutoresizing($0) }
        
        NSLayoutConstraint.activate([
            pageTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 27),
            
            trackerNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            trackerNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            trackerNameTextField.heightAnchor.constraint(equalToConstant: 75),
            trackerNameTextField.topAnchor.constraint(equalTo: pageTitle.bottomAnchor, constant: 38),
            
            trackerOptionsTableView.topAnchor.constraint(equalTo: trackerNameTextField.bottomAnchor, constant: 24),
            trackerOptionsTableView.leadingAnchor.constraint(equalTo: trackerNameTextField.leadingAnchor),
            trackerOptionsTableView.trailingAnchor.constraint(equalTo: trackerNameTextField.trailingAnchor),
            trackerOptionsTableView.heightAnchor.constraint(equalToConstant: CGFloat(trackerOptions.count * 75)),
            
            buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            buttonStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            buttonStackView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func setupTableView() {
        trackerOptionsTableView.dataSource = self
        trackerOptionsTableView.delegate = self
        trackerOptionsTableView.register(CreateTrackerCell.self, forCellReuseIdentifier: CreateTrackerCell.reuseIdentifier)
        trackerOptionsTableView.layer.cornerRadius = 16
    }
    
    private func setupButtonStackView() {
        [cancelButton, createButton].forEach { buttonStackView.addArrangedSubview($0) }
        buttonStackView.spacing = 8
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .fillEqually
    }
    
    @objc
    private func cancelButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc
    private func createButtonTapped() {
        let category = TrackerCategory(name: "Создаем новые категории", trackers: [])

        let trackerName = trackerNameTextField.text ?? ""
        
        var scheduleForNewTracker = [WeekDay]()
        if weekSchedule.count > 0 {
            scheduleForNewTracker = weekSchedule
        } else {
            scheduleForNewTracker = [.monday, .tuesday, .wednesday, .thursday, .friday , .saturday, .sunday]
        }

        let newTracker = Tracker(name: trackerName,
                                 color: UIColor.randomColor,
                                 emoji: "⭐️",
                                 schedule: scheduleForNewTracker)
        let userInfo: [String: Any] = [
            "Category": category,
            "NewTracker": newTracker,
        ]

        NotificationCenter.default.post(name: NSNotification.Name("NewTrackerNotification"), object: nil, userInfo: userInfo)
        self.presentingViewController?.presentingViewController?.dismiss(animated: true)
    }
}

// MARK: - UITableViewDataSource

extension CreateTrackerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        trackerOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CreateTrackerCell.reuseIdentifier, for: indexPath) as? CreateTrackerCell else {
            return UITableViewCell()
        }
        let cellName = trackerOptions[indexPath.row]
        let cellAdditionalUIElement = CellElement.arrowImageView
        cell.configCell(nameLabel: cellName, element: cellAdditionalUIElement, indexPath: indexPath)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension CreateTrackerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        SeparatorHelper.configSeparatingLine(tableView: tableView, cell: cell, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            print("Нажали кнопку категория")
        } else {
            let scheduleViewController = ScheduleViewController()
            scheduleViewController.delegate = self
            present(scheduleViewController, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension CreateTrackerViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension CreateTrackerViewController: ScheduleProtocolDelegate {
    func saveSchedule(weekSchedule: [WeekDay]?) {
        guard let weekSchedule = weekSchedule else { return }
        self.weekSchedule = weekSchedule
    }
}
