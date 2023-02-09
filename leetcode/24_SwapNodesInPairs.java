package leetcode;

class SwapNodesInPairs {
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

    public ListNode swapPairs(ListNode head) {
        if (head == null || head.next == null) {
            return head;
        }
        ListNode dummy = new ListNode(0, head);
        ListNode prev = dummy;
        ListNode left = dummy.next;
        ListNode right = dummy.next.next;

        while (true) {
            prev.next = right;
            left.next = right.next;
            right.next = left;

            prev = left;
            if (left.next == null)
                break;
            left = left.next;
            if (left.next == null)
                break;
            right = left.next;
        }
        return dummy.next;
    }
}
