package leetcode;

import java.util.ArrayList;
import java.util.List;

/*
 * There is a basic rule must be satisfied. 
 * For a correct combination of parentheses, there must has a left parenthsis in the left of right parenthsis.
 * 
 * So I assume we have n paires of parenthese, nl=0 used left parenthsis, nr=0 used right parenthesis.
 * if nl < n, I can put the ( in to the temp ans.
 * if nr < nl, I can put the ) in to the temp ans.
 * if nl + nr == 2 * n, I get the new answer, and add it into the list.
 */

class GenerateParentheses {
    public List<String> generateParenthesis(int n) {
        List<String> ans = new ArrayList<String>();
        StringBuilder path = new StringBuilder();
        recursion(n, 0, 0, ans, path);
        return ans;
    }

    private void recursion(int n, int nl, int nr, List<String> ans, StringBuilder path) {
        if (nl + nr == 2 * n) {
            ans.add(path.toString());
            return;
        }

        if (nl < n) {
            path.append('(');
            recursion(n, nl + 1, nr, ans, path);
            path.deleteCharAt(path.length() - 1);
        }

        if (nr < nl) {
            path.append(')');
            recursion(n, nl, nr + 1, ans, path);
            path.deleteCharAt(path.length() - 1);
        }
    }
}