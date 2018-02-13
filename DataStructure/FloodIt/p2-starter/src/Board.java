import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * A Board represents the current state of the game. Boards know their
 * dimension, the collection of tiles that are inside the current flooded
 * region, and those tiles that are on the outside.
 * 
 * @author <Zhongyu Yang>
 */

public class Board {
	private Map<Coord, Tile> inside, outside;
	private int size;

	/**
	 * Constructs a square game board of the given size, initializes the list of
	 * inside tiles to include just the tile in the upper left corner, and puts
	 * all the other tiles in the outside list.
	 */
	public Board(int size) {
		// A tile is either inside or outside the current flooded region.
		inside = new HashMap<>();
		outside = new HashMap<>();
		this.size = size;
		for (int y = 0; y < size; y++)
			for (int x = 0; x < size; x++) {
				Coord coord = new Coord(x, y);
				outside.put(coord, new Tile(coord));
			}
		// Move the corner tile into the flooded region and run flood on its
		// color.
		Tile corner = outside.remove(Coord.ORIGIN);
		inside.put(Coord.ORIGIN, corner);
		flood(corner.getColor());
	}

	/**
	 * Returns the tile at the specified coordinate.
	 */
	public Tile get(Coord coord) {
		if (outside.containsKey(coord))
			return outside.get(coord);
		return inside.get(coord);
	}

	/**
	 * Returns the size of this board.
	 */
	public int getSize() {
		return size;
	}

	/**
	 * TODO
	 * 
	 * Returns true iff all tiles on the board have the same color.
	 */

	/**
	 * 
	 * @return true iff all tiles on the board have the same color.
	 */
	public boolean fullyFlooded() {
		if (outside.size() == 0) {
			// if there is no key value pair in `outside`, then the board is
			// fullyFlooded.
			return true;
		}
		return false;
	}

	/**
	 * TODO
	 * 
	 * Updates this board by changing the color of the current flood region and
	 * extending its reach.
	 */
	/**
	 * 
	 * @param color
	 */
	public void flood(WaterColor color) {

		for (int y = 0; y < size; y++)
			for (int x = 0; x < size; x++) {
				Coord coord = new Coord(x, y);
				if (inside.get(coord) != null) {
					Tile tile = get(coord);
					tile.setColor(color);
					for (Coord nbh : coord.neighbors(size)) {
						if (inside.get(nbh) == null && outside.get(nbh) != null && get(nbh).getColor() == color) {
							Tile nbTile = outside.get(nbh);
							outside.remove(nbh);
							inside.put(nbh, nbTile);
						}
					}
				}
			}

	}

	/**
	 * TODO
	 * 
	 * Explore a variety of algorithms for handling a flood. Use the same
	 * interface as for flood above, but add an index so your methods are named
	 * flood1, flood2, ..., and so on. Then, use the batchTest() tool in Driver
	 * to run game simulations and then display a graph showing the run times of
	 * all your different flood functions. Do not delete your flood code
	 * attempts. For each variety of flood, including the one above that you
	 * eventually settle on, write a comment that describes your algorithm in
	 * English. For those implementations that you abandon, state your reasons.
	 */
	public void flood1(WaterColor color) {
		/*
		 * Approach: For each tile, if the tile is inside region, we just update
		 * the color and pass, and if it is in outside region. If if it is also
		 * neighbor of some 'inside' region tile, we will add the tile, and is
		 * also of color which is clicked, then add coordinate of the tile to
		 * inside and remove it from 'outside'.
		 */
		for (int y = 0; y < size; y++)
			for (int x = 0; x < size; x++) {
				Coord coord = new Coord(x, y);
				if (inside.get(coord) != null) {
					// if coord is inside
					Tile tile = get(coord);
					tile.setColor(color);
					continue;
				} else {
					// if coord is 'outside'
					for (Coord nbh : coord.neighbors(size)) {
						if (inside.get(nbh) != null) {
							// the tile at coord is needed to be added to
							// inside region.
							Tile outTile = outside.get(coord);
							if (outTile.getColor() == color) {
								outside.remove(coord);
								inside.put(coord, outTile);
								break;
							}
						}
					}
				}

			}

	}

	public void flood2(WaterColor color) {
		/*
		 * Approach: For each tile, if the tile is inside region, we just update
		 * the color and pass, and if it is in outside region, then we check if
		 * its color is same as that of new clicked color. Only in this case, if
		 * it is neighbor of some 'inside' region tile, we will add the tile
		 * coordinate to inside and remove it from outside.
		 * 
		 * This approach is better than that of flood1, because here instead of
		 * checking the neighbors first, we simply check if it is of same color
		 * which is clicked. This saves the time which otherwise would have been
		 * wasted in iterating over the neighbors for those tiles which do not
		 * have the clicked color.
		 */
		for (int y = 0; y < size; y++)
			for (int x = 0; x < size; x++) {
				Coord coord = new Coord(x, y);
				if (inside.get(coord) != null) {
					// if coord is inside
					Tile tile = get(coord);
					tile.setColor(color);
					continue;
				} else {
					// if coord is 'outside'
					if (get(coord).getColor() == color) {
						for (Coord nbh : coord.neighbors(size)) {
							if (inside.get(nbh) != null) {
								// the tile at is coord needed to be added to
								// inside region.
								Tile outTile = outside.get(coord);
								outside.remove(coord);
								inside.put(coord, outTile);
								break;
							}
						}
					}
				}

			}

	}

