//
//  MainMenuView.swift
//  Graal-BMSTU
//
//  Created by Артём on 09.11.2022.
//

import UIKit

// передается при нажатии на день, чтобы полное расписание открылось на нужном месте (отмоталось
// само)

let TableView = UIView.init(frame: CGRect.zero, style: .grouped)

class TableViewController: UITableViewController {
    
    private var data = ["Электроника", "Дискретная математика", "Физика", "Базы данных"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view?.backgroundColor = UIColor.white
        self.navigationItem.title = "Расписание"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        self.view.addSubview(self.tableView)
        self.tableView.register(TableViewCell.self, forCellReuseIdentifier: "TableVieCell")
        self.tableView.dataSource = self
        
        self.updateLayout(with: self.view.frame.size)
    }
   
    override func viewWillTransition(to size: CGSize, with coordinator:
                                     UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { (contex) in
            self.updateLayout(with: size)
        }, completion: nil)
    }
    
    private func updateLayout(with size: CGSize) {
        self.TableView.frame = CGRect.init(origin: .zero, size: size)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableViw {
        case self.tableView:
            return self.data.count
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView(tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.textLabel?.text = self.data[indexPath.row]
        if indexPath.row == 0 {
            cell.accessoryType = .disclosureIndicator
        }
        return cell
    }
}

class TableViewCell: UITableViewCell {
    
            override func prepareForReuse() {
                super.prepareForReuse()
                self.accessoryType = .none
            }
}



//enum SchedulePosition {
 //   case today, nextDay
//}

//final class MainMenuView: UIView { }


