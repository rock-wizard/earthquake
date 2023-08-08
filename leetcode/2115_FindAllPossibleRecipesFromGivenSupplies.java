package leetcode;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

class FindAllPossibleRecipesFromGivenSupplies {
    public List<String> findAllRecipes(String[] recipes, List<List<String>> ingredients, String[] supplies) {
        Map<String, Integer> status = new HashMap<>();
        Map<String, List<String>> prepares = new HashMap<>();

        for (int i = 0; i < recipes.length; i++) {
            status.put(recipes[i], -1);
            prepares.put(recipes[i], ingredients.get(i));
        }

        for (int i = 0; i < supplies.length; i++) {
            status.put(supplies[i], 1);
        }

        List<String> ans = new ArrayList<>();
        for (int i = 0; i < recipes.length; i++) {
            dfs(recipes[i], status, prepares, ans);
        }
        return ans;
    }

    private boolean dfs(String name, Map<String, Integer> status, Map<String, List<String>> prepares,
            List<String> ans) {
        if (!status.containsKey(name)) {
            return false;
        }

        if (status.get(name) == 0) {
            return false;
        }

        if (status.get(name) == 1) {
            return true;
        }

        status.put(name, 0);
        for (String s : prepares.get(name)) {
            if (!dfs(s, status, prepares, ans)) {
                return false;
            }
        }
        status.put(name, 1);
        ans.add(name);

        return true;
    }
}
