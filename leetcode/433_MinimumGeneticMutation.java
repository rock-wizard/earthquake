package leetcode;

import java.util.HashSet;
import java.util.LinkedList;
import java.util.Queue;
import java.util.Set;

class MinimumGeneticMutation {
    public int minMutation(String start, String end, String[] bank) {
        Queue<String> queue = new LinkedList<>();
        Set<String> seen = new HashSet<>();
        Set<String> genes = new HashSet<>();

        for (String gene : bank) {
            genes.add(gene);
        }
        queue.add(start);
        seen.add(start);

        int ans = 0;

        while (!queue.isEmpty()) {
            int len = queue.size();
            for (int i = 0; i < len; i++) {
                String gene = queue.remove();
                if (gene.equals(end)) {
                    return ans;
                }

                for (char c : new char[] { 'A', 'C', 'G', 'T' }) {
                    for (int j = 0; j < gene.length(); j++) {
                        String mutation = gene.substring(0, j) + c + gene.substring(j + 1);
                        if (!seen.contains(mutation) && genes.contains(mutation)) {
                            queue.add(mutation);
                            seen.add(mutation);
                        }
                    }
                }
            }
            ans++;
        }

        return -1;
    }
}
