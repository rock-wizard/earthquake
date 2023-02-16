package leetcode;

import java.util.ArrayList;
import java.util.List;
import java.util.Stack;

import javafx.util.Pair;

class BinaryTreePreorderTraversal {

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

    public List<Integer> preorderTraversal(TreeNode root) {
        List<Integer> nodes = new ArrayList<>();
        recursion(root, nodes);
        return nodes;
    }

    private void recursion(TreeNode node, List<Integer> nodes) {
        if (node == null) {
            return;
        }
        nodes.add(node.val);
        recursion(node.left, nodes);
        recursion(node.right, nodes);
    }

    public List<Integer> preorderTraversalIteration(TreeNode root) {
        if (root == null) {
            return new ArrayList<Integer>();
        }

        List<Integer> nodes = new ArrayList<>();
        Stack<TreeNode> stack = new Stack<>();
        TreeNode node = root;

        while (node != null || !stack.empty()) {

            if (node != null) {
                nodes.add(node.val);
                stack.push(node);
                node = node.left;
            } else {
                node = stack.pop();
                node = node.right;
            }
        }

        return nodes;
    }

    enum Color {
        WHITE, BLACK
    };

    public List<Integer> preorderTraversalColor(TreeNode root) {
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
                stack.push(new Pair(Color.WHITE, node.right));
                stack.push(new Pair(Color.WHITE, node.left));
                stack.push(new Pair(Color.BLACK, node));
            } else {
                nodes.add(node.val);
            }
        }

        return nodes;
    }
}
