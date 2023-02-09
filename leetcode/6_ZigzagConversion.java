package leetcode;

import java.util.ArrayList;
import java.util.List;

class ZigzagConversion {
    public String convert(String s, int numRows) {
        if (numRows == 1) {
            return s;
        }
        
        List<StringBuilder> rows = new ArrayList<>();
        for (int i = 0; i < Math.min(numRows, s.length()); i++) {
            rows.add(new StringBuilder());
        }
        
        int curRow = 0;
        boolean down = false;
        for (int i = 0; i < s.length(); i++) {
            rows.get(curRow).append(s.charAt(i));
            
            if (curRow == 0 || curRow == numRows - 1) {
                down = !down;
            }
            curRow += down? 1 : -1;
        }
        
        StringBuilder ans = new StringBuilder();
        for (StringBuilder row : rows) {
            ans.append(row);
        }
        return ans.toString();
    }
}
