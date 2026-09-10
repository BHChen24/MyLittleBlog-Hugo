---
title: "Simple Tree Traversal"
date: 2026-09-10T11:21:00
description: "Understanding the 'Movement' within the tree"
tags: ["algorithm", "tutorial"]
categories: ["Practices"]
---

## 🖋️ Leaf-Similar Trees (Leetcode 872)

![](https://assets.leetcode.com/uploads/2020/09/03/leaf-similar-1.jpg)

In short, we are gonna to compare the leaves between two tree.

First, we should get the elements from the leaves.

```python
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right

class Solution:

    def dfs(self, root, list_para):
        temp = []
        curr = root

        while curr is not None or len(temp) > 0:
            while curr:
                temp.append(curr)
                curr = curr.left

            // Save all elements on the left side, but
            // we only want the leaf element, so...
            curr = temp.pop()

            if curr.left is None and curr.right is None:
                list_para.append(curr.val)

            curr = curr.right
            // Attention here, we 'move' our 'pointer' to the right side
            // After we have done all the things we should do on the left side

    def leafSimilar(self, root1: Optional[TreeNode], root2: Optional[TreeNode]) -> bool:
        l1 = []
        l2 = []
        self.dfs(root1, l1)
        self.dfs(root2, l2)
        return l1 == l2
```

### **Recursion** Method

```python

class Solution:
    def dfs(self, root, list_para):
        if root is None:
            return

        if root.left is None and root.right is None:
            list_para.append(root.val)
        // **Move** to the left, do it again, **until 'root is None'**
        self.dfs(root.left, list_para)
        // Left side finished

        // **Move** to the right, do it again, **until 'root is None'**
        self.dfs(root.right, list_para)
				 // Right side finished, all required data is saved in the list_para

    def leafSimilar(self, root1: Optional[TreeNode], root2: Optional[TreeNode]) -> bool:
        l1 = []
        l2 = []
        self.dfs(root1, l1)
        self.dfs(root2, l2)
        return l1 == l2

```
