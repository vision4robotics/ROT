# Region-Oriented UAV Tracking via Inter-Feature Response Mining

Matlab implementation of our region-oriented tracker (**ROT**). 

| **Test passed**                                              |
| ------------------------------------------------------------ |
| [![matlab-2019](https://img.shields.io/badge/matlab-2019-yellow.svg)](https://www.mathworks.com/products/matlab.html) |

## Quantitative results

<details open>   
    <summary><b>Overall performance on UAV123@10fps</b></summary> 
    <div align="center"> 
        <img src="./results/UAV123@10fps/error_OPE.png" width="400">
        <img src="./results/UAV123@10fps/overlap_OPE.png" width="400"> 
    </div>
</details>

<details close>   
    <summary><b>Overall performance on DTB70</b></summary> 
    <div align="center"> 
        <img src="./results/DTB70/error_OPE.png" width="400">
        <img src="./results/DTB70/overlap_OPE.png" width="400"> 
    </div>
</details>

<details close>   
    <summary><b>Overall performance on UAVDT</b></summary> 
    <div align="center"> 
        <img src="./results/UAVDT/error_OPE.png" width="400">
        <img src="./results/UAVDT/overlap_OPE.png" width="400"> 
    </div>
</details>

## Getting started

Run `demo_ROT.m` script to test the tracker.

## Acknowledgements

The feature extraction modules and some of the parameters are borrowed from the ECO tracker (https://github.com/martin-danelljan/ECO).
