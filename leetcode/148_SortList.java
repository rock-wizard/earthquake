package leetcode;

class SortList {
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

    public ListNode sortList(ListNode head) {
        return merge(head);
    }

    private ListNode merge(ListNode node) {
        if (node == null || node.next == null) {
            return node;
        }
        ListNode mid = findMid(node);
        ListNode left = merge(node);
        ListNode right = merge(mid);

        return Conquer(left, right);
    }

    private ListNode Conquer(ListNode left, ListNode right) {
        ListNode dummy = new ListNode(), curr = dummy;
        while (left != null && right != null) {
            if (left.val < right.val) {
                curr.next = left;
                left = left.next;
            } else {
                curr.next = right;
                right = right.next;
            }
            curr = curr.next;
        }

        if (left != null) {
            curr.next = left;
        }

        if (right != null) {
            curr.next = right;
        }

        return dummy.next;
    }

    private ListNode findMid(ListNode node) {
        ListNode slow = node, fast = node;

        while (fast.next != null && fast.next.next != null) {
            slow = slow.next;
            fast = fast.next.next;
        }

        ListNode right = slow.next;
        slow.next = null;
        return right;
    }
}
