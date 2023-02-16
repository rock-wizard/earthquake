package leetcode;

import java.util.ArrayList;
import java.util.List;
import java.util.Stack;

import javafx.util.Pair;

class BinaryTreePostorderTraversal {
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
    
    public List<Integer> postorderTraversal(TreeNode root) {
        List<Integer> nodes = new ArrayList<>();
        recursion(root, nodes);
        return nodes;
    }

    private void recursion(TreeNode node, List<Integer> nodes) {
        if (node == null) {
            return;
        }

        recursion(node.left, nodes);
        recursion(node.right, nodes);
        nodes.add(node.val);
    }

    enum Color {WHITE, BLACK};

    public List<Integer> postorderTraversalColor(TreeNode root) {
        if (root == null) {
            return new ArrayList<Integer>();
        }
        List<Integer> nodes = new ArrayList<>();
        Stack<Pair<Color, TreeNode>> stack = new Stack<>();
        stack.push(new Pair(Color.WHITE, root));

        while (!stack.empty()) {
            Pair pair = stack.pop();
            Color color = (Color) pair.getKey();
            TreeNode node = (TreeNode) pair.getValue();

            if (node == null) {
                continue;
            }

            if (color == Color.WHITE) {
                stack.push(new Pair(Color.BLACK, node));
                stack.push(new Pair(Color.WHITE, node.right));
                stack.push(new Pair(Color.WHITE, node.left));
            } else {
                nodes.add(node.val);
            }
        }

        return nodes;
    }

    public List<Integer> postorderTraversalIteration(TreeNode root) {
        if (root == null) {
            return new ArrayList<Integer>();
        }

        List<Integer> nodes = new ArrayList<Integer>();
        Stack<TreeNode> stack = new Stack<>();
        TreeNode node = root, prev = null;

        while (node != null || !stack.empty()) {
            while (node != null) {
                stack.push(node);
                node = node.left;
            }

            node = stack.pop();
            if (node.right == null || node.right == prev) {
                nodes.add(node.val);
                prev = node;
                node = null;
            } else {
                stack.push(node);
                node = node.right;
            }
        }

        return nodes;
    }
}
