/**
 * Starter code for lab5. This is an implementation of BinarySearchTree for int
 * data.
 * 
 * Implement the remove() method using the algorithm described by your AI.
 *
 * @author <>
 */

public class BinarySearchTree implements Tree {

	class Node {
		int data;
		Node left, right;

		Node(int key) {
			this(key, null, null);
		}

		Node(int data, Node left, Node right) {
			this.data = data;
			this.left = left;
			this.right = right;
		}

		boolean isLeaf() {
			return left == null && right == null;
		}
	}

	Node root;
	int n;

	public Node removeHelper(Node root, int key) {

		if (root == null) {
			return root;
		}

		if (key < root.data) {
			root.left = removeHelper(root.left, key);
		} else if (key > root.data) {
			root.right = removeHelper(root.right, key);

		} else {
			// case1: only have one child
			if (root.left == null) {
				return root.right;
			} else if (root.right == null) {
				return root.left;
			} else {
				// case2: when there are two children
				root.data = findMinHelper(root.right);
				root.right = removeHelper(root.right, root.data);
			}
		}
		return root;
	}

	/**
	 * TODO
	 * 
	 * Removes the key from this tree. Must run in O(h) time, where h is the height
	 * of the tree.
	 */
	public void remove(int key) {
		// arrange things so that attempts to remove key that are
		// not in the tree are simply ignored (and do no harm).
		if (this.contains(key)) {
			n--;
		}
		root = removeHelper(root, key);
	}

	// find the minimum number in the nood
	public int findMinHelper(Node root) {
		int min = root.data;
		while (root.left != null) {
			min = root.left.data;
			root = root.left;
		}
		return min;
	}

	public int findMin() {
		return findMinHelper(root);
	}

	// find the max number in the nood
	public int findMaxHelper(Node root) {
		int max = root.data;
		while (root.right != null) {
			max = root.right.data;
			root = root.right;
		}
		return max;
	}

	public int findMax() {
		return findMaxHelper(root);
	}

	/**
	 * Inserts the key into this tree. Runs in O(h) time, where h is the height of
	 * the tree.
	 */
	public void insert(int key) {
		n++;
		root = insertHelper(key, root);
	}

	private Node insertHelper(int key, Node p) {
		if (p == null)
			p = new Node(key);
		else if (key < p.data)
			p.left = insertHelper(key, p.left);
		else
			// if keys are unique, it must be the case that key > p.data
			p.right = insertHelper(key, p.right);
		return p;
	}

	/**
	 * Returns true iff key is in this tree. Runs in O(h) time, where h is the
	 * height of the tree.
	 */
	public boolean contains(int key) {
		return containsHelper(key, root);
	}

	private boolean containsHelper(int key, Node p) {
		if (p == null)
			return false;
		if (key == p.data)
			return true;
		if (key < p.data)
			return containsHelper(key, p.left);
		return containsHelper(key, p.right);
	}

	/**
	 * Returns the number of keys in this tree.
	 */
	public int size() {
		return n;
	}

	public void printNode(Node node) {
		System.out.println(node.data);
	}

	/**
	 * Testing.
	 */
	public static void main(String... args) {
		int[] a = new int[] { 3, 9, 7, 2, 1, 5, 6, 4, 8 };
		int[] b = new int[] { 1, 6, 4, 5, 8, 9, 7, 2 };
		Tree bst = new BinarySearchTree();
		assert bst.isEmpty();
		for (int key : a)
			bst.insert(key);
		assert bst.size() == a.length;

		for (int key : a)
			assert bst.contains(key);

		// test remove a leaf node
		Tree bstFirst = new BinarySearchTree();
		for (int key : a)
			bstFirst.insert(key);
		bstFirst.remove(7);
		assert !bstFirst.contains(7);

		// test remove node of only one child 
		Tree bstSec = new BinarySearchTree();
		for (int key : a)
			bstSec.insert(key);
		bstSec.remove(9);
		assert !bstSec.contains(9);

		// test find minimum value in a
		assert bstSec.findMin() == 1;

		// test remove a node of two children 
		Tree bstThird = new BinarySearchTree();
		for (int key : a)
			bstThird.insert(key);
		bstThird.remove(7);
		assert !bstThird.contains(7);
		

		bst.remove(5);
		for (int key : b)
			assert bst.contains(key);
		assert !bst.contains(5);
		int n = bst.size();

		for (int key : b) {
			assert bst.contains(key);
			bst.remove(key);
			assert !bst.contains(key);
			n--;
			assert n == bst.size();
		}
		assert bst.isEmpty();
		System.out.println("Passed all the basic tests...");

		/**
		 * TODO: As a challenge, arrange things so that attempts to remove key that are
		 * not in the tree are simply ignored (and do no harm).
		 */
		for (int key : a)
			bst.insert(key);
		n = bst.size();
		for (int key : a) {
			bst.remove(-key);
			assert n == bst.size();
		}
		System.out.println("Passed challenge tests...");
	}
}

interface Tree {
	void insert(int key);

	default void remove(int key) {
		throw new UnsupportedOperationException();
	}

	boolean contains(int key);

	int size();

	default boolean isEmpty() {
		return size() == 0;
	}

	int findMin();
}
