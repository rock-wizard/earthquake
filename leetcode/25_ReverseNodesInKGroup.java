package leetcode;

class ReverseNodesInKGroup {
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

    public ListNode reverseKGroup(ListNode head, int k) {
        if (head == null || head.next == null || k < 2) {
            return head;
        }

        ListNode dummy = new ListNode(0, head);
        ListNode prev = dummy;
        ListNode left = dummy.next;
        ListNode right = dummy.next.next;

        int len = 0;
        while (head != null) {
            len++;
            head = head.next;
        }

        for (int i = 0; i < len / k; i++) {
            for (int j = 0; j < k - 1; j++) {
                left.next = right.next;
                right.next = prev.next;
                prev.next = right;
                right = left.next;
            }

            if (right == null) {
                break;
            }
            prev = left;
            left = right;
            right = right.next;
        }

        return dummy.next;
    }

    public ListNode reverseKGroupBetter(ListNode head, int k) {
        if (head == null || head.next == null || k < 2) {
            return head;
        }

        ListNode dummy = new ListNode(0, head);
        ListNode prev = dummy;
        ListNode curr = dummy;

        while (curr != null) {
            for (int i = 0; i < k && curr != null; i++) {
                curr = curr.next;
            }
            if (curr == null) break;
            ListNode start = prev.next;
            ListNode next = curr.next;
            curr.next = null;
            prev.next = reserve(start);
            start.next = next;
            prev = start;
            curr = prev;
        }

        return dummy.next;
    }

    private ListNode reserve(ListNode node) {
        ListNode prev = null, curr = node;
        while (curr != null) {
            ListNode next = curr.next;
            curr.next = prev;
            prev = curr;
            curr = next;
        }
        return prev;
    }
}
