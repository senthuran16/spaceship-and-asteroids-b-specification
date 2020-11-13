/* SpaceShip
* Author: Senthuran Ambalavanar | 2015215 | w1608452
* Creation date: 24/11/2018
*/
MACHINE
    SpaceShip

SEES
    Space

SETS
    REPORT = { SUCCESSFULLY_MOVED , CANNOT_MOVE_OUT_OF_KNOWN_SPACE , INSUFFICIENT_POWER , HIT_ASTEROID , CANNOT_WARP_INTO_ASTEROID , CANNOT_WARP_TO_THE_SAME_POSITION , CANNOT_IMMEDIATELY_WARP_INTO_STARBASE } ;
    MOVEMENT = { MOVE_UP , MOVE_DOWN , MOVE_FORWARD , MOVE_BACKWARD , WARP } ;
    DOCKED_STATUS = { YES , NO } ;
    GAME_STATUS = { GAME_WON , GAME_LOST , GAME_NOT_OVER }

CONCRETE_CONSTANTS
    normalMovePower , warpDrivePower , asteroidHitPowerLoss , initialPower

PROPERTIES
    normalMovePower = 5 &
    warpDrivePower = 20 &
    asteroidHitPowerLoss = 10 &
    initialPower = 100



































ABSTRACT_VARIABLES
    xPosition , yPosition , power , noOfCollisions , takenRoute , movements

INVARIANT
    xPosition : spaceX &
    yPosition : spaceY &
    xPosition |-> yPosition : emptySpace &
    power : NAT &
    noOfCollisions : NAT &
    takenRoute : seq ( emptySpace ) &
    movements : seq ( MOVEMENT )

INITIALISATION
    power := initialPower ||
    noOfCollisions := 0 ||
    xPosition := prj1 ( spaceX , spaceY ) ( homeBase ) ||
    yPosition := prj2 ( spaceX , spaceY ) ( homeBase ) ||
    takenRoute := [ homeBase ] ||
    movements := <>

