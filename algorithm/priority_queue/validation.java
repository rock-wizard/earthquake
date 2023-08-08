package algorithm.priority_queue;

import java.util.Comparator;
import java.util.PriorityQueue;

public class validation {

    
    public static void main(String[] args) {
        PriorityQueue<String> pq = new PriorityQueue<String>(new CustomComparator());
        pq.offer("banana");
        pq.offer("apple");
        pq.offer("cherry");
        pq.offer("date");
        
        while (!pq.isEmpty()) {
            System.out.print(pq.poll() + " ");
        }
    }

}

class CustomComparator implements Comparator<String> {
    public int compare(String s1, String s2) {
        return s2.compareTo(s1);
    }
}
