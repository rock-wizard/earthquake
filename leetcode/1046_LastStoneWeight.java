package leetcode;

import java.util.Comparator;
import java.util.PriorityQueue;
import java.util.Queue;

class LastStoneWeight {
    public int lastStoneWeight(int[] stones) {
        Queue<Integer> q = new PriorityQueue<>(Comparator.reverseOrder());

        for (int i = 0; i < stones.length; i++) {
            q.add(stones[i]);
        }

        while (q.size() > 1) {
            int s1 = q.poll(), s2 = q.poll();
            int diff = Math.abs(s1 - s2);
            if (diff != 0) {
                q.add(diff);
            }
        }
        System.out.println("sda");

        return q.size() == 0 ? 0 : q.poll();
    }
}