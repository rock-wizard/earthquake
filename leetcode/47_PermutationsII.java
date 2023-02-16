package leetcode;

import java.util.Arrays;
import java.util.LinkedList;
import java.util.List;

class PermutationsII {
    public List<List<Integer>> permuteUnique(int[] nums) {
        List<List<Integer>> ans = new LinkedList<>();
        List<Integer> subAns = new LinkedList<>();
        boolean[] visited = new boolean[nums.length];
        Arrays.sort(nums);
        dfs(ans, subAns, visited, nums, nums.length);
        return ans;
    }

    /*
     * fully ignore the duplicate number in the same index of subAns
     * we only use the most left one of a set of duplicated numbers
     */
    private void dfs(List<List<Integer>> ans, List<Integer> subAns, boolean[] visited, int[] nums, int n) {
        if (subAns.size() == n) {
            ans.add(new LinkedList<>(subAns));
            return;
        }

        for (int i = 0; i < n; i++) {
            if (visited[i]) {
                continue;
            }
            if (i > 0 && nums[i] == nums[i - 1] && !visited[i - 1]) {
                continue;
            }

            subAns.add(nums[i]);
            visited[i] = true;
            dfs(ans, subAns, visited, nums, n);
            visited[i] = false;
            subAns.remove(subAns.size() - 1);
        }
    }

    /*
     * fully ignore the duplicate number in the same index of subAns
     * we only use the most left one of a set of duplicated numbers
     */
    private void dfs1(List<List<Integer>> ans, List<Integer> subAns, boolean[] visited, int[] nums, int n) {
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

            while (i < n -1 && nums[i] == nums[i + 1]) {
                i++;
            }
        }
    }
}
