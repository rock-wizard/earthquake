package leetcode;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

class CourseSchedule {
    public boolean canFinish(int numCourses, int[][] prerequisites) {
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

        for (int i = 0; i < numCourses; i++) {
            if (!dfs(i, status, prepares)) {
                return false;
            }
        }

        return true;
    }

    private boolean dfs(int course, Map<Integer, Integer> status, Map<Integer, Set<Integer>> prepares) {
        if (!prepares.containsKey(course)) {
            return true;
        }

        if (status.get(course) == 1) {
            return true;
        }

        if (status.get(course) == 0) {
            return false;
        }

        status.put(course, 0);
        for (Integer prepare : prepares.get(course)) {
            if (!dfs(prepare, status, prepares)) {
                return false;
            }
        }
        status.put(course, 1);
        return true;
    }
}
