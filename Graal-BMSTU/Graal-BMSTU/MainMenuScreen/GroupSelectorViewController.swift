//
// Created by Артём on 27.12.2022.
//

import UIKit
import RswiftResources

final class GroupSelectorViewController: UIViewController {
    private var dataService: ScheduleService
    private var authService: AuthService
    private var table = UITableView(frame: .zero)
    private var data: [StudyStream: [Group]]?
    private var orderedData: [(StudyStream, [Group])]?
    private var orderedGroups: [Group]?

    init(dataService: ScheduleService, authService: AuthService) {
        self.dataService = dataService
        self.authService = authService
        super.init(nibName: nil, bundle: nil)
        table.dataSource = self
        table.delegate = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        setupUI()
        update()
    }

    required init?(coder: NSCoder) {
        nil
    }
}

private extension GroupSelectorViewController {
    func setupUI() {
        view.addSubview(table)
        setupConstraints()
    }

    func setupConstraints() {
        table.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }

    func update() {
        Task {
            await loadData()
            orderData()
            DispatchQueue.main.async { [self] in
                table.reloadData()
            }
        }
    }

    func orderData() {
        guard let data = self.data else { return }
        var orderedKeys: [StudyStream] = Array(data.keys.map { $0 })
        orderedKeys.sort { (v: StudyStream, v2: StudyStream) in
            return v < v2
        }
        orderedData = []
        orderedGroups = []
        for stream in orderedKeys {
            if let groups = data[stream] {
                self.orderedData?.append((stream, groups))
                for group in groups {
                    self.orderedGroups?.append(group)
                }
            }
        }
    }

    func loadData() async {
        if let data = await dataService.getGroupsList() {
            self.data = data
        } else {
            self.data = nil
        }
    }
}

extension GroupSelectorViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderedGroups?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // default
        guard let group = orderedGroups?[indexPath.row] else {
            return UITableViewCell()
        }
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "Cell") else { return UITableViewCell() }
        cell.textLabel?.text = group.name
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedGroup = self.orderedGroups?[indexPath.row] {
            authService.changeGroup(to: selectedGroup)
        }
        self.navigationController?.popViewController(animated: true)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
//        return orderedData?.count ?? 0
        1
    }

//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "\(orderedData?[section].0.faculty ?? "")"
//    }
}
