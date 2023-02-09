package leetcode;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.PriorityQueue;

class TopKFrequentWords {
    public List<String> topKFrequent(String[] words, int k) {
        Map<String, Integer> dict = new HashMap<>();
        for (String word : words) {
            dict.put(word, dict.getOrDefault(word, 0) + 1);
        }

        // Using priproty Queue to sort these words, and we should custom a comparation
        // method
        PriorityQueue<Map.Entry<String, Integer>> queue = new PriorityQueue<>(
                (x, y) -> {
                    if (x.getValue().equals(y.getValue())) {
                        return -1 * x.getKey().compareTo(y.getKey());
                    }
                    return x.getValue().compareTo(y.getValue());
                });

        for (Map.Entry<String, Integer> entry : dict.entrySet()) {
            queue.offer(entry);
            if (queue.size() > k) {
                queue.poll();
            }
        }

        List<String> ans = new ArrayList<>();
        while (!queue.isEmpty()) {
            ans.add(queue.poll().getKey());
        }

        Collections.reverse(ans);
        return ans;
    }
}
