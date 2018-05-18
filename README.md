# DelayTools
A Maple package for the analysis of delay equations

## Description

This package is a collection of various Maple procedures that I have found useful for the symbolic analysis of delayed dynamical systems. It could also be used for code generation for third party numerical software.

Initially, the focus will be on local stability and bifurcation in so-called classical *delay differential equations*, but the package structure is such that it can be extended rather easily to cover additional types of delay equations such as purely functional (renewal) equations and mixed systems.

## Installation
1. Use Maple to open, edit (if necessary) and run the `build.mpl` file contained in the repository root.
1. Make sure your [initialization file](https://www.maplesoft.com/support/help/maple/view.aspx?path=worksheet/reference/initialization) is correct.
1. Exit, restart and test by entering `with(DelayTools)` at the prompt.

Please let me know if you encounter difficulties.

To uninstall, remove `DelayTools.mla` from the directory `destdir` as defined in `build.mpl`.

## Usage
Documentation and examples will be made available [on my site about delay equations](http://delayequations.net).

## Citation
For academic use you are kindly requested to cite:

S.G. Janssens, *On a Normalization Technique for Codimension Two Bifurcations of Equilibria of Delay Differential Equations*, Master Thesis, Utrecht University, 2010, updates and corrections via http://delayequations.net.

## License
This project uses the BSD 3-Clause License. The license text can be found in the file LICENSE in the repository root directory. 
