package leetcode;

import java.util.ArrayList;
import java.util.List;

class PalindromeLinkedList {
    private class ListNode {
        int val;
        ListNode next;

        ListNode() {
        }

        ListNode(int val) {
            this.val = val;
        }

        ListNode(int val, ListNode next) {
            this.val = val;
            this.next = next;
        }
    }

    public boolean isPalindrome(ListNode head) {
        List<Integer> left = new ArrayList<>();
        ListNode prev = head, curr = head;

        // find the middle node
        while (curr != null && curr.next != null) {
            left.add(prev.val);

            prev = prev.next;
            curr = curr.next.next;
        }

        curr = curr == null ? prev : prev.next;

        for (int i = left.size() - 1; i >= 0; i--) {
            if (left.get(i) != curr.val) {
                return false;
            }
            curr = curr.next;
        }

        return true;
    }
}
