//
//  ViewController.m
//  DailyExpense
//
//  Created by Macbook on 03/08/2019.
//  Copyright © 2019 TP. All rights reserved.
//

#import "ViewController.h"
#import "DEData.h"
#import "cell1.h"
#import "monthCell.h"
#import "AddIncomeVC.h"
#import "AddExpenseVC.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray * income;
    NSMutableArray * expense;
    NSMutableArray * month;
    
    int Hcount;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    Hcount = 0;
    
    _incomeTable.delegate = self;
    _expenseTable.delegate = self;
    _monthlyTable.delegate = self;
    
    _incomeTable.dataSource = self;
    _expenseTable.dataSource = self;
    _monthlyTable.dataSource = self;
    
    self.navigationController.navigationBar.hidden = true;
    
    
    
   
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
    _dailyView.hidden = false;
    _monthlyView.hidden = true;
    
    [_dailyButton setBackgroundColor: [UIColor colorWithRed:68.0/255.0 green:58.0/255.0 blue:202.0/255.0 alpha:1.0]];
    
    [_monthlyButton setBackgroundColor: [UIColor colorWithRed:88.0/255.0 green:116.0/255.0 blue:244.0/255.0 alpha:1.0]];
    
    self.navigationController.navigationBar.hidden = true;
    
    
    int e = [DEData getTotalExpense];
    int i = [DEData getTotalIncome];

    
    _remainingAmount.text = [NSString stringWithFormat:@"Balance : %d",(i-e)];
    _totalIncome.text = [NSString stringWithFormat:@"%d",i];
    _totalExpense.text = [NSString stringWithFormat:@"%d",e];

    
    
    int e2 = [DEData getTotalExpense];
    int i2 = [DEData getTotalIncome];
    
    
    _remainingAmount.text = [NSString stringWithFormat:@"%d",(i2-e2)];
    _totalIncome.text = [NSString stringWithFormat:@"%d",i2];
    _totalExpense.text = [NSString stringWithFormat:@"%d",e2];
    
    income = [DEData getIncomeArray];
    [_incomeTable reloadData];
    
    expense = [DEData getExpenseArray];
    [_expenseTable reloadData];
    
    month = [DEData getMonthlyData];
    
    if (month.count > 0)
    {
        _nodata.hidden = true;
    }
    else
    {
         _nodata.hidden = false;
    }
    [_monthlyTable reloadData];
    
    
}


