package ucd.database;

import java.util.HashSet;
import java.util.Random;
import java.util.Set;

public class generaetor {
    private static final String[] all_cards = {
            " ",
            "1C", "2C", "3C", "4C", "5C", "6C", "7C", "8C", "9C", "10C", "JC", "QC", "KC",
            "1D", "2D", "3D", "4D", "5D", "6D", "7D", "8D", "9D", "10D", "JD", "QD", "KD",
            "1H", "2H", "3H", "4H", "5H", "6H", "7H", "8H", "9H", "10H", "JH", "QH", "KH",
            "1S", "2S", "3S", "4S", "5S", "6S", "7S", "8S", "9S", "10S", "JS", "QS", "KS",
    };

    public static void main(String[] args) {
        for (int game_id = 1; game_id <= 4; game_id++) {
            Set<String> used = new HashSet<>();

            //System.out.printf("/* game %d - user 1 - four of a kind */\n", game_id);
            used = generate_four_of_a_kind(1, game_id);
            System.out.println();

            //System.out.printf("/* game %d - user 2 - three of a kind */\n", game_id);
            used = generate_three_of_a_kind(used, 2, game_id);
            System.out.println();

            //System.out.printf("/* game %d - user 3 - straight flush */\n", game_id);
            used = generate_straight_flush(used, 3, game_id);
            System.out.println();

            //System.out.printf("/* game %d - user 4 - bad hand */\n", game_id);
            used = generate_bad_hand(used, 4, game_id);
            System.out.println();

           // System.out.printf("/* game %d - user 5 - bad hand */\n", game_id);
            used = generate_bad_hand(used, 5, game_id);
            System.out.println();
        }
    }

    private static Set<String> generate_four_of_a_kind(int user_id, int game_id) {
        String[] cards;
        boolean error = false;
        Set<String> used;
        while (true) {
            Random rand = new Random();
            int randomNumber = rand.nextInt(13) + 1;
            cards = new String[5];
            used = new HashSet<>();

            for (int i = 0; i < 4; i++) {
                if (used.contains(all_cards[randomNumber])) {
                    error = true;
                    break;
                }
                used.add(all_cards[randomNumber]);
                cards[i] = all_cards[randomNumber];
                randomNumber += 13;
            }

            if (error) {
                continue;
            }

            while (true) {
                randomNumber = rand.nextInt(52) + 1;
                if (!used.contains(all_cards[randomNumber])) {
                    used.add(all_cards[randomNumber]);
                    cards[4] = all_cards[randomNumber];
                    break;
                }
            }

            break;
        }

        for (int i = 0; i < 5; i++) {
            System.out.printf("INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(%d, %d, \"%s\");\n", user_id,
                    game_id, cards[i]);
        }

        return used;
    }

    private static Set<String> generate_three_of_a_kind(Set<String> global_used, int user_id, int game_id) {
        String[] cards;
        boolean error = false;
        Set<String> used;
        while (true) {
            Random rand = new Random();
            int randomNumber = rand.nextInt(13) + 1;
            cards = new String[5];
            used = new HashSet<>(global_used);

            for (int i = 0; i < 3; i++) {
                if (used.contains(all_cards[randomNumber])) {
                    error = true;
                    break;
                }
                used.add(all_cards[randomNumber]);
                cards[i] = all_cards[randomNumber];
                randomNumber += 13;
            }

            if (error) {
                continue;
            }

            while (true) {
                randomNumber = rand.nextInt(52) + 1;
                if (!used.contains(all_cards[randomNumber])) {
                    used.add(all_cards[randomNumber]);
                    cards[3] = all_cards[randomNumber];
                    break;
                }
            }

            while (true) {
                randomNumber = rand.nextInt(52) + 1;
                if (!used.contains(all_cards[randomNumber])) {
                    used.add(all_cards[randomNumber]);
                    cards[4] = all_cards[randomNumber];
                    break;
                }
            }

            break;
        }

        for (int i = 0; i < 5; i++) {
            System.out.printf("INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(%d, %d, \"%s\");\n", user_id,
                    game_id, cards[i]);
        }

        return used;
    }

    private static Set<String> generate_straight_flush(Set<String> global_used, int user_id, int game_id) {
        String[] cards;
        boolean error = false;
        Set<String> used;
        while (true) {
            Random rand = new Random();
            int randomNumber = rand.nextInt(13) + 1;
            if (randomNumber % 13 >= 10 || randomNumber % 13 == 0 || randomNumber == 1) {
                continue;
            }

            cards = new String[5];
            used = new HashSet<>(global_used);

            for (int i = 0; i < 5; i++) {
                if (used.contains(all_cards[randomNumber])) {
                    error = true;
                    break;
                }
                used.add(all_cards[randomNumber]);
                cards[i] = all_cards[randomNumber];
                randomNumber += 1;
            }

            if (!error) {
                break;
            } else {
                error = false;
            }
        }

        for (int i = 0; i < 5; i++) {
            System.out.printf("INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(%d, %d, \"%s\");\n", user_id,
                    game_id, cards[i]);
        }

        return used;
    }

    private static Set<String> generate_bad_hand(Set<String> global_used, int user_id, int game_id) {
        String[] cards;
        boolean error = false;
        Set<String> used;
        while (true) {
            Random rand = new Random();
            cards = new String[5];
            used = new HashSet<>(global_used);

            for (int i = 0; i < 5; i++) {
                int randomNumber = rand.nextInt(52) + 1;
                if (used.contains(all_cards[randomNumber])) {
                    error = true;
                    break;
                }
                used.add(all_cards[randomNumber]);
                cards[i] = all_cards[randomNumber];
            }

            if (!error) {
                break;
            } else {
                error = false;
            }
        }

        for (int i = 0; i < 5; i++) {
            System.out.printf("INSERT INTO poker_hands (UserId, GameId, CardId) VALUES(%d, %d, \"%s\");\n", user_id,
                    game_id, cards[i]);
        }

        return used;
    }

}
