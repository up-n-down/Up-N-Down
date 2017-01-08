//
//  FinderSync+Menu.swift
//  Up-N-Down
//
//  Created by Thomas Paul Mann on 23/11/2016.
//  Copyright © 2016 Up-N-Down. All rights reserved.
//

import FinderSync

extension FinderSync {

    override func menu(for menu: FIMenuKind) -> NSMenu? {
        switch menu {
        case .toolbarItemMenu:
            return createToolbarMenu()
        case .contextualMenuForItems:
            return createContextualMenu()
        default:
            return nil
        }
    }

}
