import java.util.Arrays;

/**
 * TODO: From the outermost layer to the inside layer gradually,  And change 
 *  		 index one by one, the space complexity is 1, and the time complexity is O (n2).
 * @author <Zhongyu Yang>
 * @author <Zhongyu Yang>
 */

public class RotateMatrix2 {

  /**
   * Takes an n x n array of integers and rotates it in place in a
   * clockwise direction. Uses at most O(n) extra space.
   */

  public static void rotateCW(int[][] a) {
    int n = a.length;
    // TODO
    for (int i = 0; i < n/2; i++)  
    {  
        int first = i;  
        int last = n-1-i;  
        for (int j = first; j < last; j++)  
        {  
            int offset = j - first;  
            int top = a[first][j];  
            a[first][j] = a[last - offset][first];  
            a[last - offset][first] = a[last][last - offset];  
            a[last][last - offset] = a[j][last];  
            a[j][last] = top;  
        }  
    }  
  }

  public static void printMatrix(int[][] a) {
    for (int[] row : a)
      System.out.println(Arrays.toString(row));
  }

  public static void main(String[] args) {
	  int[][] a;
	    a = new int[][] {
	        { 11, 12, 13, 14, 15 },
	        { 26, 27, 28, 29, 16 },
	        { 25, 34, 35, 30, 17 },
	        { 24, 33, 32, 31, 18 },
	        { 23, 22, 21, 20, 19 },
	    };
	    
	    int[][] b = new int[][] {
	        { 5 },
	    };
	    
	    int[][] c = new int[][] {
	        { 1, 2 },
	        { 4, 3 },
	    };

	    int[][] d = new int[][] {
	        { 1, 1, 1, 1, 1, 1 },
	        { 1, 2, 2, 2, 2, 1 },
	        { 1, 2, 3, 4, 2, 1 },
	        { 1, 2, 6, 5, 2, 1 },
	        { 1, 2, 2, 2, 2, 1 },
	        { 1, 1, 1, 1, 1, 1 },
	    };
	 
	    System.out.println("before: ");
	    printMatrix(a);
	    rotateCW(a);
	    System.out.println("\nafter: ");
	    printMatrix(a);
	    
	    System.out.println("\n\nbefore: ");
	    printMatrix(b);
	    rotateCW(b);
	    System.out.println("\nafter: ");
	    printMatrix(b);
	    
	    System.out.println("\n\nbefore: ");
	    printMatrix(c);
	    rotateCW(c);
	    System.out.println("\nafter: ");
	    printMatrix(c);
	    
	    System.out.println("\n\nbefore: ");
	    printMatrix(d);
	    rotateCW(d);
	    System.out.println("\nafter: ");
	    printMatrix(d);

    /* Expected output:
    
       before: 
       [11, 12, 13, 14, 15]
       [26, 27, 28, 29, 16]
       [25, 34, 35, 30, 17]
       [24, 33, 32, 31, 18]
       [23, 22, 21, 20, 19]

       after: 
       [23, 24, 25, 26, 11]
       [22, 33, 34, 27, 12]
       [21, 32, 35, 28, 13]
       [20, 31, 30, 29, 14]
       [19, 18, 17, 16, 15]

     */
    
    /* Other matrices you should test:
     
       a = new int[][] {
           { 5 },
       };
       
       a = new int[][] {
           { 1, 2 },
           { 4, 3 },
       };

       a = new int[][] {
           { 1, 1, 1, 1, 1, 1 },
           { 1, 2, 2, 2, 2, 1 },
           { 1, 2, 3, 4, 2, 1 },
           { 1, 2, 6, 5, 2, 1 },
           { 1, 2, 2, 2, 2, 1 },
           { 1, 1, 1, 1, 1, 1 },
       };
    */ 
  }
}
