package leetcode;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

class CourseScheduleII {
    public int[] findOrder(int numCourses, int[][] prerequisites) {
        Map<Integer, Integer> status = new HashMap<>();
        for (int i = 0; i < numCourses; i++) {
            status.put(i, -1);
        }

        Map<Integer, Set<Integer>> prepares = new HashMap<>();
        for (int i = 0; i < prerequisites.length; i++) {
            if (!prepares.containsKey(prerequisites[i][0])) {
                prepares.put(prerequisites[i][0], new HashSet<Integer>());
            }
            prepares.get(prerequisites[i][0]).add(prerequisites[i][1]);
        }

        List<Integer> ans = new ArrayList<>();
        for (int i = 0; i < numCourses; i++) {
            if (!dfs(ans, i, status, prepares)) {
                return new int[] {};
            }
        }

        int[] res = new int[numCourses];
        for (int i = 0; i < numCourses; i++) {
            res[i] = ans.get(i);
        }
        return res;
    }

    private boolean dfs(List<Integer> ans, int course, Map<Integer, Integer> status,
            Map<Integer, Set<Integer>> prepares) {
        if (status.get(course) == 1) {
            return true;
        }

        if (status.get(course) == 0) {
            return false;
        }

        if (!prepares.containsKey(course)) {
            ans.add(course);
            status.put(course, 1);
            return true;
        }

        status.put(course, 0);
        for (Integer prepare : prepares.get(course)) {
            if (!dfs(ans, prepare, status, prepares)) {
                return false;
            }
        }
        ans.add(course);
        status.put(course, 1);
        return true;
    }
}
