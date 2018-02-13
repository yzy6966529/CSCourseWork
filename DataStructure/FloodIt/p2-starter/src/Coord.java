import java.util.ArrayList;
import java.util.List;

/**
 * Coord represents an (x,y)-coordinate on a 2D board. The origin, (0,0) is
 * assumed to be in the upper left corner. X-coordinates increase from left
 * to right. Y-coordinates increase from top to bottom. Operations are provided
 * to easily locate neighboring coordinates (in the NSEW compass directions)
 * on a board.
 * 
 * @author <Zhongyu Yang>
 */

public class Coord implements Comparable<Coord> {
  /**
   *  The upper left corner of the board.
   */
  public static Coord ORIGIN = new Coord(0, 0);
  
  private int x, y;

  /**
   * Constructs a new Coord that is a copy of the given Coord.
   */
  public Coord(Coord coord) {
    this(coord.x, coord.y);
  }

  /**
   * Constructs a new Coord representing (x,y).
   */
  public Coord(int x, int y) {
    this.x = x;
    this.y = y;
  }

  /**
   * Returns the Coord that is directly above (i.e., north of) this one.
   */
  public Coord up() {
    return new Coord(x, y - 1);
  }

  /**
   * Returns the Coord that is directly below (i.e., south of) this one.
   */
  public Coord down() {
    return new Coord(x, y + 1);
  }

  /**
   * Returns the Coord that is immediately to the left (i.e., west)
   * of this one.
   */
  public Coord left() {
    return new Coord(x - 1, y);
  }

  /**
   * Returns the Coord that is immediately to the right (i.e., east)
   * of this one.
   */
  public Coord right() {
    return new Coord(x + 1, y);
  }

  /**
   * TODO
   * 
   * Returns true iff this Coord is visible on a board of the given size.
   */
  /**
   * 
   * @param size
   * @return true iff this Coord is visible on a board of the given size.
   */
  public boolean onBoard(int size) {
      if (x<size && y<size && x>=0 && y>=0){
          //if x and y both are in the range [0,size-1] then it implies
          //that (x,y) is on the Board, hence return true.
      return true;
  }
    return false;
  }

  /**
   * TODO
   * 
   * Returns a list of the immediate board coordinates of this Coord's north,
   * south, east, and west neighbors.
   */
  /**
   * 
   * @param size
   * @return a list of the immediate board coordinates of this Coord's north,
   * south, east, and west neighbors.
   */
  public List<Coord> neighbors(int size) {
    List<Coord> out = new ArrayList<>();//create a new ArrayList of Coords
    if (y>0){
    out.add(up()); //add up() to it.
    }
    if (y<size){
    out.add(down()); //add down() to it
    }
    if (x>0){
    out.add(left()); //add left() to it
    }
    if (x<size){
    out.add(right()); //add right() to it
    }
    return out;
    
  }

  /**
   * Returns true iff the (x,y)-coordinates of the given object match this Coord's
   * (x,y)-coordinates.
   */
  public boolean equals(Object obj) {
    if (obj instanceof Coord) {
      Coord that = (Coord) obj;
      return that.x == this.x && that.y == this.y;
    }
    return false;
  }

  /**
   * Coords are ordered first on the x-coordinate and then on the y-coordinate.
   */
  public int compareTo(Coord that) {
    if (this.x == that.x)
      return this.y - that.y;
    return this.x - that.x;
  }

  /**
   * Returns the x-coordinate.
   */
  public int getX() {
    return x;
  }

  /**
   * Returns the y-coordinate.
   */
  public int getY() {
    return y;
  }

  /**
   * TODO
   * 
   * Pre-hashing: pack this coordinate into an int, so that the key space is
   * as uniformly distributed among the range of integers as possible.
   */
  /**
   * @return the code after hash
   */
  public int hashCode() {
      /*
      We want a hash function which can differentiate between (x,y) and (y,x).
      Therefore we will use following formula, (x<<10+y).
      */
    int code = (x<<10) + y;
    return code;
  }

  /**
   * Returns this Coord as a string of the form (x, y).
   */
  public String toString() {
    return "(" + x + ", " + y + ")"; 
  }
  
  /**
   * Simple testing.
   */
  public static void main(String... args) {
    Coord someCoord = new Coord(2, 1);
    System.out.println("someCoord = " + someCoord);
    System.out.println("someCoord.hashCode() = " + someCoord.hashCode());
    System.out.println("someCoord.onBoard(4) = " + someCoord.onBoard(4));
    System.out.println("neighbors on a 3x3 board = " + someCoord.neighbors(3));
    System.out.println("neighbors on a 4x4 board = " + someCoord.neighbors(4));   
    System.out.println(new Coord(1,2).hashCode() == new Coord(2,1).hashCode());
    System.out.println(new Coord(31,12).hashCode() != new Coord(21,13).hashCode());
    System.out.println(new Coord(5,5).hashCode() == new Coord(6,6).hashCode());
    
    someCoord = ORIGIN;
    System.out.println("someCoord = " + someCoord);
    System.out.println("someCoord.hashCode() = " + someCoord.hashCode());
    System.out.println("someCoord.onBoard(3) = " + someCoord.onBoard(3));
    System.out.println("neighbors on a 3x3 board = " + someCoord.neighbors(3));
    System.out.println("neighbors on a 1x1 board = " + someCoord.neighbors(1));   
    System.out.println();

    someCoord = new Coord(5, 5);
    System.out.println("someCoord = " + someCoord);
    System.out.println("someCoord.hashCode() = " + someCoord.hashCode());
    System.out.println("someCoord.onBoard(5) = " + someCoord.onBoard(5));
    System.out.println("neighbors on a 3x3 board = " + someCoord.neighbors(3));
    System.out.println("neighbors on a 6x6 board = " + someCoord.neighbors(6));
    System.out.println(new Coord(0,0).neighbors(5).containsAll(new Coord(0,0).neighbors(10)));
      System.out.println(new Coord(0,1).neighbors(5).containsAll(new Coord(1,0).neighbors(10)));
      System.out.println(new Coord(1,1).neighbors(5).contains(new Coord(1,2)));
      System.out.println(new Coord(1,1).neighbors(5).contains(new Coord(2,1)));
      System.out.println(new Coord(1,1).neighbors(5).contains(new Coord(0,1)));
      System.out.println(new Coord(1,1).neighbors(5).contains(new Coord(1,0)));
    }
}
