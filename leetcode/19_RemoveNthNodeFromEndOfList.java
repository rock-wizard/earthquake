package leetcode;

class RemoveNthNodeFromEndOfList {
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


    // Once the curr is pointing to the last node of the list, the prev points the previce one before the target
    public ListNode removeNthFromEnd(ListNode head, int n) {
        ListNode dummy = new ListNode(-1, head);
        ListNode prev = dummy, curr = dummy;

        for (int i = 0; i < n; i++) {
            curr = curr.next;
        }

        while (curr.next != null) {
            prev = prev.next;
            curr = curr.next;
        }

        prev.next = prev.next.next;

        return dummy.next;
    }
}
