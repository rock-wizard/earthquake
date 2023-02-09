package leetcode;

/*
 * The volume is the multiple of width * lower(height[l], height[r]);
 * We set S(l,r) =  lower(height[l], hight[r]) * (r-l)
 * l is the left boundary, and the r is the right boundary.
 * 
 * 
 * Firstly, we assume the l is in index 0, and the r is in index heights.lent-1, and we get the most max width.
 * volume = lower(height[0], hight[heights.length-1]) * (heights.lentgh - 1)
 * If we want to get the most max answer of the volume, we only can move the left or right boundaries,
 * to reduce the width and get the higher height. So we should move the shorter boundary to get the higher height with shoert width.
 * 
 * We assume height[l] is less than height[r], when we move the boundary l to l + 1,
 * We lose the possible answer S(l, r-1), S(l, r-2), ..., S(l,l+1), but all of these possible answers are less than S(l,r).
 * Becasue the height <= height[l], width <= r-l, so these states cannot become the answer, we don't lose the possible answers.
 * So jsut do it!
 */

class ContainerWithMostWater {
    public int maxArea(int[] height) {
        int l = 0, r = height.length - 1, ans = 0;
        while (l < r) {
            ans = Math.max(ans, Math.min(height[l], height[r]) * (r - l));
            if (height[l] < height[r]) {
                l++;
            } else {
                r--;
            }
        }
        return ans;
    }
}
