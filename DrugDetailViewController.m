//
//  DrugDetailViewController.m
//  FinalProject
//
//  Created by Xun on 12/17/16.
//  Copyright © 2016 Xun. All rights reserved.
//

#import "DrugDetailViewController.h"

@interface DrugDetailViewController ()

@end

@implementation DrugDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.drugName.text = self.drug.name;
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSString *newDateString = [outputFormatter stringFromDate:self.drug.date];
    self.drugDate.text = newDateString;
    self.drugImage.image = self.drug.image;
    self.drugPrice.text = self.drug.price;
    self.drugQuantity.text = self.drug.quantity;
    self.drugDescription.text = self.drug.drugdescription;
    self.drugDoctor.text = self.drug.doctor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
