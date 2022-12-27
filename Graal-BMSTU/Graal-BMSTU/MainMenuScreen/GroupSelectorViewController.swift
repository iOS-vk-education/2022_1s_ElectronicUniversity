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
        super.init(nibName: nil, bundle: nil)
        table.dataSource = self
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
        // call data sevice
    }
}

extension GroupSelectorViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // depends on section
        <#code#>
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // default
        <#code#>
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        authService.changeGroup(to: self.groups[?])
        self.navigationController?.popViewController(animated: true)
    }

    func numberOfSections(in tableView: UITableView) -> Int {

    }
}
