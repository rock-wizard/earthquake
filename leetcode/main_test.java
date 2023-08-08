package leetcode;

import java.util.PriorityQueue;

public class main_test {
    public static void main(String[] args) {
        PriorityQueue<String> q = new PriorityQueue<>((x, y) -> {
            System.out.println("x: " + x + "  y: " + y + " " + x.compareTo(y));
            return -1 * x.compareTo(y);
        });

        String s1 = "i";
        String s2 = "love";

        q.add(s2);
        q.add(s1);

        while (!q.isEmpty()) {
            System.out.println(q.poll());
        }

        Integer i1 = 1;
        Integer i2 = 2;
        System.out.print(i1.compareTo(i2));

    }
}
