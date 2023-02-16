package leetcode;

import java.util.ArrayDeque;
import java.util.ArrayList;
import java.util.Deque;
import java.util.List;

class NaryTreePreorderTraversal {
    private class Node {
        public int val;
        public List<Node> children;

        public Node() {
        }

        public Node(int _val) {
            val = _val;
        }

        public Node(int _val, List<Node> _children) {
            val = _val;
            children = _children;
        }
    }

    public List<Integer> preorder(Node root) {
        List<Integer> nodes = new ArrayList<Integer>();
        recursion(root, nodes);
        return nodes;
    }

    private void recursion(Node root, List<Integer> nodes) {
        if (root == null) {
            return;
        }
        nodes.add(root.val);
        for (Node node : root.children) {
            recursion(node, nodes);
        }
    }

    public List<Integer> preorderIteration(Node root) {
        List<Integer> nodes = new ArrayList<Integer>();
        Deque<Node> stack = new ArrayDeque<>();
        if (root == null) {
            return nodes;
        }

        stack.push(root);
        while (!stack.isEmpty()) {
            Node node = stack.pop();
            nodes.add(node.val);

            for (int i = node.children.size() - 1; i >= 0; i--) {
                stack.push(node.children.get(i));
            }
        }

        return nodes;
    }
}
