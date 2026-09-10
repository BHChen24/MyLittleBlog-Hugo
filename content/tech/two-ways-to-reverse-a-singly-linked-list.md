---
title: "Two Ways to Reverse a Singly Linked List"
date: 2026-09-10T11:20:00
tags: ["algorithm"]
categories: ["Tech notes"]
---

## 0. Structure of a Singly Linked List

```python
class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

// 1 -> 2 -> 3 -> 4 -> 5 -> NULL
```

## 1. Move pointers

```python
def reverseList(head: ListNode) -> ListNode:
    prev = None
    curr = head

    while curr:
        temp = curr.next    # Save next node
        curr.next = prev    # Reverse the pointer
        prev = curr         # Move prev forward
        curr = temp         # Move curr forward

    return prev  # New head of the reversed list
```

0:
  1 -> None  2 -> 3 -> 4 -> 5 -> NULL

1:
  2 -> 1 -> None     3 -> 4 -> 5 -> NULL

2:
  3 -> 2 -> 1 -> None     4 -> 5 -> NULL

3:
  4 -> 3 -> 2 -> 1 -> None     5 -> NULL

4:
  5 -> 4 -> 3 -> 2 -> 1 -> None

---

## 2. Head Insertion

```python
def reverseList(head: ListNode) -> ListNode:
    prev = ListNode(0)
    prev.next = head
    curr = prev.next

    while curr.next:
        temp = curr.next
        curr.next = temp.next
        temp.next = prev.next
        prev.next = temp

    return prev.next
```

0:
  1 -> 2 -> 3 -> 4 -> 5 -> NULL

1:
  **2 -> 1** -> 3 -> 4 -> 5 -> NULL

2:
  **3 -> 2 -> 1** -> 4 -> 5 -> NULL

3:
  **4 -> 3 -> 2 -> 1** -> 5 -> NULL

4:
  **5 -> 4 -> 3 -> 2 -> 1** -> NULL
