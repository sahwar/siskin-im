//
// ExperimentalSettingsViewController.swift
//
// Tigase iOS Messenger
// Copyright (C) 2017 "Tigase, Inc." <office@tigase.com>
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as published by
// the Free Software Foundation, either version 3 of the License,
// or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public License
// along with this program. Look for COPYING file in the top folder.
// If not, see http://www.gnu.org/licenses/.
//

import UIKit

class ExperimentalSettingsViewController: CustomTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let setting = SettingsEnum(rawValue: indexPath.row)!;
        switch setting {
        case .notificationsFromUnknown:
            let cell = tableView.dequeueReusableCell(withIdentifier: "XmppPipeliningTableViewCell", for: indexPath) as! SwitchTableViewCell;
            cell.switchView.isOn = Settings.XmppPipelining.getBool();
            cell.valueChangedListener = {(switchView: UISwitch) in
                Settings.XmppPipelining.setValue(switchView.isOn);
            }
            return cell;
        case .enableBookmarksSync:
            let cell = tableView.dequeueReusableCell(withIdentifier: "EnableBookmarksSyncTableViewCell", for: indexPath) as! SwitchTableViewCell;
            cell.switchView.isOn = Settings.EnableBookmarksSync.getBool();
            cell.valueChangedListener = {(switchView: UISwitch) in
                Settings.EnableBookmarksSync.setValue(switchView.isOn);
            }
            return cell;
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true);
    }
    
    internal enum SettingsEnum: Int {
        case notificationsFromUnknown = 0
        case enableBookmarksSync = 1
    }
}
