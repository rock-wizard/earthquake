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

    public ListNode removeNthFromEnd(ListNode head, int n) {
        ListNode dummy = new ListNode(0, head);
        ListNode prev = dummy, curr = dummy;
        for (int i = 0; i < n; i++) {
            curr = curr.next;
        }

        while (curr.next != null) {
            prev = prev.next;
            curr = curr.next;
        }

        if (prev.next != null) {
            prev.next = prev.next.next;
        }

        return dummy.next;
    }
}
