local ghost = {}
ghost.animation = {}

ghost.speed = 200 -- multiplied speed by 10, to accommodate current implementation of local monster wandering
ghost.nemesis = {"witch"}
ghost.maxAgitation = 12
ghost.animation.idleDuration = 8
ghost.animation.walkingDuration = 15

return ghost