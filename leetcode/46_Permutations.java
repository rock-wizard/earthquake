package leetcode;

import java.util.LinkedList;
import java.util.List;

class Permutations {
    public List<List<Integer>> permute(int[] nums) {
        List<List<Integer>> ans = new LinkedList<>();
        List<Integer> subAns = new LinkedList<>();
        boolean[] visited = new boolean[nums.length];
        dfs(ans, subAns, visited, nums, nums.length);
        return ans;
    }

    private void dfs(List<List<Integer>> ans, List<Integer> subAns, boolean[] visited, int[] nums, int n){
        if (subAns.size() == n) {
            ans.add(new LinkedList<>(subAns));
            return;
        }

        for (int i = 0; i < n; i++) {
            if (visited[i]) {
                continue;
            }
            subAns.add(nums[i]);
            visited[i] = true;
            dfs(ans, subAns, visited, nums, n);
            visited[i] = false;
            subAns.remove(subAns.size() - 1);
        }
    }
}
