//
//  allTeachersCollectionView.h
//  Educational_Administration
//
//  Created by Apple on 2018/5/17.
//  Copyright © 2018年 chen. All rights reserved.
//

#import <UIKit/UIKit.h>

#define eachTeacherEventCellWidth 80



@interface allTeachersCollectionViewFlowLayout : UICollectionViewFlowLayout
@end

@implementation allTeachersCollectionViewFlowLayout

- (UICollectionViewLayoutInvalidationContext *)invalidationContextForBoundsChange:(CGRect)newBounds {
    
    UICollectionViewFlowLayoutInvalidationContext *context = (UICollectionViewFlowLayoutInvalidationContext *)[super invalidationContextForBoundsChange:newBounds];
    CGRect oldBounds = self.collectionView.bounds;
    context.invalidateFlowLayoutDelegateMetrics = !CGSizeEqualToSize(newBounds.size, oldBounds.size);
    return context;
}

// we keep this for iOS 8 compatibility. As of iOS 9, this is replaced by collectionView:targetContentOffsetForProposedContentOffset:
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset
{
    id<UICollectionViewDelegate> delegate = (id<UICollectionViewDelegate>)self.collectionView.delegate;
    return [delegate collectionView:self.collectionView targetContentOffsetForProposedContentOffset:proposedContentOffset];
}


@end


@interface allTeachersCollectionView : UICollectionView


@end
