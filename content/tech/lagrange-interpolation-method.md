---
title: "Lagrange Interpolation Method"
date: 2026-09-10T11:18:00
description: "Imputing new data points within a certain range"
tags: ["mathematics"]
categories: ["Theories"]
---

## 🖋️ Starting from known points

Given the task of constructing a function

$$
f(x)
$$

that passes through the points

$$
P_1(x_1, y_1), P_2(x_2, y_2), \cdots, P_n(x_n, y_n)
$$

, first let the projection of the `i` th point onto the `x` axis be

$$
P_i^{\prime}(x_i, 0)
$$

Next, consider constructing `n` functions:

$$
f_4(x), f_2(x), \cdots, f_n(x)
$$

such that for the `i` th function

$$
f_i(x)
$$

its graph passes through

$$
\begin{cases}
P_j^{\prime}(x_j, 0), \quad (j \neq i) \\
P_i(x_i, y_i)
\end{cases}
$$

Thus, we can derive the desired function as:

$$
f(x) = \sum\limits_{i=1}^{n} f_i(x)
$$

We can assume that

$$
f_i(x) = a \cdot \prod_{j \neq i} (x - x_j)
$$

By substituting the point

$$
P_i(x_i, y_i)
$$

we find that

$$
a = \dfrac{y_i}{\prod_{j \neq i} (x_i - x_j)}
$$

Therefore

$$
f_i(x) = y_i \cdot \dfrac{\prod_{j \neq i} (x - x_j)}{\prod_{j \neq i} (x_i - x_j)} = y_i \cdot \prod_{j \neq i} \dfrac{x - x_j}{x_i - x_j}
$$

Thus, we obtain the Lagrange interpolation formula as:

$$
f(x) = \sum_{i=1}^{n} y_i \cdot \prod_{j \neq i} \dfrac{x - x_j}{x_i - x_j}
$$

 Here's a breakdown of its components:

- `f(x)`: The interpolating polynomial
- `n`: The number of given points
- `x_i`, `y_i`: The given points through which the polynomial must pass
- `∏`: The product symbol, indicating multiplication of terms

The formula creates a weighted sum of basis polynomials, each passing through one point and zero at all others. This ensures the resulting polynomial satisfies all given points.

The naive implementation of this algorithm has a time complexity of `O(n^2)`, but it can be optimized to `O(nlog^2n)`. For more details, refer to fast polynomial interpolation.

## 📎 **References**

- [https://oi-wiki.org/math/numerical/interp/#lagrange-插值法](https://oi-wiki.org/math/numerical/interp/#lagrange-%E6%8F%92%E5%80%BC%E6%B3%95)
