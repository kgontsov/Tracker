//
//  TableViewSeparatorHelper.swift
//  Tracker
//
//  Created by Kirill Gontsov on 16.11.2023.
//

import UIKit

final class SeparatorHelper {
    static func configSeparatingLine(tableView: UITableView, cell: UITableViewCell, indexPath: IndexPath) {
        let lastRowIndex = tableView.numberOfRows(inSection: 0) - 1
        if indexPath.row == lastRowIndex {
            cell.separatorInset = UIEdgeInsets(top: 0, left: tableView.bounds.size.width, bottom: 0, right: 0)
        } else {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        }
    }
}
