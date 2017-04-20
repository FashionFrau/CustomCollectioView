//
//  CustomLayout.swift
//  CustomCollectionView
//
//  Created by Nilson Junior on 19.04.17.
//
//

import UIKit

class CustomLayout: UICollectionViewLayout {
    var numberOfColumns = 2
    let verticalSpaceBetweenMiniCards: CGFloat = 10.0
    let horizontalSpaceBetweenMiniCards: CGFloat = 10.0

    let spaceBetweenHeaderAndMiniCards: CGFloat = 10.0

    let cellHeight: CGFloat = 200.0

    let headderPadding: CGFloat = 5.0

    var hearderWidth: CGFloat {
        let percentageWidth: CGFloat = 0.25
        return collectionView!.bounds.width * percentageWidth
    }

    // 3
    private var headerAttributes = [UICollectionViewLayoutAttributes]()
    private var miniCardsAttributes = [UICollectionViewLayoutAttributes]()

    // 4
    private var contentHeight: CGFloat  = 0.0
    private var contentWidth: CGFloat {
        let insets = collectionView!.contentInset
        return collectionView!.bounds.width - (insets.left + insets.right)
    }


    override func prepare() {

        if (collectionView == nil) {
            return
        }
        headerAttributes.removeAll()
        miniCardsAttributes.removeAll()
        // 2

        let columnWidth = (contentWidth - hearderWidth) / CGFloat(numberOfColumns)
        var xOffset = [CGFloat]()
        for column in 0 ..< numberOfColumns {
            xOffset.append(hearderWidth + CGFloat(column) * columnWidth)
        }
        var column = 0
        var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)

        // 3
        //            for section in 1..collectionView!.numberOfSections {

        calculateFramesForHeaders()
        for item in 0 ..< collectionView!.numberOfItems(inSection: 0) { //TODO inSection value

            let indexPath = NSIndexPath(item: item, section: 0)

            let width = columnWidth - horizontalSpaceBetweenMiniCards
            let height = cellHeight - verticalSpaceBetweenMiniCards
            let frame = CGRect(x: xOffset[column], y: yOffset[column], width: width, height: height)

            // 5
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath as IndexPath)
            attributes.frame = frame
            miniCardsAttributes.append(attributes)

            // 6
            contentHeight = max(contentHeight, frame.maxY)
            yOffset[column] = yOffset[column] + cellHeight

            column = column >= (numberOfColumns - 1) ? 0 : column + 1
        }
        //            }

    }

    private func calculateFramesForHeaders() {
        for section in 0...collectionView!.numberOfSections {
            let indexPath = IndexPath(item: 0, section: section)

            let headerCellAttributes =
                UICollectionViewLayoutAttributes(
                    forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
                    with: indexPath)

            let yOffset = CGFloat(section) * (cellHeight + horizontalSpaceBetweenMiniCards)
            let hearderWidthY = hearderWidth - spaceBetweenHeaderAndMiniCards
            let height = cellHeight - verticalSpaceBetweenMiniCards
            let xOffeset = 0 + headderPadding

            headerCellAttributes.frame = CGRect(x: xOffeset, y: yOffset, width: hearderWidthY, height: height)
            headerAttributes.append(headerCellAttributes)
        }
    }

    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()

        for attributes in headerAttributes {
            if attributes.frame.intersects(rect) {
                layoutAttributes.append(attributes)
            }
        }

        for attributes in miniCardsAttributes {
            if attributes.frame.intersects(rect) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes

    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return miniCardsAttributes[indexPath.row]
    }
}
