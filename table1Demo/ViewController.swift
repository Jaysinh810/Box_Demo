//
//  ViewController.swift
//  table1Demo
//
//  Created by Jay on 19/06/24.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var changeBtn: UIButton!
    @IBOutlet weak var boxCollectionView: UICollectionView!
    @IBOutlet weak var boxTF: UITextField!
    
    var n : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.boxCollectionView.isHidden = true
        self.boxCollectionView.delegate = self
        self.boxCollectionView.dataSource = self
        
//        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
//        layout.itemSize = CGSize(width: 60, height: 60)
        
        
        self.changeBtn.layer.cornerRadius = self.changeBtn.frame.height / 2
        self.changeBtn.layer.borderWidth = 2
        
        
    }

    @IBAction func onclickchangeBtn(_ sender: UIButton) {
        
        self.boxCollectionView.isHidden = false
        self.n = Int(self.boxTF.text!) ?? 3
        
        self.boxTF.text?.removeAll()
        self.boxCollectionView.reloadData()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return n * n
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.boxCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        cell.backgroundColor = .blue
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padd: CGFloat = 10
        
        let collSize = self.boxCollectionView.frame.size.width - padd * (CGFloat(n) + 1)
        let itemSize = collSize / CGFloat(n)
        
        return CGSize(width: itemSize, height: itemSize)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        print("selected cell : ", indexPath.item)
        
        let selectedItem = indexPath.item
        
        let row = selectedItem / n
        let col = selectedItem % n
        
        if let cell = self.boxCollectionView.cellForItem(at: indexPath) {
            cell.backgroundColor = .red //RED
            self.originalBg(cell: cell)
        }
        
        // Update the colors of horizontal items
        for c in 0..<n {
            if c != col { // Exclude the selected item itself
                let horizontalIndex = IndexPath(item: row * n + c, section: 0)
                if let cell = collectionView.cellForItem(at: horizontalIndex) {
                    cell.backgroundColor = UIColor.green //GREEN
                    self.originalBg(cell: cell)
                }
            }
        }
                
        // Update the colors of vertical items
        for r in 0..<n {
            if r != row { // Exclude the selected item itself
                let verticalIndex = IndexPath(item: r * n + col, section: 0)
                if let cell = collectionView.cellForItem(at: verticalIndex) {
                    cell.backgroundColor = UIColor.green //GREEN
                    self.originalBg(cell: cell)
                }
            }
        }
        
        // Top-left to bottom-right
        for i in 0..<n {
            if row - col + i >= 0 && row - col + i < n {
                let diagonalIndex1 = IndexPath(item: (row - col + i) * n + i, section: 0)
                if diagonalIndex1 != indexPath, let cell = collectionView.cellForItem(at: diagonalIndex1) {
                    cell.backgroundColor = UIColor.yellow //YELLOW
                    self.originalBg(cell: cell)
                }
            }
        }
                
        // Top-right to bottom-left
        for i in 0..<n {
            if row + col - i >= 0 && row + col - i < n {
                let diagonalIndex2 = IndexPath(item: (row + col - i) * n + i, section: 0)
                if diagonalIndex2 != indexPath, let cell = collectionView.cellForItem(at: diagonalIndex2) {
                    cell.backgroundColor = UIColor.yellow //YELLOW
                    self.originalBg(cell: cell)
                }
            }
        }
        
    }
    
    func originalBg(cell: UICollectionViewCell) { //return to original color
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            cell.backgroundColor = .blue
        }
    }
    
    
}

