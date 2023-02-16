package leetcode;

import java.util.HashMap;
import java.util.Map;

class IsomorphicStrings {
    public boolean isIsomorphic(String s, String t) {
        Map<Character, Character> s_t_map = new HashMap<>();
        Map<Character, Character> t_s_map = new HashMap<>();

        for (int i = 0; i < s.length(); i++) {
            char c1 = s.charAt(i);
            char c2 = t.charAt(i);
            if (s_t_map.containsKey(c1) && s_t_map.get(c1) != c2) {
                return false;
            }

            if (t_s_map.containsKey(c2) && t_s_map.get(c2) != c1) {
                return false;
            }

            s_t_map.put(c1, c2);
            t_s_map.put(c2, c1);
        }

        return true;
    }

    /*
     * If the answer is true, it means any character in s can be mapped to t with required compliance.
     * We assign the related position to each character to s and t.
     * 
     * the index of first time a charachter occurance is the related position.
     * So we just check whether the related positions are equal to determine if it's isomorphic.
     */
    public boolean isIsomorphicSingleMap(String s, String t) {
        Map<Character, Character> map = new HashMap<>();

        for (int i = 0; i < s.length(); i++) {
            char c1 = s.charAt(i);
            char c2 = t.charAt(i);

            if (map.containsKey(c1) && map.get(c1) != c2) {
                return false;
            }

            if (!map.containsKey(c1) && map.containsValue(c2)) {
                return false;
            }

            map.put(c1, c2);
        } 
        
        return true;
    }

    public boolean isIsomorphicByRelatedPosition(String s, String t) {
        Map<Character, Integer> s_map = new HashMap<>();
        Map<Character, Integer> t_map = new HashMap<>();

        for (int i = 0; i < s.length(); i++) {
            char c1 = s.charAt(i);
            char c2 = t.charAt(i);
            
            if (s_map.get(c1) != t_map.get(c2)) {
                return false;
            }


            s_map.put(c1, s_map.getOrDefault(c1, i));
            t_map.put(c2, t_map.getOrDefault(c2, i));
        } 
        
        return true;
    }
}
