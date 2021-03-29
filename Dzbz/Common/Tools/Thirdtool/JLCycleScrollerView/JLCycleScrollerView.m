//
//  JLCycleScrollerView.m
//  JLCycleScrollView
//
//  Created by yangjianliang on 2017/9/24.
//  Copyright © 2017年 yangjianliang. All rights reserved.
//


#import "JLCycleScrollerView.h"
@interface JLCycleScrollerView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSArray *arrayData;
@property (nonatomic, strong) NSArray *titlesarrayData;
@property (nonatomic, copy) NSString *reuseIdentifier;
@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic) PageControlMode pageControl_X;
@property (nonatomic) PageControlMode pageControl_Y;

@end
static NSString* JLCycScrollDefaultCellResign = @"JLCycScrollDefaultCellResign";
static NSTimeInterval const animatedTime = 0.35;
@implementation JLCycleScrollerView
@synthesize pageControl = _pageControl;
#pragma mark ----初始化JLCycleScrollerView
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self initDefaultData];
        [self initUI];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initDefaultData];
        [self initUI];
    }
    return self;
}
-(void)initDefaultData
{
    _scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _timeDuration = 2.5;
    _pageControl_botton = 10.f;
    _pageControl_centerX = 0.f;
    _cellsOfLine = 1.0 ;
    _timerNeed = YES;
    _infiniteDragging = YES;
    _infiniteDraggingForSinglePage = NO;
    _scrollEnabled = YES;
    _pageControlNeed = YES;
    _pagingEnabled = YES;
    _curryPage = 0;
    self.arrayData = [NSArray array];
    self.titlesarrayData = [NSArray array];
    self.pageControl_X = PageControlModeCenterX;
    self.pageControl_Y = PageControlModeBottom;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive)
                                                 name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive)
                                                 name:UIApplicationDidBecomeActiveNotification object:nil];
}
#pragma mark  - reloadData
-(void)reloadDataAtItem:(CGFloat)item
{
    [self deallocTimerIfNeed];
    if (self.pageControlNeed) {
        self.pageControl.numberOfPages = self.arrayData.count;
        [self updataPageControlFrame];
    }
    if ([self canInfiniteDrag] && item<=1.0) {
        [self scrollToItemAtIndex:1.0 animated:NO];
    }else{
        [self scrollToItemAtIndex:item animated:NO];
    }
    [self.collectionView reloadData];
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.timerNeed&&self.superview) {
            [self setupTimer];
        }
    });
}
-(NSArray *)sourceArray
{
    return [NSArray arrayWithArray:self.arrayData];
}
-(void)setSourceArray:(NSArray *)sourceArray
{
    [self deallocTimerIfNeed];
    if (self.arrayData.count>0) {
        BOOL samemMemoryddress = [sourceArray isEqualToArray:self.arrayData];
        CGFloat scrollAtItem = 0.0;
        if (samemMemoryddress) {
            CGFloat item = self.pagingEnabled?[self getCurryPageInteger]:[self getCurryPageFloat];
            scrollAtItem = item;
        }
        self.arrayData = [NSArray arrayWithArray:sourceArray];
        [self reloadDataAtItem:scrollAtItem];
    }else{
        self.arrayData = [NSArray arrayWithArray:sourceArray];
        [self reloadDataAtItem:0.0];
    }
}
- (NSArray *)titlessourceArray{
    return [NSArray arrayWithArray:self.titlesarrayData];
}
-(void)setTitlessourceArray:(NSArray *)titlessourceArray{
    self.titlesarrayData = [NSArray arrayWithArray:titlessourceArray];
//    [self reloadDataAtItem:0.0];
}

