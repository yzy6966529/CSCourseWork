
public class Lab01
{

public static void main(String[] args) {
	// TODO Auto-generated method stub
	int[] a = {0,1,2};
	int[] b = {1,2,3};
	int[] c = {2,3,4};
	int[] d = {0,1,2,3,4,5};

	System.out.println(search(a, d));
	System.out.println(search(b, d));
	System.out.println(search(c, d));

}
	
	
 public static int search(int[] a, int[] b) {

  for (int i = 0; i < b.length - a.length + 1; i++) {
	  boolean firstLetter = true;
	  for (int j = 0; j < a.length; j++)
		  if (a[j] != b[i + j]) {
			  firstLetter = false;
			  break;
	  }
	  if (firstLetter) {
		  return i;
	  }  
  }

  return -1;
 }

 

}
