package leetcode;

class BalancedBinaryTree {
    private class TreeNode {
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

    public boolean isBalanced(TreeNode root) {
        return dfs(root) != -1;
    }

    private int dfs(TreeNode node) {
        if (node == null) {
            return 0;
        }

        int l_height = dfs(node.left);
        if (l_height == -1) {
            return -1;
        }

        int r_height = dfs(node.right);
        if (r_height == -1) {
            return -1;
        }

        if (Math.abs(l_height - r_height) > 1) {
            return -1;
        }

        return Math.max(l_height, r_height) + 1;
    }
}
