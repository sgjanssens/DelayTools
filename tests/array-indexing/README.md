# Indexing and storage of higher dimensional symmetric Arrays in Maple

(Use a MathJax-enabling plugin such as [this one](https://github.com/emichael/texthings) for formula rendering.)

## Description

Derivatives beyond second order are typically not required when solving local stability and optimization problems. However, local normal forms for ordinary differential equations *do* involve higher order derivatives. For instance, already the computation of the first Lyapunov coefficient in the ubiquitous [Hopf bifurcation](http://www.scholarpedia.org/article/Andronov-Hopf_bifurcation) requires derivatives of order three.

For definiteness, let $d, r \in \mathbb{N}$ and consider a function $f : \mathbb{R}^d \to \mathbb{R}$. If $f$ is $r$ times continuously differentiable, then its partial derivatives commute and the $r$th order (total) derivative of $f$ may be efficiently stored in a symmetric $r$-dimensional Array. This requires memory for
$$
{r + d - 1 \choose r}
$$
entries, which is the number of ways to select $r$ items from $d$ items, without order but with replacement. (In other words, it is the number of multisets of size $r$ on $d$ symbols.) In contrast, standard rectangular storage requires memory for $d^r$ entries.

In the case of delay differential equations with discrete delays, $d = n \times (m + 1)$ where $n$ is the number of scalar equations appearing in the system and $m$ is the number of strictly positive delays. 

### Problem and solution
In Maple, I would be inclined to declare a higher dimensional symmetric Array as, for example,
```
d := 10: r := 5
Array(symmetric, (1..d)$r);
```
but at present this does not work, see [this thread](https://mapleprimes.com/questions/225188-Indexing-And-Storage-Of-Higher-Dimensional) on MaplePrimes. I thank the respondents - and [vv](https://mapleprimes.com/users/vv/) in particular - for suggesting to use sparse storage instead of symmetric storage. In this directory you find my rudimentary implementation and some test results.

## Installation and usage
Assuming you run Maple in this directory, read the procedures into the current session
```
read "array-indexing.mpl";
```
and compare standard rectangular indexing and storage with custom symmetric indexing and sparse storage by running
```
read "tests.mpl";
```
Adapt `tests.mpl` to try out different examples.

