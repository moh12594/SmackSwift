//
//  AvatarPickerVC.swift
//  Smack
//
//  Created by Mohamed SADAT on 20/11/2017.
//  Copyright © 2017 Mohsadat. All rights reserved.
//

import UIKit

class AvatarPickerVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

  // Outlets
  @IBOutlet weak var avatarCollectionView: UICollectionView!
  @IBOutlet weak var segmentControll: UISegmentedControl!
  
  // Variables
  var avatarType = AvatarType.dark
  
  override func viewDidLoad() {
    super.viewDidLoad()
    avatarCollectionView.delegate = self
    avatarCollectionView.dataSource = self
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if let cell = avatarCollectionView.dequeueReusableCell(withReuseIdentifier: "avatarCell", for: indexPath) as? AvatarCell {
      cell.configureCell(index: indexPath.item, type: avatarType)
      return cell
    }
    return AvatarCell()
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 28
  }
  

  @IBAction func backButtonPressed(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func segmentControllChanged(_ sender: Any) {
    switch segmentControll.selectedSegmentIndex {
    case 0:
      avatarType = .dark
    case 1:
      avatarType = .light
    default:
      avatarType = .dark
    }
    avatarCollectionView.reloadData()
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    var numberOfColumns: CGFloat = 3
    if UIScreen.main.bounds.width > 320 {
      numberOfColumns = 4
    }
    
    let spaceBetweenCells : CGFloat = 10
    let padding : CGFloat = 40
    let cellDimension = ((avatarCollectionView.bounds.width - padding) - (numberOfColumns - 1) * spaceBetweenCells) / numberOfColumns
    return CGSize(width: cellDimension, height: cellDimension)
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if avatarType == .dark {
      UserDataService.instance.setAvatarName(avatarName: "dark\(indexPath.item)")
    } else {
      UserDataService.instance.setAvatarName(avatarName: "light\(indexPath.item)")
    }
    self.dismiss(animated: true, completion: nil)
  }
}