	/**
	 * TODO
	 * 
	 * Returns the "best" GameColor for the next move.
	 * 
	 * Modify this comment to describe your algorithm. Possible strategies to
	 * pursue include maximizing the number of tiles in the current flooded
	 * region, or maximizing the size of the perimeter of the current flooded
	 * region.
	 */
	/**
	 * 
	 * @param wc
	 * @return count of color
	 */
	public int getColorCount(WaterColor wc) {
		/**
		 * Function to support the working of suggest function. It takes the
		 * WaterColor and returns the number of tiles that will be added to
		 * inside if that color is clicked.
		 */
		List<Tile> tilesChecked = new ArrayList<>(); // to hold the Tiles which
														// are already counted.
		Map<Coord, Tile> tempInside = new HashMap<>();
		int countColorWC = 0;
		// Lets initialize tempInside as equal to Inside.

		for (int y = 0; y < size; y++)
			for (int x = 0; x < size; x++) {
				Coord coord = new Coord(x, y);
				if (inside.get(coord) != null) {
					tempInside.put(coord, new Tile(coord));
				}
			}
		for (int y = 0; y < size; y++)
			for (int x = 0; x < size; x++) {
				Coord coord = new Coord(x, y);
				if (tempInside.get(coord) == null && get(coord).getColor() == wc) {
					for (Coord nbh : coord.neighbors(size)) {
						Tile tile = get(coord);
						if (tempInside.get(nbh) != null && !tilesChecked.contains(tile)) {
							countColorWC += 1;
							tilesChecked.add(tile);
							tempInside.put(coord, tile); // now the tile at
															// coord is also
															// part of
															// tempInside
						}
					}
				}

			}
		;
		return countColorWC;

	}

	/**
	 * 
	 * @return the "best" GameColor for the next move.
	 */
	public WaterColor suggest() {

		/**
		 * The strategy used here is as follows: Our task is to maximize the
		 * number of tiles in the 'inside' region, therefore we will find that
		 * color, which will result in addition of maximum number of tiles to
		 * inside region.
		 */

		WaterColor[] colors = WaterColor.values();
		Map<WaterColor, Integer> colorCount = new HashMap(); // Map to hold the
																// number of
																// tiles of
																// given color
																// which
																// "touches" the
																// inside region
		// Now we will find the color with maximum number in the hashmap
		// colorCount
		WaterColor maxCountColor = colors[0];
		int count, maxCount = 0;
		for (WaterColor wc : colors) {
			count = getColorCount(wc);
			if (count > maxCount) {

				maxCount = count;
				maxCountColor = wc;
			}

		}

		return maxCountColor;
	}

	/**
	 * Returns a string representation of this board. Tiles are given as their
	 * color names, with those inside the flooded region written in uppercase.
	 */
	public String toString() {
		StringBuilder ans = new StringBuilder();
		for (int y = 0; y < size; y++) {
			for (int x = 0; x < size; x++) {
				Coord curr = new Coord(x, y);
				WaterColor color = get(curr).getColor();
				ans.append(inside.containsKey(curr) ? color.toString().toUpperCase() : color);
				ans.append("\t");
			}
			ans.append("\n");
		}
		return ans.toString();
	}

	/**
	 * Simple testing.
	 */
	public static void main(String... args) {
		// Print out boards of size 1, 2, ..., 5
		// int n = 5;
		// for (int size = 1; size <= n; size++) {
		// Board someBoard = new Board(size);
		// System.out.println(someBoard);
		// }
		// testing fullyFlooded function
		Board br = new Board(2);
		if (br.get(Coord.ORIGIN).getColor() == br.get(new Coord(0, 1)).getColor()
				&& br.get(new Coord(0, 1)).getColor() == br.get(new Coord(1, 0)).getColor()
				&& br.get(new Coord(1, 0)).getColor() == br.get(new Coord(1, 1)).getColor()) {
			System.out.println("Should be True: " + br.fullyFlooded());
		} else {
			System.out.println("Should be False:" + br.fullyFlooded());
		}
		// testing flood function
		int testSize = 5;
		br = new Board(testSize);
		List<Tile> tiles1 = new ArrayList<>(); // to hold the Tiles object
		List<Tile> tiles2 = new ArrayList<>(); // to hold the Tiles object
		for (int y = 0; y < testSize; y++)
			for (int x = 0; x < testSize; x++) {
				tiles1.add(br.get(new Coord(x, y)));
			}
		// Flood function should not modify the tiles if we apply flood function
		// with the same color as that of origin as the argument.
		br.flood(br.get(Coord.ORIGIN).getColor());
		// Now we will fill check if the tiles1 is same as previous or not.
		int i = 0;
		boolean flag = true;
		for (int y = 0; y < testSize; y++)
			for (int x = 0; x < testSize; x++) {
				if (tiles1.get(i) != br.get(new Coord(x, y)))
					flag = false;
				i += 1;
			}
		System.out.println("Should be True: " + flag); // flag must be true if
														// the flood function is
														// correct
	}

}