//
//  GalleryOfShuttlesCollectionView.swift
//  Space Road
//
//  Created by Kyzu on 14.06.22.
// swiftlint:disable line_length

import UIKit

class GalleryOfShuttlesCollectionView: UICollectionView, UICollectionViewDelegate,  UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var selectedIndexPath: IndexPath! = [0, 6]
    var shuttleColorIndex = 1
    private var nearestCell: UICollectionViewCell!
    private var changeColorButton: UIButton!
     let shuttlesSkinDictionary: [Int: [String]] = [ 0 : ["1_1", "1_2", "1_3", "1_4"], 1 : ["2_1", "2_2", "2_3", "2_4"], 2 : ["3_1", "3_2", "3_3", "3_4"], 3 : ["4_1", "4_2", "4_3", "4_4"], 4 : ["5_1", "5_2", "5_3", "5_4"], 5 : ["6_1", "6_2", "6_3", "6_4"], 6 : ["7_1", "7_2", "7_3", "7_4"], 7 : ["8_1", "8_2", "8_3", "8_4"], 8 : ["9_1", "9_2", "9_3", "9_4"]]
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        backgroundColor = .systemGray.withAlphaComponent(0.5)
        dataSource = self
        delegate = self
        translatesAutoresizingMaskIntoConstraints = false
        showsHorizontalScrollIndicator = false
        layout.minimumLineSpacing = 25
        contentInset = UIEdgeInsets(top: 5, left: UIScreen.main.bounds.width/2 - 40, bottom: 10, right: UIScreen.main.bounds.width/2 - 40)
        register(GalleryOfShuttleCollectionViewCell.self, forCellWithReuseIdentifier: GalleryOfShuttleCollectionViewCell.reuseID)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return shuttlesSkinDictionary.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: GalleryOfShuttleCollectionViewCell.reuseID, for: indexPath) as? GalleryOfShuttleCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.currentShuttleImageView.image = UIImage(named: "\(shuttlesSkinDictionary[indexPath.row]![0])")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 80, height: 80)
   
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollOffsetX = scrollView.contentOffset.x
        let scrollWidth = scrollView.bounds.size.width
        let scrollHeight = scrollView.bounds.size.height
        let centerPoint = CGPoint(x: scrollOffsetX + (scrollWidth / 2), y: scrollHeight / 2)
        for cell in self.visibleCells {
            let tempFrameCell = cell.layer.presentation()!.frame
            if tempFrameCell.contains(centerPoint) {
                nearestCell = cell
            }
        }
        updateCellsScale(centerX: centerPoint.x)
    }
    
    func updateCellsScale(centerX: CGFloat) {
        
        for cell in self.visibleCells {
            
            cell.transform = CGAffineTransform.identity
            var scaleX: CGFloat = 1
            if centerX + cell.frame.size.width/2 > cell.center.x && centerX - cell.frame.size.width/2 < cell.center.x {
                scaleX = 1.5
                cell.transform = CGAffineTransform(scaleX: scaleX, y: scaleX)
            }
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
         selectedIndexPath = self.indexPath(for: nearestCell)
        self.scrollToItem(at: selectedIndexPath!, at: .centeredHorizontally, animated: true)
        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        selectedIndexPath = self.indexPath(for: nearestCell)
        self.scrollToItem(at: selectedIndexPath!, at: .centeredHorizontally, animated: true)
    }
    
    func changeShuttleColor() {
        guard let cell = cellForItem(at: selectedIndexPath) as? GalleryOfShuttleCollectionViewCell else {
            return
        }

        if shuttleColorIndex < 3 {
            cell.currentShuttleImageView.image = UIImage(named: "\(shuttlesSkinDictionary[selectedIndexPath.row]![shuttleColorIndex+1])")
            shuttleColorIndex += 1
            if shuttleColorIndex == 3 {
                shuttleColorIndex = 0
            }
        }

    }
}
