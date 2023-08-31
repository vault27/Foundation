# Math

Most mathematical activity involves the discovery of properties of abstract objects and the use of pure reason to prove them.

- Number theory
- Algebra - branch of elementary mathematics which is concerned with relation of  variables and constants
    - The origin of algebra was traced by Babylonians in 1900BC
    - The Persian mathematician Al-Khwarizmi is referred as the ‘father of algebra’
    - Branch of mathematics in which arithmetical operations and formal manipulations are applied to abstract symbols rather than specific numbers.
- Geometry
- Analysis
- Arithmetic - elementary part of mathematics that consists of the study of the properties of the traditional operations on numbers—addition, subtraction, multiplication, division, exponentiation, and extraction of roots

## History

- Ancient Greek μάθημα (mathema), meaning "subject of instruction"
- Greek mathematics, most notably in Euclid's Elements: 300 B.C

## Terms

- Quatient - a result obtained by dividing one quantity by another - the answer to the division problem
- Dividend - a number beeing devided on pieces
- Divisor - the number by which the dividend is devided
- Number
- Numeral - So the number is an idea, the numeral is how we write it
- Digit

## Numeral systems

- A numeral system is a writing system for expressing numbers; that is, a mathematical notation for representing numbers of a given set, using digits or other symbols in a consistent manner
- The same sequence of symbols may represent different numbers in different numeral systems
- The number the numeral represents is called its value
- Not all number systems can represent the same set of numbers; for example, Roman numerals cannot represent the number zero
- Ideally, a numeral system will:
        - Represent a useful set of numbers (e.g. all integers, or rational numbers)
        - Give every number represented a unique representation (or at least a standard representation)
        - Reflect the algebraic and arithmetic structure of the numbers.
- Numeral systems are sometimes called number systems, but that name is ambiguous
- The Babylonian numeral system, base 60, was the first positional system to be developed, and its influence is present today in the way time and angles are counted in tallies related to 60, such as 60 minutes in an hour and 360 degrees in a circle
- All known numeral systems developed before the Babylonian numerals are non-positional, as are many developed later, such as the Roman numerals

### Sign-value notation

- A sign-value notation represents numbers using a sequence of numerals which each represent a distinct quantity, regardless of their position in the sequence
- Example: Roman numeral system
- Sign-value notation was the ancient way of writing numbers and only gradually evolved into place-value notation, also known as positional notation. Sign-value notations have been used across the world by a variety of cultures throughout history

### Positional numeral systems - place-value notation

- Number consists of digits, the value of number is calculated based on base, position and digit
- Place-value notation, or positional numeral system
- A positional system is a numeral system in which the contribution of a digit to the value of a number is the value of the digit multiplied by a factor determined by the position of the digit
- In early numeral systems, such as Roman numerals, a digit has only one value: I means one, X means ten and C a hundred
- The position of the digit means that its value must be multiplied by some value
- The use of a radix point (decimal point in base ten), extends to include fractions and allows representing any real number with arbitrary accuracy
- With positional notation, arithmetical computations are much simpler than with any older numeral system; this led to the rapid spread of the notation when it was introduced in western Europe
- For example, for the decimal system the radix (and base) is ten, because it uses the ten digits from 0 through 9. When a number "hits" 9, the next number will not be another different symbol
- A digit is a symbol that is used for positional notation
- Radix is a Latin word for "root". Root can be considered a synonym for base, in the arithmetical sense
- Place values are the number of the base raised to the nth power, where n is the number of other digits between a given digit and the radix point
- If a given digit is on the left hand side of the radix point (i.e. its value is an integer) then n is positive or zero
- If the digit is on the right hand side of the radix point (i.e., its value is fractional) then n is negative

Universal formula to understand the value of a number in any positional system - you will get a result in decimal form:  
We have a number from 4 digits: d1d2d3d4.c1c2  
To inderstand its value:  

```
 d1*b^n + d2*b^n-1 + d3*b^n-2 + d4*b^n-3 + c1*b^-1 + c2*b^-2
```

n - amount of digits after d1  
b - base  
  
4321,32

```
4*10^3 + 3*10^2 + 2*10^1 + 1*10^0 + 3*10^-1 + 2*10^-2 = 4000 + 300 + 20 + 1 + 0,3 + 0,02  
```
  
1100 - this is how we convert binary to decimal

```
1*2^3 + 1*2^2 = 8 + 4 = 12
```

#### Decimal numeral system

- Base - 10 - digits - 0 - 9
- Every number is a sequence of digits
- Decimals are the numbers, which consist of two parts namely, a whole number part and a fractional part separated by a decimal point or radix
- The two different types of decimals are:
    - Terminating decimals (or) Non-recurring decimals
    - Non-terminating decimals (or) Recurring decimals

#### Decimal to binary conversion

Conversion steps:

- Divide the number by 2.
- Get the integer quotient for the next iteration.
- Get the remainder for the binary digit.
- Repeat the steps until the quotient is equal to 0.

``` 
Division Quotient Remainder Bit #
by 2                (Digit)		

(192)/2	    96	    0	    0
(96)/2	    48	    0	    1
(48)/2	    24	    0	    2
(24)/2	    12	    0	    3
(12)/2	    6	    0	    4
(6)/2	    3	    0	    5
(3)/2	    1	    1	    6
(1)/2	    0	    1	    7

= (11000000)2

```

## Number types

- Real
- Natural - the non-negative integers {0, 1, 2, 3, ...}. Natural numbers including 0 are also sometimes called whole numbers
- Rational -  number that can be expressed as the quotient or fraction p/q of two integers, a numerator p and a non-zero denominator. For example, -3/7 is a rational number, as is every integer (e.g., 5 = 5/1)
- Integer - Positive and negative counting numbers, as well as zero: {..., −3, −2, −1, 0, 1, 2, 3, ...}
    - Even and odd
    - Prime - A positive integer with exactly two positive divisors: itself and 1. The primes form an infinite sequence 2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, ...

## Division

- Long devision
- 8/4=2: 8 - dividend, 4 - divisor, 2 - quotient