//
//  FamiliesPresenterTests.swift
//  ButterfliesOfGreeceTests
//
//  Created by Ioannis Kapsouras on 27/7/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import Foundation
import XCTest
import RxSwift
import RxTest
import RxBlocking
import RxCocoa

@testable import ButterfliesOfGreece

class FamiliesPresenterTests: XCTestCase {
	var presenter: FamiliesPresenter!
	var sub:PublishSubject<UiEvent>=PublishSubject<UiEvent>()
	var scheduler:TestScheduler!
	var disposeBag:DisposeBag!
	
	override func setUp() {
		// Put setup code here. This method is called before the invocation of each test method in the class.
		super.setUp()
		self.scheduler = TestScheduler(initialClock: 0)
		presenter = FamiliesPresenter(mainThread: MockMainThreadScheduler(scheduler: self.scheduler),backgroundThread: MockBackgroundThreadScheduler(scheduler: self.scheduler), cacheManager: MockCacheManager(userDefaults: MockUserDefaults(numberOfPhotos: 0)))
		self.disposeBag = DisposeBag()
	}
	
	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
	}
	
	func testShouldChangeArrangeStyleOnClick()
	{
		let observer = scheduler.createObserver(ViewState.self)
		
		presenter.headerState.currentArrange = .grid
		
		scheduler
			.createHotObservable([
				Recorded.next(200, (HeaderViewEvents.switchViewStyleClicked) as UiEvent)
			])
			.bind(onNext: {event in self.presenter?.HandleEvent(uiEvents: event)})
			.disposed(by: presenter!.disposeBag)
		
		presenter.state.bind(to: observer)
			.disposed(by: disposeBag)
		
		scheduler.start()
		
		XCTAssert(!(observer.events.first?.value.element?.isTransition ?? false))
		XCTAssert(observer.events.first?.value.element != nil &&
			observer.events.first?.value.element is FamiliesViewStates)
		let viewState = observer.events.first?.value.element as! FamiliesViewStates
		switch viewState {
		case .SwitchViewStyle(let currentArrange):
			XCTAssert(currentArrange == .list)
		default:
			XCTFail()
		}
	}
	
	func testShouldReadJsonData()
	{
		let observer = scheduler.createObserver(ViewState.self)
		
		scheduler
			.createHotObservable([
				Recorded.next(200, (FamiliesEvents.loadFamilies) as UiEvent)
			])
			.bind(onNext: {event in self.presenter?.HandleEvent(uiEvents: event)})
			.disposed(by: presenter!.disposeBag)
		
		presenter.state.bind(to: observer)
			.disposed(by: disposeBag)
		
		scheduler.start()
		
		XCTAssert(!(observer.events.first?.value.element?.isTransition ?? false))
		XCTAssert(observer.events.first?.value.element != nil &&
			observer.events.first?.value.element is FamiliesViewStates)
		let viewState = observer.events.first?.value.element as! FamiliesViewStates
		switch viewState {
		case .ShowFamilies(let families):
			XCTAssert(families.count == 9)//test json data
		default:
			XCTFail()
		}
	}
	
	func testShouldNavigateToSpeciesOnFamilyClick()
	{
		let observer = scheduler.createObserver(ViewState.self)
		
		presenter.headerState.currentArrange = .grid
		
		scheduler
			.createHotObservable([
				Recorded.next(200, (FamiliesEvents.familyClicked(id: 1)) as UiEvent)
			])
			.bind(onNext: {event in self.presenter?.HandleEvent(uiEvents: event)})
			.disposed(by: presenter!.disposeBag)
		
		presenter.state.bind(to: observer)
			.disposed(by: disposeBag)
		
		scheduler.start()
		
		XCTAssert(observer.events.first?.value.element?.isTransition ?? false)
		XCTAssert(observer.events.first?.value.element != nil &&
			observer.events.first?.value.element is FamiliesViewStates)
		let viewState = observer.events.first?.value.element as! FamiliesViewStates
		switch viewState {
		case .ToSpecies(let selectedFamilyId):
			XCTAssert(selectedFamilyId == 1)//test json data
		default:
			XCTFail()
		}
	}
	
	func testShouldGetZeroPhotosOnInitFamiliesPresenter()
	{
		let observer = scheduler.createObserver(ViewState.self)
		
		presenter.headerState.currentArrange = .grid
		
		scheduler
			.createHotObservable([
				Recorded.next(200, (HeaderViewEvents.initPhotosToPrint) as UiEvent)
			])
			.bind(onNext: {event in self.presenter?.HandleEvent(uiEvents: event)})
			.disposed(by: presenter!.disposeBag)
		
		presenter.state.bind(to: observer)
			.disposed(by: disposeBag)
		
		scheduler.start()
		
		XCTAssert(!(observer.events.first?.value.element?.isTransition ?? false))
		XCTAssert(observer.events.first?.value.element != nil &&
			observer.events.first?.value.element is HeaderViewViewStates)
		let viewState = observer.events.first?.value.element as! HeaderViewViewStates
		switch viewState {
		case .updateFolderIcon(let numberOfPhotos):
			XCTAssert(numberOfPhotos == 0)//test json data
		}
	}
	
	func testShouldGetCorrectNumberOfAddedPhotos()
	{
		let observer = scheduler.createObserver(ViewState.self)
		let photosPerFamily = [23,72,2,2,2,156,84,101,48]
		
		presenter.headerState.currentArrange = .grid
		
		scheduler
			.createHotObservable([
				Recorded.next(200, (FamiliesEvents.addPhotosForPrintClicked(familyId: 0)) as UiEvent),
				Recorded.next(300, (FamiliesEvents.addPhotosForPrintClicked(familyId: 1)) as UiEvent),
				Recorded.next(400, (FamiliesEvents.addPhotosForPrintClicked(familyId: 2)) as UiEvent),
				Recorded.next(500, (FamiliesEvents.addPhotosForPrintClicked(familyId: 3)) as UiEvent),
				Recorded.next(600, (FamiliesEvents.addPhotosForPrintClicked(familyId: 4)) as UiEvent),
				Recorded.next(700, (FamiliesEvents.addPhotosForPrintClicked(familyId: 5)) as UiEvent),
				Recorded.next(800, (FamiliesEvents.addPhotosForPrintClicked(familyId: 6)) as UiEvent),
				Recorded.next(900, (FamiliesEvents.addPhotosForPrintClicked(familyId: 7)) as UiEvent),
				Recorded.next(1000, (FamiliesEvents.addPhotosForPrintClicked(familyId: 8)) as UiEvent)
			])
			.bind(onNext: {event in self.presenter?.HandleEvent(uiEvents: event)})
			.disposed(by: presenter!.disposeBag)
		
		presenter.state.bind(to: observer)
			.disposed(by: disposeBag)
		
		scheduler.start()
		
		var sum = 0
		var index = 0
		observer.events.forEach({(vs) in
			XCTAssert(!(vs.value.element?.isTransition ?? false))
			XCTAssert(vs.value.element != nil &&
				vs.value.element is HeaderViewViewStates)
			let viewState = vs.value.element as! HeaderViewViewStates
			switch viewState {
			case .updateFolderIcon(let numberOfPhotos):
				print("Number of photos \(numberOfPhotos)")
				XCTAssert(numberOfPhotos == photosPerFamily[index])
				sum += numberOfPhotos
			}
			index += 1
		})
		print("sum = \(sum)")
		XCTAssert(sum == 490)
	}
}
