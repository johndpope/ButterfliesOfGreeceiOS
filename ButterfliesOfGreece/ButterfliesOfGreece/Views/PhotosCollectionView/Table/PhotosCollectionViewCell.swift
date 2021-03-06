//
//  PhotosCollectionViewCell.swift
//  ButterfliesOfGreece
//
//  Created by Ioannis Kapsouras on 13/8/20.
//  Copyright © 2020 Ioannis Kapsouras. All rights reserved.
//

import UIKit
import RxSwift

class PhotosCollectionViewCell: UICollectionViewCell {
	@IBOutlet weak var ViewBack: UIView!
	@IBOutlet weak var LabelName: UILabel!
	@IBOutlet weak var ImageButterfly: UIImageView!
	@IBOutlet weak var ImageAdd: UIImageView!
	static var Key:String = "PhotosCollectionViewCell"
	static var Nib:UINib = UINib.init(nibName: "PhotosCollectionViewCell", bundle: nil)
	
	
	var addRecognizer:UITapGestureRecognizer?
	var emitter:PublishSubject<UiEvent>?
	var familyId:Int?
	var specieId:Int?
	var photoId:Int?
	var showingStep:ShowingStep?
	
	override func awakeFromNib() {
		super.awakeFromNib()
		prepareView()
	}
	
	override func draw(_ rect: CGRect) {
		ImageButterfly.layer.cornerRadius = ImageButterfly.bounds.width/2
		ViewBack.layer.cornerRadius = 16
	}
	
	func update(family: Family, emitter:PublishSubject<UiEvent>, showingStep:ShowingStep){
		self.emitter = emitter
		self.showingStep = showingStep
		LabelName.text = family.name
		familyId = family.id
		ImageButterfly.image = UIImage(named: "ThumbnailsBig/\(family.photo)", in: nil, compatibleWith: nil)
		if  ImageButterfly.image == nil{
			ImageButterfly.image = #imageLiteral(resourceName: "default")
		}
		ImageAdd.image = #imageLiteral(resourceName: "plusIcon").withRenderingMode(.alwaysTemplate)
	}
	
	func update(specie: Specie, emitter:PublishSubject<UiEvent>, showingStep:ShowingStep){
		self.emitter = emitter
		self.showingStep = showingStep
		LabelName.text = specie.name
		specieId = specie.id
		ImageButterfly.image = UIImage(named: "ThumbnailsBig/\(specie.imageTitle)", in: nil, compatibleWith: nil)
		if  ImageButterfly.image == nil{
			ImageButterfly.image = #imageLiteral(resourceName: "default")
		}
		ImageAdd.image = #imageLiteral(resourceName: "plusIcon").withRenderingMode(.alwaysTemplate)
	}
	
	func update(photo: ButterflyPhoto, emitter:PublishSubject<UiEvent>, showingStep:ShowingStep){
		self.emitter = emitter
		self.showingStep = showingStep
		LabelName.text = "\(photo.author)"
		photoId = photo.id
		ImageButterfly.image = UIImage(named: "ThumbnailsBig/\(photo.source)", in: nil, compatibleWith: nil)
		if  ImageButterfly.image == nil{
			ImageButterfly.image = #imageLiteral(resourceName: "default")
		}
		ImageAdd.image = #imageLiteral(resourceName: "plusIcon").withRenderingMode(.alwaysTemplate)
	}
	
	func prepareView(){
		ViewBack.backgroundColor = Constants.Colors.field(darkMode: false).color
		ViewBack.layer.borderWidth = 4
		ViewBack.layer.borderColor = Constants.Colors.field(darkMode: true).color.cgColor
		LabelName.textColor = Constants.Colors.field(darkMode: true).color
		LabelName.setFont(size: Constants.Fonts.fontPhotosSize)
		ImageAdd.tintColor = Constants.Colors.field(darkMode: true).color
	}
	
	func addRecognizers(){
		if (addRecognizer == nil)
		{
			addRecognizer = UITapGestureRecognizer(target: self, action: #selector(addTapped(_:)))
			ImageAdd.addGestureRecognizer(addRecognizer!)
			ImageAdd.isUserInteractionEnabled = true
		}
	}
	
	func removeRecognizers(){
		if(addRecognizer != nil){
			ImageAdd.isUserInteractionEnabled = false
			ImageAdd.removeGestureRecognizer(addRecognizer!)
			addRecognizer = nil
		}
	}
	
	@objc func addTapped(_ sender: UITapGestureRecognizer) {
		if let emitter = emitter{
			switch showingStep {
			case .families:
				emitter.onNext(FamiliesEvents.addPhotosForPrintClicked(familyId: familyId ?? -1))
			case .species:
				emitter.onNext(SpeciesEvents.addPhotosForPrintClicked(specieId: specieId ?? -1))
			case .photos:
				emitter.onNext(PhotosEvents.addPhotoForPrintClicked(photoId: photoId ?? -1))
			case .photosToPrint:
				print("not implemented yet")
			case .none:
				print("nothing")
			}
			
		}
	}
}
