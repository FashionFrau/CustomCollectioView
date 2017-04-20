//
//  CustomLayout.swift
//  CustomCollectionView
//
//  Created by Nilson Junior on 19.04.17.
//
//

import UIKit

class CustomLayout: UICollectionViewLayout {
    let numberOfColumns = 2
    let verticalSpaceBetweenMiniCards: CGFloat = 20.0
    let horizontalSpaceBetweenMiniCards: CGFloat = 10.0

    let spaceBetweenHeaderAndMiniCards: CGFloat = 10.0

    let rowHeight: CGFloat = 200.0

    let headderPadding: CGFloat = 5.0

    var hearderWidth: CGFloat {
        let percentageWidth: CGFloat = 0.25
        return collectionView!.bounds.width * percentageWidth
    }

    let footerPadding: CGFloat = 5.0
    let footerHeight: CGFloat = 5.0

    //    Attributes
    fileprivate var headerAttributes = [UICollectionViewLayoutAttributes]()
    fileprivate var miniCardsAttributes = [UICollectionViewLayoutAttributes]()
    fileprivate var footerAttributes = [UICollectionViewLayoutAttributes]()

    //  ViewContentSize
    fileprivate var contentHeight: CGFloat  = 0.0
    fileprivate var contentWidth: CGFloat {
        let insets = collectionView!.contentInset
        return collectionView!.bounds.width - (insets.left + insets.right)
    }

    var headerXOffset: CGFloat = 0
    var yOffset: [CGFloat] = []
    var column:Int = 0

    override func prepare() {

        if (collectionView == nil) {
            return
        }

        headerAttributes.removeAll()
        miniCardsAttributes.removeAll()
        footerAttributes.removeAll()


        let columnWidth = (contentWidth - hearderWidth) / CGFloat(numberOfColumns)
        var xOffset = [CGFloat]()
        for column in 0 ..< numberOfColumns {
            xOffset.append(hearderWidth + CGFloat(column) * columnWidth)
        }
        column = 0
        yOffset = [CGFloat](repeating: 0, count: numberOfColumns)


        for section in 0 ..< collectionView!.numberOfSections {

            calculateFramesForHeader(section: section)

            for miniCard in 0 ..< collectionView!.numberOfItems(inSection: section) {

                let miniCardIndexPath = IndexPath(item: miniCard, section: section)

                let miniCardWidthOffset = columnWidth - horizontalSpaceBetweenMiniCards
                let minCardHeightOffset = rowHeight - verticalSpaceBetweenMiniCards
                let miniCardYOffset = yOffset[column] + verticalSpaceBetweenMiniCards

                let miniCardAttributes = UICollectionViewLayoutAttributes(forCellWith: miniCardIndexPath)
                miniCardAttributes.frame = CGRect(x: xOffset[column], y: miniCardYOffset, width: miniCardWidthOffset, height: minCardHeightOffset)
                miniCardsAttributes.append(miniCardAttributes)


                contentHeight = max(contentHeight, miniCardAttributes.frame.maxY)
                yOffset[column] = yOffset[column] + rowHeight

                column = column >= (numberOfColumns - 1) ? 0 : column + 1
            }

            calculateFramesForFooter(section: section)

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

        for attributes in footerAttributes {
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


extension CustomLayout {

    fileprivate func calculateFramesForHeader(section: Int) {
        let headerIndexPath = IndexPath(item: 0, section: section)
        let headerCellAttributes =
            UICollectionViewLayoutAttributes(
                forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
                with: headerIndexPath)

        headerXOffset = 0 + headderPadding
        let headerYOffset = CGFloat(section) * rowHeight + verticalSpaceBetweenMiniCards
        let hearderWidthOffset = hearderWidth - spaceBetweenHeaderAndMiniCards
        let headerHeightOffset = rowHeight - verticalSpaceBetweenMiniCards


        headerCellAttributes.frame = CGRect(x: headerXOffset, y: headerYOffset, width: hearderWidthOffset, height: headerHeightOffset)
        headerAttributes.append(headerCellAttributes)

    }

    fileprivate func calculateFramesForFooter(section: Int) {
        let footerIndexPath = IndexPath(item: 0, section: section)
        let footerCellAttributes = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, with: footerIndexPath)

        let footerXOffset = headerXOffset
        let footerYOffset = yOffset[column] + footerPadding
        let footerWidthOffset =  contentWidth - 2 * footerPadding
        let footerHeightOffset = footerHeight

        footerCellAttributes.frame = CGRect(x: footerXOffset, y: footerYOffset, width: footerWidthOffset, height: footerHeightOffset)
        footerAttributes.append(footerCellAttributes)
    }
}