-(NSString*)getMonth:(NSInteger) m
{
    if (m == 0)
    {
        return @"December";
    }
    else if (m == 1)
    {
        return @"January";
    }
    else if (m == 2)
    {
        return @"Febraury";
    }
    else if (m == 3)
    {
        return @"March";
    }
    else if (m == 4)
    {
        return @"April";
    }
    else if (m == 5)
    {
        return @"May";
    }
    else if (m == 6)
    {
        return @"June";
    }
    else if (m == 7)
    {
        return @"July";
    }
    else if (m == 8)
    {
        return @"August";
    }
    else if (m == 9)
    {
        return @"September";
    }
    else if (m == 10)
    {
        return @"October";
    }
    else if (m == 11)
    {
        return @"November";
    }
    else
    {
        return @"December";
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _incomeTable)
    {
        return income.count;
    }
    else if (tableView == _expenseTable)
    {
        return expense.count;
    }
    else
    {
        return month.count;
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    
    if (tableView == _incomeTable)
    {
        cell1 * cell = [tableView dequeueReusableCellWithIdentifier:@"incomeCell"];
        
        cell.titleName.text = [[income objectAtIndex:indexPath.row] valueForKey:@"title"];
        cell.amountLabel.text = [[income objectAtIndex:indexPath.row] valueForKey:@"amount"];
        
        return cell;
        
    }
    else if (tableView == _expenseTable)
    {
        cell1 * cell = [tableView dequeueReusableCellWithIdentifier:@"expenseCell"];
        
        cell.titleName.text = [[expense objectAtIndex:indexPath.row] valueForKey:@"title"];
        cell.amountLabel.text = [[expense objectAtIndex:indexPath.row] valueForKey:@"amount"];
        
        return cell;
    }
    else
    {
        monthCell * cell = [tableView dequeueReusableCellWithIdentifier:@"monthCell"];
        
        cell.income.text = [[month objectAtIndex:indexPath.row] valueForKey:@"income"];
        cell.expense.text = [[month objectAtIndex:indexPath.row] valueForKey:@"expense"];
        cell.savings.text = [[month objectAtIndex:indexPath.row] valueForKey:@"savings"];
        
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _incomeTable)
    {
        return 60;
    }
    else if (tableView == _expenseTable)
    {
        return 60;
    }
    else
    {
        return 150;
    }
}



- (IBAction)dailyButtonTouchd:(id)sender
{
    _dailyView.hidden = false;
    _monthlyView.hidden = true;
    
    [_dailyButton setBackgroundColor: [UIColor colorWithRed:68.0/255.0 green:58.0/255.0 blue:202.0/255.0 alpha:1.0]];
    
    [_monthlyButton setBackgroundColor: [UIColor colorWithRed:88.0/255.0 green:116.0/255.0 blue:244.0/255.0 alpha:1.0]];
}

- (IBAction)monthlyButtonTouched:(id)sender
{
    _dailyView.hidden = true;
    _monthlyView.hidden = false;
    
    [_monthlyButton setBackgroundColor: [UIColor colorWithRed:68.0/255.0 green:58.0/255.0 blue:202.0/255.0 alpha:1.0]];
    
    [_dailyButton setBackgroundColor: [UIColor colorWithRed:88.0/255.0 green:116.0/255.0 blue:244.0/255.0 alpha:1.0]];
}

- (IBAction)addIncomeButtonTouched:(id)sender
{
    AddIncomeVC * v = [self.storyboard instantiateViewControllerWithIdentifier:@"AddIncomeVC"];
    
    [self.navigationController pushViewController:v animated:YES];
}

- (IBAction)addExpenseButtonTouched:(id)sender
{
    AddExpenseVC * v = [self.storyboard instantiateViewControllerWithIdentifier:@"AddExpenseVC"];
    
    [self.navigationController pushViewController:v animated:YES];
}
- (IBAction)addToHistory:(id)sender
{
    Hcount = Hcount + 1;
    
    int e = [DEData getTotalExpense];
    int i = [DEData getTotalIncome];
    
    [DEData addMonthlyData:[NSString stringWithFormat:@"%d",i] setExpense:[NSString stringWithFormat:@"%d",e] setmonth:[NSString stringWithFormat:@"History %d", Hcount] setsavings:[NSString stringWithFormat:@"%d",(i-e)]];
    
    [DEData removeDailyData];
    
    
    
    _remainingAmount.text = [NSString stringWithFormat:@"Balance : %d",(i-e)];
    _totalIncome.text = [NSString stringWithFormat:@"%d",i];
    _totalExpense.text = [NSString stringWithFormat:@"%d",e];
    
    
    
    int e2 = [DEData getTotalExpense];
    int i2 = [DEData getTotalIncome];
    
    
    _remainingAmount.text = [NSString stringWithFormat:@"%d",(i2-e2)];
    _totalIncome.text = [NSString stringWithFormat:@"%d",i2];
    _totalExpense.text = [NSString stringWithFormat:@"%d",e2];
    
    income = [DEData getIncomeArray];
    [_incomeTable reloadData];
    
    expense = [DEData getExpenseArray];
    [_expenseTable reloadData];
    
    month = [DEData getMonthlyData];
    
    if (month.count > 0)
    {
        _nodata.hidden = true;
    }
    else
    {
        _nodata.hidden = false;
    }
    [_monthlyTable reloadData];
}
@end
