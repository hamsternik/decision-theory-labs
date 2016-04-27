# Decision Theory Assignments

[![License](http://img.shields.io/:license-mit-blue.svg)](LICENSE)

## Description 

### Dynamic Programming 

In any programming language create a program which provides a general solution for the next task:

1. Create a table 5x5, which cells are filling by random numbers with minues and plus both. From the start numbers in cells randomly change. 
2. Every positive number means a prize, and every negative number - defeat, which obtained during moving around that cell.
3. According to DP method, determine an optimal route from left bottom cell to right top cell, wherein the numbe's sum will be maximized.
4. Transition from one cell to another is allowed in three directions: right, up or diagonally up-right.

Assignment project: ([lab-7](lab-7))

### Experimental evaluation of the probability of selecting the best solution for optimal stoping rule

In any programming language create a program which provides a general solution for the next task:

1. Generate N random numbers *x_i*, i = [1..N], in the range: 160-190 (growth potential suitors).
2. Determined maximum number from generated as *x_max*.
3. All generated numbers in a random order fill an array eg. *X*.
4. Determined value *x0*, which exceeds all previous numbers and have a *j*-th position in this array accroding to the
   optimal stoping rule

   `
   (1): j = η ⋅ [N / exp] + 1
   `

   where η[z] means integer part on *z* number, and exp is a *2,71828*. So, we choose a challenger which has a maximum
   height from previous.

5. If *x0* value (height of checked challenger) doesn't exceed previous values, choose first from next values in array,
   which not exceed all previous values.
6. Victory is a case when *x0* value is not more than the value of *d*, *d >= 0*, that differs from *x_max* (best from
   all challengers). So, victory has occured when 

   `
   (2): x_max - x0 <= d
   `

   *d>= 0* - given bound against highest challenger heigth deviation from whole array of *N* candidates.
7. For every constant value *N* and *D* carried out *M* series of experiments by 1-6 points ans calculated the
   probability of victory by formula:

   `
   (3): p = m / M
   `

   where *m* - number of wins in series within condition from formula #2.

8. Application have to access to input values in interactive mode.

*N* = 100, 200, 300, ..., 1000;
*M* = 10, 100, 1000;
*d* = 0,1,2,3,4

and for every from valeus above calculated the probability *p* by formula #3.

## Copyright

Copyright (c) 2016 Nikita Khomitsevich

This project is distributed under the [MIT license](LICENSE). 

