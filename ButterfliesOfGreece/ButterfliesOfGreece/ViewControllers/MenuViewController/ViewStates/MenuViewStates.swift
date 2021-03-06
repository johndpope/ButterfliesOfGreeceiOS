//
//  MenuViewStates.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 27/7/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation

enum MenuViewState:ViewState {
	case toField
	case toIntroduction
	case toEndangered
	case toLegal
	case toAbout
	case toContribute
	case toOnlineRecognition
	case toOfflineRecognition
	case toRecognition
	
	var isTransition:Bool{
		switch self {
			case .toField,
				 .toIntroduction,
				 .toEndangered,
				 .toLegal,
				 .toAbout,
				 .toContribute,
				 .toOnlineRecognition,
				 .toOfflineRecognition,
				 .toRecognition:
				return true
		}
	}
}

extension MenuViewState{
	var toStoryboardName:String?{
		switch self {
			case .toField:
				return "Families"
			case .toContribute:
				return "Contribute"
			case .toAbout:
				return "About"
			case .toIntroduction:
				return "Introduction"
			case .toEndangered:
				return "Endangered"
			case .toLegal:
				return "Legal"
			case .toRecognition:
			return "Recognition"
			default:
				return nil
		}
	}
	
	var toViewControllerName:String?{
		switch self {
			case .toField:
				return "FamiliesViewController"
			case .toContribute:
				return "ContributeViewController"
			case .toAbout:
				return "AboutViewController"
			case .toIntroduction:
				return "IntroductionViewController"
			case .toEndangered:
				return "EndangeredViewController"
			case .toLegal:
				return "LegalViewController"
			case .toRecognition:
				return "RecognitionViewController"
			default:
				return nil
		}
	}
}
