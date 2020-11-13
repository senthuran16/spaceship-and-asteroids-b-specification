/* Space
* Author: Senthuran Ambalavanar | 2015215 | w1608452
* Creation date: 24/11/2018
*/
MACHINE
    Space
    
CONSTANTS
    spaceX, spaceY, space, asteroids, emptySpace, homeBase, starBase
    
PROPERTIES
    // The known space
    spaceX = 1..12 &
    spaceY = 1..7 &
    space = spaceX * spaceY &
    
    // Asteroids
    asteroids <: space &
    asteroids = {3|->2, 3|->5, 5|->4, 6|->7, 7|->1, 7|->5, 7|->7, 8|->3, 10|->6, 11|->2, 12|->5} &
    
    // Empty Space
    emptySpace <: space &
    emptySpace /\ asteroids = {} &
    emptySpace \/ asteroids = space &
    
    // Home base and Star Base
    homeBase : emptySpace & homeBase = 1|->1 &
    starBase : emptySpace & starBase = 6|->4
END
