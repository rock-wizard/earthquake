package leetcode;

import java.util.HashMap;
import java.util.Map;
import java.util.PriorityQueue;

class TaskScheduler {
    public int leastInterval(char[] tasks, int n) {
        int ans = 0;
        Map<Character, Integer> map = new HashMap<>();
        for (char task : tasks) {
            map.put(task, map.getOrDefault(task, 0) + 1);
        }

        PriorityQueue<Map.Entry<Character, Integer>> q = new PriorityQueue<Map.Entry<Character, Integer>>(
                (e1, e2) -> e2.getValue() - e1.getValue());
        q.addAll(map.entrySet());
        PriorityQueue<Map.Entry<Character, Integer>> running = new PriorityQueue<Map.Entry<Character, Integer>>(
                (e1, e2) -> e2.getValue() - e1.getValue());

        /**
         * Prioritise use a task has most left counts
         */
        while (!q.isEmpty()) {
            for (int i = 0; i <= n; i++) {
                if (!q.isEmpty()) {
                    Map.Entry<Character, Integer> task = q.poll();
                    task.setValue(task.getValue() - 1);

                    if (task.getValue() > 0) {
                        running.add(task);
                    }
                    ans++;
                } else if (!running.isEmpty()) {
                    // add ideal
                    ans++;
                }
            }

            while (!running.isEmpty()) {
                q.add(running.poll());
            }
        }

        return ans;
    }

    public int leastIntervalByCount(char[] tasks, int n) {
        // Find the task withh max count, and how many thiese kind of tasks
        int task_cnt = 0, cnt = 0;
        int[] count = new int[26];
        for (char task : tasks) {
            count[task - 'A']++;

            if (cnt == count[task - 'A']) {
                task_cnt++;
            } else if (cnt < count[task - 'A']) {
                task_cnt = 1;
                cnt = count[task - 'A'];
            }
        }

        int part_cnt = cnt - 1;
        int part_length = n - (task_cnt - 1);
        int space_cnt = part_cnt * part_length;
        int left_char_cnt = tasks.length - task_cnt * cnt;
        return tasks.length + Math.max(0, space_cnt - left_char_cnt);
    }
}
