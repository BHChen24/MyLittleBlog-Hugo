---
title: "Move Zeroes: Understanding Parameter Behavior in Python"
date: 2026-09-10T11:12:00
description: "Leetcode Problem Notes, Two-pointer Optimization"
tags: ["algorithm"]
categories: ["Practices"]
---

> 🔔 **Prelude:**
> When addressing the "Move Zeroes" problem, it is simple to misinterpret Python's parameter behavior.
> Remember: A local variable and a parameter sharing the same name does not mean they refer to the same object.

## 🖋️ Move Zeroes

Given an integer array `nums`, move all `0`'s to the end of it while maintaining the relative order of the non-zero elements.

**Note** that you must do this in-place without making a copy of the array.

**Example 1:**

```
Input: nums = [0,1,0,3,12]
Output: [1,3,12,0,0]

```

---

Here's an example of solving the "Move Zeroes" problem (a wrong one):

```python
def moveZeroes(self, nums: List[int]) -> None:
    counter = 0
    while 0 in nums:
        nums.remove(0)
        counter += 1
    nums = nums + [0] * counter
```

In this code, the final assignment to `nums` actually doesn’t affect the parameter `nums` because **they are different variables**.

Within the function, Python creates a new namespace, known as the **local scope**. All variables defined or assigned inside the function are, by default, considered local variables.

When you execute `nums = nums + [0] * counter` inside the function, Python’s interpreter assigns the new list object (from the right-hand expression) to the local variable `nums`. This means:

- The original `nums` (the parameter) still refers to the passed-in list object.
- The local variable `nums` now refers to a **new list object**.
- **The assignment `nums = ...`** changes the binding of the local `nums` to point to the new object, leaving the original passed-in list unaffected.

A possible solution is to change the first `nums` to `nums[:]`, which means you are modifying the original object.

#### Two-pointer Solution:

A more efficient approach to solving the "Move Zeroes" problem is using a two-pointer method:

```python
class Solution:
    def moveZeroes(self, nums: List[int]) -> None:
        """
        Do not return anything, modify nums in-place instead.
        """
        left = 0

        for right in range(len(nums)):
            if nums[right] != 0:
                nums[left], nums[right] = nums[right], nums[left]
                left += 1
```

In this solution, `left` is initialized to zero, and the first element being zero does not affect the algorithm's ability to move all zeros to the right. This two-pointer method efficiently processes the list in-place, making it a more optimal solution than the previous approach.
