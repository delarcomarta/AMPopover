//
//  PremiumContainerPageViewController.m
//
//  AMPopover is available under the MIT license.
//
//  Copyright © 2016 Marta del Arco
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included
//in all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
//INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
//PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
//OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
//SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import "PremiumContainerPageViewController.h"

@interface PremiumContainerPageViewController ()

@end

@implementation PremiumContainerPageViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.delegate = self;
    self.dataSource = self;
    
    UIViewController *p1 = [self.storyboard
                            instantiateViewControllerWithIdentifier:@"Intro1ID"];
    UIViewController *p2 = [self.storyboard
                            instantiateViewControllerWithIdentifier:@"Intro2ID"];
    
    myViewControllers = @[p1,p2];
    
    [self setViewControllers:@[p1]
                   direction:UIPageViewControllerNavigationDirectionForward
                    animated:NO completion:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    myTimer = [NSTimer scheduledTimerWithTimeInterval:6.0
                                               target:self
                                             selector:@selector(findPageControl)
                                             userInfo:nil
                                              repeats:YES];
}
-(void)viewWillDisappear:(BOOL)animated{
    NSLog(@"%s",__FUNCTION__);
    [myTimer invalidate];
    myTimer = nil;
    
    
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (void) findPageControl {
    NSLog(@"Change pager");
    NSUInteger currentIndex = currentPageIndex;
    
    ++currentIndex;
    currentIndex = currentIndex % (myViewControllers.count);
    
    currentPageIndex=currentIndex;
    
    [self setViewControllers:@[[myViewControllers objectAtIndex:currentIndex]]
                   direction:UIPageViewControllerNavigationDirectionForward
                    animated:YES completion:nil];
    // [self performSelector:@selector(findPageControl) withObject:nil afterDelay:6.0f];
}

-(UIViewController *)viewControllerAtIndex:(NSUInteger)index{
    return myViewControllers[index];
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController
     viewControllerBeforeViewController:(UIViewController *)viewController{
    NSUInteger currentIndex = [myViewControllers indexOfObject:viewController];
    
    --currentIndex;
    currentIndex = currentIndex % (myViewControllers.count);
    currentPageIndex=currentIndex;
    return [myViewControllers objectAtIndex:currentIndex];
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController
      viewControllerAfterViewController:(UIViewController *)viewController{
    NSUInteger currentIndex = [myViewControllers indexOfObject:viewController];
    
    ++currentIndex;
    currentIndex = currentIndex % (myViewControllers.count);
    currentPageIndex=currentIndex;
    return [myViewControllers objectAtIndex:currentIndex];
}

-(NSInteger)presentationCountForPageViewController:
(UIPageViewController *)pageViewController{
    return myViewControllers.count;
}

-(NSInteger)presentationIndexForPageViewController:
(UIPageViewController *)pageViewController{
    return currentPageIndex;
}


@end
