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
private let reuseFooterIdentifier = "FooterCell"

private let nibForHeader = "CustomHeader"
private let nibForFooter = "CustomFooter"

class CustomCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    let dataSource = [["key1": "value", "array": [1,2]], ["key2": "value", "array": [1,2]], ["key3": "value", "array": [1,2]], ["key4": "value", "array": [1,2]]]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        let nibHeader = UINib(nibName: nibForHeader, bundle: nil)
        self.collectionView!.register(nibHeader, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: reuseHeaderIdentifier)

        let nibFooter = UINib(nibName: nibForFooter, bundle: nil)
        self.collectionView!.register(nibFooter, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: reuseFooterIdentifier)

        // Do any additional setup after loading the view.
        if let layout = collectionView?.collectionViewLayout as? CustomLayout {
            layout.delegate = self
        }

        self.collectionView?.reloadData()

//        self.collectionView!.contentInset = UIEdgeInsets(top: 10, left: 5, bottom: 15, right: 5)
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
        if(kind == UICollectionElementKindSectionHeader) {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: reuseHeaderIdentifier, for: indexPath) as! CustomHeaderReusableView
        cell.layer.borderWidth = 2
        
        cell.layer.borderColor = getRandomColor()
        return cell
        } else {
            let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: reuseFooterIdentifier, for: indexPath) as! CustomFooterReusableView
            cell.layer.borderWidth = 2
            cell.layer.borderColor = getRandomColor()
            return cell
        }
    }
}

extension CustomCollectionViewController : CustomLayoutDelegate {

    func collectionView(collectionView:UICollectionView, heightForMiniCardWithWidth:CGFloat) -> CGFloat {
        return 200.0
    }
//    // 1
//    func collectionView(collectionView:UICollectionView, heightForPhotoAtIndexPath indexPath: NSIndexPath,
//                        withWidth width: CGFloat) -> CGFloat {
//        let photo = photos[indexPath.item]
//        let boundingRect =  CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT))
//        let rect  = AVMakeRect(aspectRatio: photo.image.size, insideRect: boundingRect)
//        return rect.size.height
//    }
//
//    // 2
//    func collectionView(collectionView: UICollectionView,
//                        heightForAnnotationAtIndexPath indexPath: NSIndexPath, withWidth width: CGFloat) -> CGFloat {
//        let annotationPadding = CGFloat(4)
//        let annotationHeaderHeight = CGFloat(17)
//        let photo = photos[indexPath.item]
//        let font = UIFont(name: "AvenirNext-Regular", size: 10)!
//        let commentHeight = photo.heightForComment(font, width: width)
//        let height = annotationPadding + annotationHeaderHeight + commentHeight + annotationPadding
//        return height
//    }
}
