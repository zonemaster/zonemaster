# Benchmark between Zonemaster and Zonecheck

## Scope
This document runs certain tests comparing Zonemaster and Zonecheck. The purpose is to establish areas where the tools need to improve, or align the results with each other. We hope that the tested tools will take this input and improve the code to make even better mature and standardized measurements.

## Comparison of the Command Line Interfaces

### Performance 

#### Performance On a big zone

Zone : ibm.com

Zonecheck took *12.585 seconds* whereas Zonemaster took *9.50 seconds*


#### Performance On a small zone 
Zone : motounit.fr

Zonecheck took *7.245 seconds* whereas Zonemaster took *5.16 seconds*

#### Conclusion 
The Zonemaster CLI is timewise much performant than Zonecheck

### Features
| Wishlist | Zonecheck | Zonemaster |
| :------- | :--------:| ---------: |
|Timestamp on the tests being run|Yes|Yes|
|Modules reporting tests as they are being run|No|Yes|
|Different levels of verbosity|Yes|Yes|
|Test undelegated domain|Yes|Yes|
|Specify secure delegation parameters|Yes|Yes|
|Possibility to specify what tests to run|Yes|Yes|
|Possibility to output results other than in text (e.g. HTML, XML) |Yes|No|
|Possibility to output results other than in text (e.g. HTML, XML) |Yes|No|
|Support for choice of language or locale|Yes|Yes|
|Possibility to output only a summary for the results|Yes|Yes|
|Output a list of the tests we can run|Yes|Yes|Yes|
