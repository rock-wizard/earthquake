package leetcode;

import java.util.Stack;

class ValidateBinarySearchTree {
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

    public boolean isValidBST(TreeNode root) {
        return checkUp(root, null, null);
    }

    private boolean checkUp(TreeNode node, TreeNode low, TreeNode high) {
        if (node == null) {
            return true;
        }

        if (low != null && node.val <= low.val) {
            return false;
        }

        if (high != null && node.val >= high.val) {
            return false;
        }

        return checkUp(node.left, low, node) && checkUp(node.right, node, high);
    }

    public boolean isValidBSTInorder(TreeNode root) {
        return recursion(root);
    }

    TreeNode prev = null;

    private boolean recursion(TreeNode node) {
        if (node == null) {
            return true;
        }

        if (!recursion(node.left)) {
            return false;
        }

        if (prev != null && node.val <= prev.val) {
            return false;
        }
        prev = node;
        
        return recursion(node.right);
    }

    public boolean isValidBSTByIteration(TreeNode root) {
        if (root == null) {
            return true;
        }
        
        Stack<TreeNode> stack = new Stack<>();
        TreeNode node = root;
        TreeNode prev = null;

        while (node != null || !stack.empty()) {
            while (node != null) {
                stack.push(node);
                node = node.left;
            }

            node = stack.pop();
            if (prev != null && prev.val >= node.val) {
                return false;
            }
            prev = node;
            node = node.right;
        }

        return true;
    }
}
