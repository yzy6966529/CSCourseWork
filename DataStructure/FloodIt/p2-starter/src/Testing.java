import java.util.ArrayList;
import java.util.List;
import static org.junit.Assert.*;

import org.junit.Test;

/**
 * JUnit tests for all TODO methods.
 */

public class Testing {
  
  @Test
  public void testOnBoard() {
    assertFalse(new Coord(3, 4).onBoard(4));
    assertTrue(new Coord(3, 4).onBoard(5));
  }
  @Test
  public void testHashCode(){
      //test on hashCode function
      assertTrue(new Coord(1,2).hashCode() != new Coord(2,1).hashCode());
      assertTrue(new Coord(31,12).hashCode() != new Coord(21,13).hashCode());
      assertFalse(new Coord(5,5).hashCode() == new Coord(6,6).hashCode());
  }
  @Test
  public void testNeighbors(){
      //test on hashCode function
      assertTrue(new Coord(0,0).neighbors(5).containsAll(new Coord(0,0).neighbors(10)));
      assertFalse(new Coord(0,1).neighbors(5).containsAll(new Coord(1,0).neighbors(10)));
      assertTrue(new Coord(1,1).neighbors(5).contains(new Coord(1,2)));
      assertTrue(new Coord(1,1).neighbors(5).contains(new Coord(2,1)));
      assertTrue(new Coord(1,1).neighbors(5).contains(new Coord(0,1)));
      assertTrue(new Coord(1,1).neighbors(5).contains(new Coord(1,0)));
  }
  @Test
  public void testFullyFlooded(){
      assertTrue(new Board(1).fullyFlooded()); //1 element board must be fullyFlooded
      Board br = new Board(2);
      if (br.get(Coord.ORIGIN).getColor() == br.get(new Coord(0,1)).getColor() &&
              br.get(new Coord(0,1)).getColor() ==br.get(new Coord(1,0)).getColor() &&
              br.get(new Coord(1,0)).getColor() == br.get(new Coord(1,1)).getColor() ){
          assertTrue(br.fullyFlooded());
      }
      else{
      assertFalse(br.fullyFlooded());
      }
      
      
  }
 @Test
 public void testFlood(){
     /*Test of Flood function.
      */
     //To access the Board, we will first create lists of all the tiles of
     //board and compare them appropriately.
     int size = 5;
     Board br = new Board(size);
     List<Tile> tiles1 = new ArrayList<>(); //to hold the Tiles object
     List<Tile> tiles2 = new ArrayList<>(); //to hold the Tiles object
     for (int y=0; y<size;y++)
         for(int x=0;x<size;x++){
             tiles1.add(br.get(new Coord(x,y)));
         }
     //Flood function should not modify the tiles if we apply flood function
     //with the same color as that of origin as the argument.
     br.flood(br.get(Coord.ORIGIN).getColor());
     //Now we will fill check if the tiles1 is same as previous or not.
     int i=0;
     boolean flag = true;
     for (int y=0; y<size;y++)
         for(int x=0;x<size;x++){
             if (tiles1.get(i) != br.get(new Coord(x,y))) flag = false;
             i+=1;
         }
     assertTrue(flag); //flag must be true if the flood function is correct          
         
     }
    
 
  @Test
  public void testSuggest(){
      //We will test suggest function by flooding the board with output of suggest
      //function for not more than maxSteps number of times. Then we
      //will check if Board is fullyFlooded, if this is the case then the function
      //suggest is giving correct suggestions.
      //If suggestions were not correct, then the Board should not be fullyFlooded
      //at the end of iterations.
      
      int size = 15;
      int maxSteps = size * 25 / 14 + 1;
      Board br = new Board(size);
      for (int i=0;i<maxSteps;i++){
          br.flood(br.suggest());
          if (br.fullyFlooded()) break;
      }
      System.out.println(br.fullyFlooded());
      assertTrue(br.fullyFlooded());
      //Second test of the same kind.
      size = 20;
      maxSteps = size * 25 / 14 + 1;
      br = new Board(size);
      for (int i=0;i<maxSteps;i++){
          br.flood(br.suggest());
          if (br.fullyFlooded()) break;
      }
      assertTrue(br.fullyFlooded());
  }
}
