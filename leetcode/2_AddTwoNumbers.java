package leetcode;

class AddTwoNumbers {

    class ListNode {
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

    /*
     * The simple solution is to create a new inked list to store the calculation
     * result.
     * In this way, you just need to calculate the sum of corresponding digits in
     * the different list, don't forget to add the carry.
     * To avoid the null pointers, it should make sure which list is not empty and
     * get its value.
     */

    public ListNode addTwoNumbersByNewList(ListNode l1, ListNode l2) {
        ListNode dummy = new ListNode();
        ListNode current = dummy;
        int carry = 0;
        while (l1 != null || l2 != null) {
            int x = l1 == null ? 0 : l1.val;
            int y = l2 == null ? 0 : l2.val;
            int sum = x + y + carry;

            carry = sum < 10 ? 0 : 1;
            current.next = new ListNode(sum % 10);
            current = current.next;

            if (l1 != null) {
                l1 = l1.next;
            }
            if (l2 != null) {
                l2 = l2.next;
            }
        }

        if (carry == 1) {
            current.next = new ListNode(1);
        }

        return dummy.next;
    }

    /*
     * Compare to the above solution, this way can save the memory, because it reuse
     * the memory of l1 and l2.
     * You just need to put the calculation result to the l1.
     * 
     * If the l2 is longer, you should to mark the end node of l1, and use it to
     * connect with l2 has not been yet calculated.
     */
    public ListNode addTwoNumbers(ListNode l1, ListNode l2) {
        ListNode ans = l1, prev = null;
        int carry = 0;
        while (l1 != null && l2 != null) {
            int sum = carry + l1.val + l2.val;
            l1.val = sum % 10;
            carry = sum / 10;

            prev = l1;
            l1 = l1.next;
            l2 = l2.next;
        }

        if (l2 != null) {
            prev.next = l2;
            l1 = l2;
        }

        while (l1 != null) {
            if (carry == 0) {
                break;
            }
            int sum = carry + l1.val;
            l1.val = sum % 10;
            carry = sum / 10;

            prev = l1;
            l1 = l1.next;
        }

        if (carry == 1) {
            prev.next = new ListNode(1, null);
        }

        return ans;
    }

    public static void main(String[] args) {
        // AddTwoNumbers ins = new AddTwoNumbers();

        // ListNode l1_1 = ins.new ListNode(9);
        // ListNode l1_2 = ins.new ListNode(9, l1_1);
        // ListNode l1_3 = ins.new ListNode(9, l1_2);
        // ListNode l1_4 = ins.new ListNode(9, l1_3);
        // ListNode l1_5 = ins.new ListNode(9, l1_4);
        // ListNode l1_6 = ins.new ListNode(9, l1_5);
        // ListNode l1_7 = ins.new ListNode(9, l1_6);

        // ListNode l2_1 = ins.new ListNode(9);
        // ListNode l2_2 = ins.new ListNode(9, l2_1);
        // ListNode l2_3 = ins.new ListNode(9, l2_2);
        // ListNode l2_4 = ins.new ListNode(9, l2_3);

        // ListNode ans = ins.addTwoNumbers(l1_7, l2_4);

        // while (ans != null) {
        // System.out.print(ans.val + " ");
        // ans = ans.next;
        // }

        // System.out.println("aaaa".substring(0,3));
        String s1 = "abcde", s2 = "abc";
        System.out.println((3 - 0) / 2 + 0);
    }
}