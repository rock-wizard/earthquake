package leetcode;

import java.util.Deque;
import java.util.LinkedList;

class MaximumWidthofBinaryTree {
    public class TreeNode {
        int val;
        TreeNode left;
        TreeNode right;

        TreeNode() {
        }

        TreeNode(int val) {
            this.val = val;
        }

        TreeNode(int val, TreeNode left, TreeNode right) {
            this.val = val;
            this.left = left;
            this.right = right;
        }
    }

    public int widthOfBinaryTree(TreeNode root) {
        int ans = 0;
        Deque<TreeNode> q = new LinkedList<>();
        root.val = 1;
        q.add(root);

        while (!q.isEmpty()) {
            int l = 0, r = 0;
            int size = q.size();

            for (int i = 0; i < size; i++) {
                TreeNode node = q.pollFirst();
                if (i == 0) {
                    l = node.val;
                }
                if (i == size - 1) {
                    r = node.val;
                }

                if (node.left != null) {
                    node.left.val = 2 * node.val - 1;
                    q.addLast(node.left);
                }
                if (node.right != null) {
                    node.right.val = 2 * node.val;
                    q.addLast(node.right);
                }
            }

            ans = Math.max(ans, r - l + 1);
        }

        return ans;
    }
}
