//
//  CustomCollectionViewController.swift
//  CustomCollectionView
//
//  Created by Nilson Junior on 19.04.17.
//
//

import UIKit

private let reuseIdentifier = "Cell"
private let reuseHeaderIdentifier = "HeaderCell"
private let nibForHeader = "CustomHeader"

class CustomCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    let dataSource = [["key1": "value", "array": [1,2]], ["key2": "value", "array": [1,2]], ["key3": "value", "array": [1,2]], ["key4": "value", "array": [1,2]]]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        let nib = UINib(nibName: nibForHeader, bundle: nil)
        self.collectionView!.register(nib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: reuseHeaderIdentifier)

        // Do any additional setup after loading the view.
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self

        self.collectionView?.reloadData()

//        self.collectionView!.contentInset = UIEdgeInsets(top: 23, left: 5, bottom: 10, right: 5)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return dataSource.count
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return dataSource[section].count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CustomCollectionViewCell
    
        // Configure the cell

        cell.layer.borderWidth = 2
        cell.layer.borderColor = getRandomColor()
        return cell
    }


    func getRandomColor() -> CGColor {

        let randomRed:CGFloat = CGFloat(drand48())

        let randomGreen:CGFloat = CGFloat(drand48())

        let randomBlue:CGFloat = CGFloat(drand48())

        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0).cgColor
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        if(kind == UICollectionElementKindSectionHeader) {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: reuseHeaderIdentifier, for: indexPath) as! CustomHeaderReusableView
        cell.layer.borderWidth = 1
        
        cell.layer.borderColor = getRandomColor()
        return cell
//        }
    }
}
