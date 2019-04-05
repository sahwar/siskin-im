//
// DBRoomsManager.swift
//
// Tigase iOS Messenger
// Copyright (C) 2016 "Tigase, Inc." <office@tigase.com>
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

import Foundation
import TigaseSwift

open class DBRoomsManager: DefaultRoomsManager {
    
    fileprivate let store: DBChatStore;
    
    public init(store: DBChatStore) {
        self.store = store;
        super.init(dispatcher: store.dispatcher);
    }
    
    open override func createRoomInstance(roomJid: BareJID, nickname: String, password: String?) -> Room {
        let room = super.createRoomInstance(roomJid: roomJid, nickname: nickname, password: password);
        return store.open(for: context.sessionObject, chat: room)!;
    }
    
    open override func initialize() {
        guard self.getRooms().count == 0 else {
            return;
        }
        let rooms:[Room] = store.getAll(for: context.sessionObject);
        for room in rooms {
            register(room: room);
        }
    }
    
    open override func remove(room: Room) {
        dispatcher.sync(flags: .barrier) {
            if self.store.close(chat: room) {
                super.remove(room: room);
            }
        }
    }
}

class DBRoom: Room {
    
    var id: Int? = nil;
    var roomName: String? = nil;
    
}