#pragma mark - ------UI-------
-(void)initUI
{
    [self addSubview:self.collectionView];
    if (@available(iOS 11.0, *)) {
        self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
}
-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.sectionInset =  UIEdgeInsetsZero;
        flowLayout.scrollDirection = self.scrollDirection;
        _flowLayout = flowLayout;
        
        UICollectionView*collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        collectionView.pagingEnabled = self.pagingEnabled;
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.showsVerticalScrollIndicator = NO;
        collectionView.scrollsToTop = NO;
        collectionView.backgroundColor = [UIColor lightGrayColor];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        _collectionView = collectionView;
        [self.collectionView registerClass:[JLCycScrollDefaultCell class] forCellWithReuseIdentifier:JLCycScrollDefaultCellResign];
    }
    return _collectionView;
}
-(void)setCustomCell:(UICollectionViewCell<JLCycSrollCellDataProtocol> *)cell isXibBuild:(BOOL)isxib
{
    if (![cell isKindOfClass:[UICollectionViewCell class]]) {
        NSLog(@"\n---------error:UICollectionViewCell----------\n");
        return;
    }
    NSString* cellName =  NSStringFromClass(cell.class);
    self.reuseIdentifier = [NSString stringWithFormat:@"%@Resign",cellName];
    if (isxib) {
        [self.collectionView registerNib:[UINib nibWithNibName:cellName bundle:nil] forCellWithReuseIdentifier:self.reuseIdentifier];
    }else{
        [self.collectionView registerClass:cell.class forCellWithReuseIdentifier:self.reuseIdentifier];
    }
    
    if (self.arrayData.count>0) {
        [self reloadDataAtItem:0.0];
    }
}
-(void)setPageControl:(JLPageControl *)pageControl
{
    if (!pageControl) {
        self.pageControlNeed = NO;
    }
    if ([pageControl isKindOfClass:[UIPageControl class]]) {
        if (_pageControl) {
            [_pageControl removeFromSuperview];
            _pageControl = nil;
        }
        _pageControl = pageControl;
        if (_pageControl&&!_pageControl.superview) {
            [self addSubview:_pageControl];
        }
    }
}
-(JLPageControl *)pageControl
{
    if (!_pageControl && _pageControlNeed) {
        JLPageControl* pageControl = [[JLPageControl alloc] init];
        pageControl.hidesForSinglePage = YES;
        pageControl.pageIndicatorTintColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.3];
        pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        self.pageControl = pageControl;
    }
    return _pageControl;
}
-(void)updataPageControlFrame
{
    switch (self.pageControl_X) {
        case 1:
            self.pageControl_left = _pageControl_left;
            break;
        case 2:
            self.pageControl_right = _pageControl_right;
            break;
        default:
            self.pageControl_centerX = _pageControl_centerX;
            break;
    }
    switch (self.pageControl_Y) {
        case 3:
            self.pageControl_top = _pageControl_top;
            break;
        case 5:
            self.pageControl_centerY = _pageControl_centerY;
            break;
        default:
            self.pageControl_botton = _pageControl_botton;
            break;
    }
}
#pragma mark - -----pageControl设置------
-(void)setPageControlNeed:(BOOL)pageControlNeed
{
    _pageControlNeed = pageControlNeed;
    if (!_pageControlNeed) {
        [_pageControl removeFromSuperview];
        _pageControl = nil;
    }else{
        [self addSubview:self.pageControl];
    }
}
-(void)setPageControl_top:(CGFloat)pageControl_top
{
    _pageControl_top = pageControl_top;
    _pageControl_Y = PageControlModeTop;
    _pageControl.jl_y = _pageControl_top;
}
-(void)setPageControl_botton:(CGFloat)pageControl_botton
{
    _pageControl_botton = pageControl_botton;
    _pageControl_Y = PageControlModeBottom;
    _pageControl.jl_y = self.jl_height-_pageControl.jl_height-_pageControl_botton;
}
-(void)setPageControl_left:(CGFloat)pageControl_left
{
    _pageControl_left = pageControl_left;
    _pageControl_X = PageControlModeLeft;
    _pageControl.jl_width = [_pageControl sizeForNumberOfPages:self.arrayData.count].width;
    _pageControl.jl_x = _pageControl_left;
}
-(void)setPageControl_right:(CGFloat)pageControl_right
{
    _pageControl_right = pageControl_right;
    _pageControl_X = PageControlModeRight;
    _pageControl.jl_width = [_pageControl sizeForNumberOfPages:self.arrayData.count].width;
    _pageControl.jl_x = self.jl_width-_pageControl.jl_width-_pageControl_right;
}
-(void)setPageControl_centerX:(CGFloat)pageControl_centerX
{
    _pageControl_centerX = pageControl_centerX;
    _pageControl_X = PageControlModeCenterX;
    self.pageControl.jl_centerX = self.jl_width/2.f+pageControl_centerX;
}
-(void)setPageControl_centerY:(CGFloat)pageControl_centerY
{
    _pageControl_centerY = pageControl_centerY;
    _pageControl_Y = PageControlModeCenterY;
    self.pageControl.jl_centerY = self.jl_height/2.f+pageControl_centerY;
}
#pragma park mark - ----CollectionView设置----
-(void)setPlaceholderImage:(UIImage *)placeholderImage
{
    if (placeholderImage) {
        if (!self.collectionView.backgroundView) {
            UIImageView  *placeholderIMV = [[UIImageView alloc] init];
            self.collectionView.backgroundView = placeholderIMV;
        }
        if ([self.collectionView.backgroundView respondsToSelector:@selector(image)]) {
            [self.collectionView.backgroundView setValue:placeholderImage forKey:@"image"];
        }
    }else{
        self.collectionView.backgroundView = nil;
    }
    _placeholderImage = placeholderImage;
}
-(void)setScrollEnabled:(BOOL)scrollEnabled
{
    _scrollEnabled = scrollEnabled;
    self.collectionView.scrollEnabled = scrollEnabled;
}
-(void)setScrollDirection:(UICollectionViewScrollDirection)scrollDirection
{
    _scrollDirection = scrollDirection;
    self.flowLayout.scrollDirection = scrollDirection;
}
-(void)setInfiniteDragging:(BOOL)infiniteDragging
{
    BOOL changed =_infiniteDragging==infiniteDragging?NO:YES;
    NSInteger lastItem = [self getCurryPageInteger];
    BOOL last = [self dataIsUnavailable];
    _infiniteDragging = infiniteDragging;
    BOOL curry = [self dataIsUnavailable];
    if (changed) {
        if (_infiniteDragging) {
            if (!curry) {
                lastItem++;
            }
        }else{
            if (!last) {
                lastItem--;
            }
        }
    }
    [self reloadDataAtItem:lastItem];
}
-(void)setPagingEnabled:(BOOL)pagingEnabled
{
    _pagingEnabled = pagingEnabled;
    if (_pagingEnabled && self.cellsOfLine > 1.0) {
        self.collectionView.pagingEnabled = NO;
    }else{
        self.collectionView.pagingEnabled = _pagingEnabled;
    }
}
-(void)setCellsOfLine:(CGFloat)cellsOfLine
{
    BOOL last = [self dataIsUnavailable];
    NSInteger lastItem = [self getCurryPageInteger];
    _cellsOfLine = cellsOfLine>0.0?cellsOfLine:1.0;
    BOOL curry = [self dataIsUnavailable];
    if (last!=curry) {
        if (last) {
            lastItem++;
        }else{
            lastItem--;
        }
    }
    [self reloadDataAtItem:lastItem];
    if (self.pagingEnabled && _cellsOfLine > 1.0) {
        self.collectionView.pagingEnabled = NO;
    }else{
        self.collectionView.pagingEnabled = self.pagingEnabled;
    }
}
#pragma mark - -----UICollectionView Delegate------
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self getNumberOfItemsInSection];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.reuseIdentifier) {
        UICollectionViewCell<JLCycSrollCellDataProtocol> *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.reuseIdentifier forIndexPath:indexPath];
        if (![cell conformsToProtocol:@protocol(JLCycSrollCellDataProtocol)]) {
            return cell;
        }else{
            NSInteger index = [self indexWithIndexPathRow:indexPath.row];
            [cell setJLCycSrollCellData:self.arrayData[index] titlesData:self.titlesarrayData[index]];
            return cell;
        }
    }else{
        JLCycScrollDefaultCell* defaultCell = [collectionView dequeueReusableCellWithReuseIdentifier:JLCycScrollDefaultCellResign forIndexPath:indexPath];
        NSInteger index = [self indexWithIndexPathRow:indexPath.row];
        if (self.datasource && [self.datasource respondsToSelector:@selector(jl_cycleScrollerView:defaultCell:cellForItemAtIndex:sourceArray:)]) {
            id data = [self.datasource jl_cycleScrollerView:self defaultCell:defaultCell cellForItemAtIndex:index sourceArray:self.arrayData];
            [defaultCell setJLCycSrollCellData:data titlesData:self.titlessourceArray[index]];
        }else{
//            if (self.titlessourceArray.count>0) {
                [defaultCell setJLCycSrollCellData:self.arrayData[index] titlesData:self.titlesarrayData[index]];
            

//            }
           
        }
        return defaultCell;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake([self getCellWidth], [self getCellHeight]);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(jl_cycleScrollerView:didSelectItemAtIndex:sourceArray:)]) {
        NSInteger index = [self indexWithIndexPathRow:indexPath.row];
        [self.delegate jl_cycleScrollerView:self didSelectItemAtIndex:index sourceArray:self.arrayData];
    }
}
-(BOOL)dataIsUnavailable
{
    NSInteger lineCells = ceilf(self.cellsOfLine);
    if (self.arrayData.count<lineCells)
    {
        return YES;
    }
    else if (self.arrayData.count==lineCells)
    {
        return !self.infiniteDraggingForSinglePage;
    }
    return NO;
}
-(BOOL)canInfiniteDrag
{
    return self.infiniteDragging&&![self dataIsUnavailable]?YES:NO;
}
-(NSInteger)getNumberOfItemsInSection
{
    if ([self canInfiniteDrag]) {
        return 1+self.arrayData.count+ceilf(self.cellsOfLine);
    }else{
        return self.arrayData.count;
    }
}
-(NSInteger )indexWithIndexPathRow:(NSInteger)row
{
    if ([self canInfiniteDrag]) {
        if (row == 0) {
            return self.arrayData.count-1;
        }else{
            NSInteger item = (row-1)%self.arrayData.count;
            return item;
        }
    }else{
        return row;
    }
}
-(CGFloat)getCellWidth
{
    if (self.flowLayout.scrollDirection == UICollectionViewScrollDirectionVertical) {
        return self.collectionView.jl_width;
    }else{
        return ceilf(self.collectionView.jl_width/self.cellsOfLine);
    }
}
-(CGFloat)getCellHeight
{
    if (self.flowLayout.scrollDirection == UICollectionViewScrollDirectionVertical) {
        return ceilf(self.collectionView.jl_height/self.cellsOfLine);
    }else{
        return self.collectionView.jl_height;
    }
}
#pragma mark - -----UIScrollView Delegate------
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger page = [self getCurryPageInteger];
    if ([self canInfiniteDrag]) {
        if (page == 0) {
            if (self.pageControlNeed) {
                if (self.pageControl.currentPage != self.arrayData.count-1) {
                    self.pageControl.currentPage = self.arrayData.count-1;
                }
            }
            _curryPage = self.arrayData.count-1;
        }else{
            NSInteger curryPage = (page-1)%self.arrayData.count;
            if (self.pageControlNeed) {
                if (self.pageControl.currentPage != curryPage) {
                    self.pageControl.currentPage = curryPage;
                }
            }
            _curryPage = curryPage;
        }
    }else{
        if (self.pageControlNeed) {
            if (self.pageControl.currentPage != page) {
                self.pageControl.currentPage = page;
            }
        }
        _curryPage = page;
    }

    [self draggingSwitchTheForeAndAft];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self pauseTimer];
}
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if (self.pagingEnabled && self.cellsOfLine>1.0) {
        if (self.flowLayout.scrollDirection == UICollectionViewScrollDirectionVertical) {
            CGPoint targetContentOffsetCopy = CGPointMake(targetContentOffset->x, targetContentOffset->y);
            NSInteger page = roundf(targetContentOffsetCopy.y/self.collectionView.jl_height*self.cellsOfLine);
            CGFloat Y = [self getCellHeight]*page;
            *targetContentOffset = CGPointMake(targetContentOffsetCopy.x, Y);
        }else{
            CGPoint targetContentOffsetCopy = CGPointMake(targetContentOffset->x, targetContentOffset->y);
            CGFloat page = roundf(targetContentOffsetCopy.x/self.collectionView.jl_width*(CGFloat)self.cellsOfLine);
            CGFloat X = [self getCellWidth]*page;
            *targetContentOffset = CGPointMake(X, targetContentOffsetCopy.y);
        }
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {
        [self resumeTimerAfterDuration:_timeDuration];
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self resumeTimerAfterDuration:_timeDuration];
    if (self.infiniteDragging) {
        [self automaticSwitchTheForeAndAft];
    }
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if (self.infiniteDragging) {
        [self automaticSwitchTheForeAndAft];
    }
}
- (void)draggingSwitchTheForeAndAft
{
    if (self.collectionView.tracking && [self canInfiniteDrag]) {
        CGFloat pageFloat = [self getCurryPageFloat];
        if (pageFloat > self.arrayData.count+1.0) {
            [self scrollToItemAtIndex:1 animated:NO];
        }
        if (pageFloat < 0.0 ) {
            [self scrollToItemAtIndex:self.arrayData.count animated:NO];
        }
    }
}
-(void)automaticSwitchTheForeAndAft
{
    NSInteger page = [self getCurryPageInteger];
    if (page == self.arrayData.count+1 && ![self dataIsUnavailable]) {
        [self scrollToItemAtIndex:1 animated:NO];
    }
    if (page == 0 && ![self dataIsUnavailable]) {
        [self scrollToItemAtIndex:self.arrayData.count animated:NO];
    }
}
-(void)scrollToItemAtIndex:(CGFloat)item animated:(BOOL)animated
{
    if (item >=0 && item<[self getNumberOfItemsInSection]) {
        if (self.flowLayout.scrollDirection == UICollectionViewScrollDirectionVertical) {
            CGFloat offSet = [self getCellHeight]*item;
            [self.collectionView setContentOffset:CGPointMake(0, offSet) animated:animated];
        }else{
            CGFloat offSet = [self getCellWidth]*item;
            [self.collectionView setContentOffset:CGPointMake(offSet, 0) animated:animated];
        }
    }
}
-(NSInteger)getCurryPageInteger
{
    return roundf([self getCurryPageFloat]);
}
-(CGFloat)getCurryPageFloat
{
    if (self.flowLayout.scrollDirection == UICollectionViewScrollDirectionVertical) {
        CGFloat H = self.collectionView.jl_height;
        CGFloat page = self.collectionView.contentOffset.y /H*self.cellsOfLine;
        return page;
    }else{
        CGFloat W = self.collectionView.jl_width;
        CGFloat page = self.collectionView.contentOffset.x / W*self.cellsOfLine;
        return page;
    }
}
-(void)automaticScrollPage
{
    if ([self dataIsUnavailable])return;
    NSInteger page = [self getCurryPageInteger];
    if (self.infiniteDragging) {
        if (page<self.arrayData.count+1) {
            [self scrollToItemAtIndex:page+1 animated:YES];
        }
        if (page >= self.arrayData.count+1) {
            [self scrollToItemAtIndex:1 animated:NO];
        }
    }else{
        if (page<self.arrayData.count-1 ) {
            [self scrollToItemAtIndex:page+1 animated:YES];
        }
        if (page == self.arrayData.count-1) {
            [self scrollToItemAtIndex:0 animated:NO];
        }
    }
}
#pragma mark - -----NSTimer------
-(void)setTimerNeed:(BOOL)timerNeed
{
    _timerNeed = timerNeed;
    if (_timerNeed) {
        [self setupTimer];
    }else{
        [self deallocTimerIfNeed];
    }
}
- (void)setupTimer
{
    [self deallocTimerIfNeed];
    if ([self dataIsUnavailable])return;
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:self.timeDuration+animatedTime target:self selector:@selector(automaticScrollPage) userInfo:nil repeats:YES];
    _timer = timer;
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}
-(void)setTimeDuration:(NSTimeInterval)timeDuration
{
    _timeDuration = timeDuration>0.0?timeDuration:0.0;
    if (self.timerNeed&&self.superview) {
        [self setupTimer];
    }
}
-(void)pauseTimer
{
    if(self.timer&&[self.timer isValid]){
        [self.timer setFireDate:[NSDate distantFuture]];
    }
}
-(void)resumeTimerAfterDuration:(NSTimeInterval)duration
{
    if(self.timer&&[self.timer isValid]){
        [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:duration]];
    }
}
-(void)deallocTimerIfNeed
{
    if (self.timer) {
        if (self.timer.isValid) {
            [_timer invalidate];
        }
        _timer=nil;
    }
}
#pragma mark - layoutSubviews
-(void)layoutSubviews
{
    [super layoutSubviews];
    if (self.pageControlNeed) {
        self.pageControl.numberOfPages = self.arrayData.count;//need
        [self updataPageControlFrame];
    }
    if (!CGRectEqualToRect(self.bounds, self.collectionView.frame)) {
        CGFloat item = self.pagingEnabled?[self getCurryPageInteger]:[self getCurryPageFloat];
        [self.collectionView reloadData];
        self.collectionView.frame = self.bounds;
        if ([self canInfiniteDrag] && item<=1.0) {
            [self scrollToItemAtIndex:1.0 animated:NO];
        }else{
            [self scrollToItemAtIndex:item animated:NO];
        }
    }
}
- (void)willMoveToWindow:(UIWindow *)newWindow
{
    [super willMoveToWindow:newWindow];
    if (!newWindow) {
        [self deallocTimerIfNeed];
    }
}
-(void)didMoveToWindow
{
    [super didMoveToWindow];
    if (self.window) {
        if (self.timerNeed) {
            [self setupTimer];
        }
    }else{
        if (self.arrayData.count>0) {
            if (self.pagingEnabled) {
                CGFloat item = [self getCurryPageInteger];
                [self scrollToItemAtIndex:item animated:NO];
            }
        }
    }
}
-(void)applicationWillResignActive
{
    [self deallocTimerIfNeed];
}
-(void)applicationDidBecomeActive
{
    if (self.timerNeed&&self.window) {
        [self setupTimer];
    }
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    self.collectionView.dataSource = nil;
    self.collectionView.delegate = nil;
    NSLog(@"JLCycleScrollerView");
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end