OPERATIONS
    /** Moves Up **/
    report , movement <-- MoveUp =
    PRE
        report : REPORT & movement : MOVEMENT & not ( ( xPosition |-> yPosition = starBase ) or ( power < normalMovePower ) )
    THEN
        IF
            ( power >= normalMovePower )
        THEN
            IF
                ( xPosition |-> yPosition + 1 : space )
            THEN
                IF
                    not ( ( xPosition |-> yPosition + 1 : asteroids ) )
                THEN
                    IF
                        ( power - normalMovePower >= 0 )
                    THEN
                        yPosition := yPosition + 1 ||
                        power := power - normalMovePower ||
                        takenRoute := takenRoute <- ( xPosition |-> yPosition + 1 ) ||
                        movements := movements <- MOVE_UP ||
                        report := SUCCESSFULLY_MOVED ||
                        movement := MOVE_UP
                    ELSE
                        // Prevents power going below 0
                        yPosition := yPosition + 1 ||
                        power := 0 ||
                        takenRoute := takenRoute <- ( xPosition |-> yPosition + 1 ) ||
                        movements := movements <- MOVE_UP ||
                        report := SUCCESSFULLY_MOVED ||
                        movement := MOVE_UP
                    END
                ELSE
                    IF
                        ( power - normalMovePower - asteroidHitPowerLoss >= 0 )
                    THEN
                        power := power - normalMovePower - asteroidHitPowerLoss ||
                        noOfCollisions := noOfCollisions + 1 ||
                        report := HIT_ASTEROID ||
                        movement := MOVE_UP
                    ELSE
                        // Prevents power going below 0
                        power := 0 ||
                        noOfCollisions := noOfCollisions + 1 ||
                        report := HIT_ASTEROID ||
                        movement := MOVE_UP
                    END
                END
            ELSE
                report := CANNOT_MOVE_OUT_OF_KNOWN_SPACE
            END
        ELSE
            report := INSUFFICIENT_POWER
        END
    END ;

    /** Moves Down **/
    report , movement <-- MoveDown =
    PRE
        report : REPORT & movement : MOVEMENT & not ( ( xPosition |-> yPosition = starBase ) or ( power < normalMovePower ) )
    THEN
        IF
            ( power >= normalMovePower )
        THEN
            IF
                ( xPosition |-> yPosition - 1 : space )
            THEN
                IF
                    not ( ( xPosition |-> yPosition - 1 : asteroids ) )
                THEN
                    IF
                        ( power - normalMovePower >= 0 )
                    THEN
                        yPosition := yPosition - 1 ||
                        power := power - normalMovePower ||
                        takenRoute := takenRoute <- ( xPosition |-> yPosition - 1 ) ||
                        movements := movements <- MOVE_DOWN ||
                        report := SUCCESSFULLY_MOVED ||
                        movement := MOVE_DOWN
                    ELSE
                        // Prevents power going below 0
                        yPosition := yPosition - 1 ||
                        power := 0 ||
                        takenRoute := takenRoute <- ( xPosition |-> yPosition - 1 ) ||
                        movements := movements <- MOVE_DOWN ||
                        report := SUCCESSFULLY_MOVED ||
                        movement := MOVE_DOWN
                    END
                ELSE
                    IF
                        ( power - normalMovePower - asteroidHitPowerLoss >= 0 )
                    THEN
                        power := power - normalMovePower - asteroidHitPowerLoss ||
                        noOfCollisions := noOfCollisions + 1 ||
                        report := HIT_ASTEROID ||
                        movement := MOVE_DOWN
                    ELSE
                        // Prevents power going below 0
                        power := 0 ||
                        noOfCollisions := noOfCollisions + 1 ||
                        report := HIT_ASTEROID ||
                        movement := MOVE_DOWN
                    END
                END
            ELSE
                report := CANNOT_MOVE_OUT_OF_KNOWN_SPACE
            END
        ELSE
            report := INSUFFICIENT_POWER
        END
    END ;

    /** Moves Forward (Right) **/
    report , movement <-- MoveForward =
    PRE
        report : REPORT & movement : MOVEMENT & not ( ( xPosition |-> yPosition = starBase ) or ( power < normalMovePower ) )
    THEN
        IF
            ( power >= normalMovePower )
        THEN
            IF
                ( xPosition + 1 |-> yPosition : space )
            THEN
                IF
                    not ( ( xPosition + 1 |-> yPosition : asteroids ) )
                THEN
                    IF
                        ( power - normalMovePower >= 0 )
                    THEN
                        xPosition := xPosition + 1 ||
                        power := power - normalMovePower ||
                        takenRoute := takenRoute <- ( xPosition + 1 |-> yPosition ) ||
                        movements := movements <- MOVE_FORWARD ||
                        report := SUCCESSFULLY_MOVED ||
                        movement := MOVE_FORWARD
                    ELSE
                        // Prevents power going below 0
                        xPosition := xPosition + 1 ||
                        power := 0 ||
                        takenRoute := takenRoute <- ( xPosition + 1 |-> yPosition ) ||
                        movements := movements <- MOVE_FORWARD ||
                        report := SUCCESSFULLY_MOVED ||
                        movement := MOVE_FORWARD
                    END
                ELSE
                    IF
                        ( power - normalMovePower - asteroidHitPowerLoss >= 0 )
                    THEN
                        power := power - normalMovePower - asteroidHitPowerLoss ||
                        noOfCollisions := noOfCollisions + 1 ||
                        report := HIT_ASTEROID ||
                        movement := MOVE_FORWARD
                    ELSE
                        // Prevents power going below 0
                        power := 0 ||
                        noOfCollisions := noOfCollisions + 1 ||
                        report := HIT_ASTEROID ||
                        movement := MOVE_FORWARD
                    END
                END
            ELSE
                report := CANNOT_MOVE_OUT_OF_KNOWN_SPACE
            END
        ELSE
            report := INSUFFICIENT_POWER
        END
    END ;

    /** Moves Backward (Left) **/
    report , movement <-- MoveBackward =
    PRE
        report : REPORT & movement : MOVEMENT & not ( ( xPosition |-> yPosition = starBase ) or ( power < normalMovePower ) )
    THEN
        IF
            ( power >= normalMovePower )
        THEN
            IF
                ( xPosition - 1 |-> yPosition : space )
            THEN
                IF
                    not ( ( xPosition - 1 |-> yPosition : asteroids ) )
                THEN
                    IF
                        ( power - normalMovePower >= 0 )
                    THEN
                        xPosition := xPosition - 1 ||
                        power := power - normalMovePower ||
                        takenRoute := takenRoute <- ( xPosition - 1 |-> yPosition ) ||
                        movements := movements <- MOVE_BACKWARD ||
                        report := SUCCESSFULLY_MOVED ||
                        movement := MOVE_BACKWARD
                    ELSE
                        // Prevents power going below 0
                        xPosition := xPosition - 1 ||
                        power := 0 ||
                        takenRoute := takenRoute <- ( xPosition - 1 |-> yPosition ) ||
                        movements := movements <- MOVE_BACKWARD ||
                        report := SUCCESSFULLY_MOVED ||
                        movement := MOVE_BACKWARD
                    END
                ELSE
                    IF
                        ( power - normalMovePower - asteroidHitPowerLoss >= 0 )
                    THEN
                        power := power - normalMovePower - asteroidHitPowerLoss ||
                        noOfCollisions := noOfCollisions + 1 ||
                        report := HIT_ASTEROID ||
                        movement := MOVE_BACKWARD
                    ELSE
                        // Prevents power going below 0
                        power := 0 ||
                        noOfCollisions := noOfCollisions + 1 ||
                        report := HIT_ASTEROID ||
                        movement := MOVE_BACKWARD
                    END
                END
            ELSE
                report := CANNOT_MOVE_OUT_OF_KNOWN_SPACE
            END
        ELSE
            report := INSUFFICIENT_POWER
        END
    END ;

    /** Performs Warp Drive to the given position **/
    report , movement <-- EngageWarpDrive ( newXPosition , newYPosition ) =
    PRE
        report : REPORT & movement : MOVEMENT &
        newXPosition : NAT1 & newYPosition : NAT1 &
        not ( ( xPosition |-> yPosition = starBase ) or ( power < normalMovePower ) )
    THEN
        IF
            ( power >= warpDrivePower )
        THEN
            IF
                ( newXPosition |-> newYPosition : space )
            THEN
                IF
                    ( newXPosition = xPosition & newYPosition = yPosition )
                THEN
                    report := CANNOT_WARP_TO_THE_SAME_POSITION
                ELSE
                    IF
                        ( size ( takenRoute ) = 1 & newXPosition |-> newYPosition = starBase )
                    THEN
                        report := CANNOT_IMMEDIATELY_WARP_INTO_STARBASE
                    ELSE
                        IF
                            not ( ( newXPosition |-> newYPosition : asteroids ) )
                        THEN
                            IF
                                ( power - warpDrivePower >= 0 )
                            THEN
                                power := power - warpDrivePower ||
                                xPosition := newXPosition ||
                                yPosition := newYPosition ||
                                takenRoute := takenRoute <- ( newXPosition |-> newYPosition ) ||
                                movements := movements <- WARP ||
                                report := SUCCESSFULLY_MOVED ||
                                movement := WARP
                            ELSE
                                // Prevents power going below 0
                                power := 0 ||
                                xPosition := newXPosition ||
                                yPosition := newYPosition ||
                                takenRoute := takenRoute <- ( newXPosition |-> newYPosition ) ||
                                movements := movements <- WARP ||
                                report := SUCCESSFULLY_MOVED ||
                                movement := WARP
                            END
                        ELSE
                            report := CANNOT_WARP_INTO_ASTEROID
                        END
                    END
                END
            ELSE
                report := CANNOT_MOVE_OUT_OF_KNOWN_SPACE
            END
        ELSE
            report := INSUFFICIENT_POWER
        END
    END ;

    /** Gives the current status of the space ship **/
    currentLocation , currentPower , asteroidCollisions <-- MissionStatus =
    BEGIN
        currentLocation := xPosition |-> yPosition ||
        currentPower := power ||
        asteroidCollisions := noOfCollisions
    END ;

    /** Gives the route that the space ship has travelled through **/
    route <-- MissionRoute =
    BEGIN
        route := takenRoute
    END ;

    /** Reports whether the space ship is docked at the star base **/
    dockedStatus <-- DockedAtStarbase =
    PRE
        dockedStatus : DOCKED_STATUS
    THEN
        IF
            ( ( xPosition |-> yPosition = starBase ) )
        THEN
            dockedStatus := YES
        ELSE
            dockedStatus := NO
        END
    END ;

    /** Reports the game status **/
    status <-- GameStatus =
    PRE
        status : GAME_STATUS
    THEN
        IF
            ( ( xPosition |-> yPosition = starBase ) )
        THEN
            status := GAME_WON
        ELSE
            IF
                ( power < normalMovePower )
            THEN
                status := GAME_LOST
            ELSE
                status := GAME_NOT_OVER
            END
        END
    END ;

    /** Reports the game status (as a string) **/
    //    status <-- GameStatus =
    //    IF
    //        (isDocked)
    //    THEN
    //        status := "Game WON"
    //    ELSE
    //        IF
    //            (power < normalMovePower)
    //        THEN
    //            status := "Game LOST"
    //        ELSE
    //            status := "Game Not Over"
    //        END
    //    END;

    /** Gives all movements taken by the space ship **/
    allMovements <-- takenMovements =
    BEGIN
        allMovements := movements
    END ;

    /** Resets the game, and starts again from the beginning **/
    resetGame =
    PRE
        ( xPosition |-> yPosition = starBase ) or ( power < normalMovePower )
    THEN
        power := initialPower ||
        noOfCollisions := 0 ||
        xPosition := prj1 ( spaceX , spaceY ) ( homeBase ) ||
        yPosition := prj2 ( spaceX , spaceY ) ( homeBase ) ||
        takenRoute := [ homeBase ] ||
        movements := <>
    END
END
