package HW2;

import java.util.Arrays;

/**
 * We implement a slightly modified version of the algorithm described in
 * Problem 2.26 (pg 54) of Weiss. This modification handles odd-length arrays.
 * 
 * A majority element in an array, A, of size n is an element that appears n / 2
 * times (thus, there is at most one).
 * 
 * Algorithm: First, identify one or two candidates for the majority element
 * using the process described below. If no candidates are identified during
 * this step, then there is no majority in A, so stop. Otherwise, for each
 * candidate, determine if it is actually the majority using a sequential search
 * through the array.
 * 
 * To find the candidates in the array A, form a second array B. Then compare
 * A_1 and A_2. If they are equal, add one of these to B; otherwise do nothing.
 * Then compare A_3 and A_4. Again if they are equal, add one of these to B;
 * otherwise do nothing. Continue in this fashion until the entire array is
 * read. If the length of A is odd, then add the last element to B. Then
 * recursively find the one or two majority candidates for B; these will be
 * candidates for A.
 */

public class Majority {

	/**
	 * Returns the majority element in a, if one exists. Otherwise, a
	 * NoMajorityException is thrown.
	 */
	public static int majority(int[] a) {
		int[] b = findCandidates(a);
		assert b.length <= 2;
		for (int x : b)
			if (isMajority(x, a))
				return x;
		throw new NoMajorityException();
	}

	/**
	 * Returns an array of 0, 1, or 2 candidates for majority element in a.
	 * Implement the recursive algorithm described in the main comment.
	 */

	public static int[] findCandidates(int[] a) {
		if (a.length == 1 || a.length == 2 || a.length ==0) {
			return a;
		}

		if (a.length % 2 == 1) {
			int b[] = new int[(a.length - 1) / 2];
			int j = 1;

			if (a.length % 2 == 1) {
				b[0] = a[a.length - 1];
			}
			for (int i = 1; i <= a.length - 1; i += 2) {

				if (a[i - 1] == a[i]) {
					b[j] = a[i - 1];
					j++;
				}
			}
			return findCandidates(b);
		} else if (a.length % 2 == 0) {
			int b[] = new int[a.length / 2];
			int j = 1;

			if (a.length % 2 == 1) {
				b[0] = a[a.length - 1];
			}
			for (int i = 1; i <= a.length - 1; i += 2) {

				if (a[i - 1] == a[i]) {
					b[j] = a[i - 1];
					j++;
				}
			}
			return findCandidates(b);
		}
		
		return a;

	}

	/**
	 * Returns true iff x appears in more than half of the elements of a.
	 */
	public static boolean isMajority(int x, int[] a) {
		int count = 0, n = a.length;
		for (int i = 0; i < n; i++)
			if (x == a[i])
				count++;
		return count > n / 2;
	}

	/**
	 * Asserts that the majority exists in a and is the same as expected.
	 */
	public static void checkExpect(int expected, int[] a) {
		try {
			assert expected == majority(a);
		} catch (NoMajorityException ex) {
			assert false;
		}
	}

	/**
	 * Asserts that a has no majority element.
	 */
	public static void checkException(int[] a) {
		try {
			majority(a);
			assert false;
		} catch (NoMajorityException ex) {
			assert true;
		}
	}

	/**
	 * Run some tests.
	 */
	public static void main(String... args) {
		checkExpect(4, new int[] { 3, 3, 4, 2, 4, 4, 2, 4, 4 });
		checkException(new int[] { 3, 3, 4, 2, 4, 4, 2, 4 });
		checkExpect(1, new int[] { 1, 2, 1, 2, 1, 2, 1, 2, 1 });
		checkExpect(2, new int[] { 1, 2, 1, 2, 1, 2, 1, 2, 2 });
		checkException(new int[] { 1, 2, 1, 2, 1, 2, 1, 2, 3 });
		checkExpect(1, new int[] { 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, });
		checkException(new int[] {});
		checkExpect(5, new int[] { 5 });
		checkException(new int[] { 1, 2 });
		checkExpect(1, new int[] { 1, 1 });
		checkException(new int[] { 1, 2, 3 });
		checkExpect(1, new int[] { 1, 1, 2 });
		checkExpect(1, new int[] { 1, 2, 1 });
		checkExpect(1, new int[] { 2, 1, 1 });
		checkExpect(1, new int[] { 1, 1, 1 });		
	}
}

class NoMajorityException extends RuntimeException {

}