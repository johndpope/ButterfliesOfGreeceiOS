//
//  FamiliesEvents.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 27/7/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation

enum FamiliesEvents:UiEvent{
	case loadFamilies
	case familyClicked(id:Int)
	case addPhotosForPrintClicked(familyId:Int)
}
