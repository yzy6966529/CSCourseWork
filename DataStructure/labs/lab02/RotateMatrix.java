import java.util.Arrays;

/**
 * TODO: I create a new matrix b that store the first row in the old matrix a to b's last column, then
 * 		(first row + 1) in a to (last column - 1) in b, until last row in a that store into the first column in b.
 * 
 * @author <Zhongyu Yang>
 * @author <Zhongyu Yang>
 */

public class RotateMatrix {

  /**
   * Takes an n x n array of integers and rotates it in place in a
   * clockwise direction. Uses at most O(n) extra space.
   */

  public static int[][] rotateCW(int[][] a) {
    int n = a.length;
    // TODO
    int[][] b = new int[n][n];  
    for(int i=0;i<n;i++){  
    		for(int j=0;j<n;j++){  
    			b[n-1-j][n-1-i] = a[i][n-1-j];  
    		}  
    	}  
    return b;  
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
    int[][] afterRotate = rotateCW(a);
    System.out.println("\nafter: ");
    printMatrix(afterRotate);
    
    System.out.println("\n\nbefore: ");
    printMatrix(b);
    int[][] afterRotate2 = rotateCW(b);
    System.out.println("\nafter: ");
    printMatrix(afterRotate2);
    
    System.out.println("\n\nbefore: ");
    printMatrix(c);
    int[][] afterRotate3 = rotateCW(c);
    System.out.println("\nafter: ");
    printMatrix(afterRotate3);
    
    System.out.println("\n\nbefore: ");
    printMatrix(d);
    int[][] afterRotate4 = rotateCW(d);
    System.out.println("\nafter: ");
    printMatrix(afterRotate4);

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
