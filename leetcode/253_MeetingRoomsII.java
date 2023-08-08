package leetcode;

import java.util.Arrays;
import java.util.Comparator;
import java.util.PriorityQueue;

class MeetingRoomsII {
    public int minMeetingRooms(int[][] intervals) {
        if (intervals == null || intervals.length == 0) {
            return 0;
        }

        Arrays.sort(intervals, new Comparator<int[]>() {
            @Override
            public int compare(int[] a, int[] b) {
                return a[0] - b[0];
            }
        });
        
        int room = 0;
        PriorityQueue<Integer> pq = new PriorityQueue<>();
        for (int i = 0; i < intervals.length; i++) {
            pq.offer(intervals[i][1]);
            if (intervals[i][0] < pq.peek()) {
                room++;
            } else {
                pq.poll();
            }
        }
        return room;
    }
}
