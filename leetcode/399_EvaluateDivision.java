package leetcode;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

class EvaluateDivision {
    public double[] calcEquation(List<List<String>> equations, double[] values, List<List<String>> queries) {
        Map<String, Map<String, Double>> relations = new HashMap<>();
        for (int i = 0; i < equations.size(); i++) {
            String dividend = equations.get(i).get(0);
            String divisor = equations.get(i).get(1);
            double factor = values[i];

            if (!relations.containsKey(dividend)) {
                relations.put(dividend, new HashMap<String, Double>());
            }
            relations.get(dividend).put(divisor, factor);

            if (!relations.containsKey(divisor)) {
                relations.put(divisor, new HashMap<String, Double>());
            }
            relations.get(divisor).put(dividend, 1.0 / factor);
        }

        double[] ans = new double[queries.size()];
        for (int i = 0; i < queries.size(); i++) {
            List<String> query = queries.get(i);
            String dividend = query.get(0);
            String divisor = query.get(1);

            if (!relations.containsKey(dividend) || !relations.containsKey(divisor)) {
                ans[i] = -1.0;
            } else {
                Set<String> visited = new HashSet<>();
                ans[i] = dfs(dividend, divisor, relations, visited, 1.0);
            }
        }

        return ans;
    }

    private double dfs(String dividend, String divisor, Map<String, Map<String, Double>> relations, Set<String> visited,
            double base) {
        if (visited.contains(dividend)) {
            return -1;
        }

        visited.add(dividend);
        if (dividend.equals(divisor)) {
            return base;
        }

        for (Map.Entry<String, Double> entry : relations.get(dividend).entrySet()) {
            double num = dfs(entry.getKey(), divisor, relations, visited, base * entry.getValue());
            if (num != -1.0) {
                return num;
            }
        }

        return -1.0;
    }
}
