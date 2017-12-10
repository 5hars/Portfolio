##Each dataset is composed of two columns: `Date` and `Revenue`. (Thankfully, your company has rather lax standards for accounting so the records are simple.)

#create a Python script that analyzes the records to calc the following:

#* The total number of months included in the dataset

#* The total amount of revenue gained over the entire period

#* The average change in revenue between months over the entire period

#* The greatest increase in revenue (date and amount) over the entire period

#* The greatest decrease in revenue (date and amount) over the entire period

# As an example, your analysis should look similar to the one below:


# Financial Analysis
# ----------------------------
#Total Months: 25
#Total Revenue: $1241412
#Average Revenue Change: $216825
#Greatest Increase in Revenue: Sep-16 ($815531)
#Greatest Decrease in Revenue: Aug-12 ($-652794)

#final script should both print the analysis to the terminal and export a text file with the results.

import os
import csv

csvpath = os.path.join("..", "budget_data_1.csv")
csvpath = os.path.join("..", "budget_data_2.csv")

#open and read csv file
with open(csvpath, newline="") as csvfile:
    csvreader = csv.reader(csvfile, delimiter=",")


output_file = os.path.join("financial_analysis.csv")

#  Open the output file
with open(output_file, "w", newline="") as datafile:
    writer = csv.writer(datafile)

writer.writerow(["Total Months: ", "Total Revenue: ", "Average Revenue Change: ", "Greatest Increase in Revenue: ", "Greatest Decrease in Revenue: " ])











