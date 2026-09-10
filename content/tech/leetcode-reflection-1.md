---
title: "Leetcode reflection (1)"
date: 2026-09-10T11:17:00
description: "Python APIs"
tags: ["algorithm"]
categories: ["Practices"]
---

## 1732. Find the Highest Altitude

There is a biker going on a road trip. The road trip consists of `n + 1` points at different altitudes. The biker starts his trip on point `0` with altitude equal `0`.

You are given an integer array `gain` of length `n` where `gain[i]` is the **net gain in altitude** between points `i` and `i + 1` for all (`0 <= i < n)`. Return *the **highest altitude** of a point.*

**Example 1:**

```
Input: gain = [-5,1,5,0,-7]
Output: 1
Explanation: The altitudes are [0,-5,-4,1,1,-6]. The highest is 1.
```

**Example 2:**

```
Input: gain = [-4,-3,-2,-1,4,3,2]
Output: 0
Explanation: The altitudes are [0,-4,-7,-9,-10,-6,-3,-1]. The highest is 0.
```

### Solution:

A straightforward question, the major solution is to successively sum 2 Adjacent elements in the list, just like the example.

My first answer is:

```python
class Solution:
    def largestAltitude(self, gain: List[int]) -> int:
        for i in range(1, len(gain)):
            gain[i] += gain[i -1]
        fixed = max(gain)
        if fixed > 0:
            return fixed
        else:
            return 0
```

Then, I found another one which used the python API:

```python
class Solution:
    def largestAltitude(self, gain: List[int]) -> int:
        return max(accumulate(gain, initial =0))
```

**One line, and the space complexity is O(1).**

My thought after this question is to use Python APIs (such as `accumulate()`) as much as I can since it probably has been optimized by someone else. Unless I am not so happy with their performance.
