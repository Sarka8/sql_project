# SQL Project

This project is my **final output** of Data Academy at Engeto.

## Introduction

In our analytical department of an independent company that deals with the standard of living of citizens, we have agreed to try to answer a few defined research questions that address the availability of basic foodstuffs to the general public. Our colleagues have already defined the basic questions they will try to answer and provide this information to the press department. This department will present the results at the next conference focused on this area.

I have prepared robust data that shows a comparison of food availability based on average incomes over a certain period of time.

As additional material, I have also prepared a table with GDP, GINI coefficient, and population of other European countries in the same period as a primary overview for the Czech Republic.

## Outputs of the project

The output is two tables in the database from which the required data can be obtained. The tables are named: t_Sarka_Praxova_project_SQL_primary_final (for wage and food price data for the Czech Republic aggregated to the same comparable period - common years) and t_Sarka_Praxova_project_SQL_secondary_final (for additional data on other European countries).

Furthermore, I prepared a set of SQL that extracts the data from the prepared tables to answer the set research questions.

In the repository, all information about the project is stored - the SQL script generating the result table, the description of intermediate results (accompanying list) in markdown (.md) format and information about the output data (for example, where missing values are, etc.).

##  Research questions
1. Have wages been rising over the years in all sectors, or have they been falling in some sectors?
2. How many litres of milk and kilograms of bread can be bought in the first and last comparable periods in the available price and wage data?
3. Which category of food is becoming more expensive at the slowest rate (has the lowest annual percentage increase)?
4. Is there a year in which the annual increase in food prices was significantly higher than the increase in wages (greater than 10%)?
5. Does the level of GDP affect changes in wages and food prices? Or, if GDP rises more significantly in one year, does this translate into a more significant rise in food prices or wages in the same or subsequent year?

Answers to the research questions can be found in the file [Pruvodni listina.md]()
