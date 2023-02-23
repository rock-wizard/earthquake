package leetcode;

import java.util.ArrayList;
import java.util.List;

class LowestCommonAncestorOfaBinarySearchTree {

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
    
    public TreeNode lowestCommonAncestor(TreeNode root, TreeNode p, TreeNode q) {
        List<TreeNode> path1 = new ArrayList<>();
        List<TreeNode> path2 = new ArrayList<>();
        drawPath(root, p, path1);
        drawPath(root, q, path2);

        int len = Math.min(path1.size(), path2.size());

        for (int i = len - 1; i >= 0; i--) {
            if (path1.get(i) == path2.get(i)) {
                return path1.get(i);
            }
        }

        return null;
    }

    private void drawPath(TreeNode node, TreeNode target, List<TreeNode> path) {
        if (node == null) {
            return;
        }

        path.add(node);

        if (node.val == target.val) {
            return;
        }

        if (node.val > target.val) {
            drawPath(node.left, target, path);
        } else {
            drawPath(node.right, target, path);
        }
    }

    public TreeNode lowestCommonAncestorBetter(TreeNode root, TreeNode p, TreeNode q) {
        TreeNode ans = root;

        while (ans != null) {
            if (p.val < ans.val && q.val < ans.val) {
                ans = ans.left;
            } else if (p.val > ans.val && q.val > ans.val) {
                ans = ans.right;
            } else {
                break;
            }
        }

        return ans;
    }
}
