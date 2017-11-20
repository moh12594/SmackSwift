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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    avatarCollectionView.delegate = self
    avatarCollectionView.dataSource = self

  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if let cell = avatarCollectionView.dequeueReusableCell(withReuseIdentifier: "avatarCell", for: indexPath) as? AvatarCell {
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
  }
  

  

}
