package leetcode;

class StepByStepDirectionsFromBinaryTreeNodeToAnother {
    public String getDirections(TreeNode root, int startValue, int destValue) {
        StringBuilder start = new StringBuilder();
        if (!findPath(root, startValue, start)) {
            return null;
        }

        StringBuilder dest = new StringBuilder();
        if (!findPath(root, destValue, dest)) {
            return null;
        }

        System.out.println(start.toString());
        System.out.println(dest.toString());
        StringBuilder ans = new StringBuilder();
        int i = 0;
        // find the first different direction
        for (; i < Math.min(start.length(), dest.length()); i++) {
            if (start.charAt(i) != dest.charAt(i)) {
                break;
            }
        }

        return "U".repeat(start.length() - i) + dest.toString().substring(i);
    }

    private boolean findPath(TreeNode node, int target, StringBuilder path) {
        if (node == null) {
            return false;
        }

        if (target == node.val) {
            return true;
        }

        path.append("L");
        if (findPath(node.left, target, path)) {
            return true;
        }
        path.deleteCharAt(path.length() - 1);

        path.append("R");
        if (findPath(node.right, target, path)) {
            return true;
        }
        path.deleteCharAt(path.length() - 1);

        return false;
    }
}
