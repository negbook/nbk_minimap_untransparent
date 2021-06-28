this = {}
this.scriptName = "scaleforms"

if GetCurrentResourceName() ~= this.scriptName then 
Scaleforms = {}
end 

Scaleforms.CallScaleformMovie = function(scaleformName,cb) 
    exports.scaleforms:CallScaleformMovie(scaleformName,cb) 
end
Scaleforms.RequestScaleformCallbackString = function(scaleformName,SfunctionName,...) 
    exports.scaleforms:RequestScaleformCallbackString(scaleformName,SfunctionName,...) 
end
Scaleforms.RequestScaleformCallbackInt = function(scaleformName,SfunctionName,...) 
    exports.scaleforms:RequestScaleformCallbackInt(scaleformName,SfunctionName,...) 
end
Scaleforms.RequestScaleformCallbackBool = function(scaleformName,SfunctionName,...) 
    exports.scaleforms:RequestScaleformCallbackBool(scaleformName,SfunctionName,...) 
end
Scaleforms.DrawScaleformMovie = function(scaleformName,...)
    exports.scaleforms:DrawScaleformMovie(scaleformName,...)
end
Scaleforms.DrawScaleformMoviePosition = function(scaleformName,...)
    exports.scaleforms:DrawScaleformMoviePosition(scaleformName,...)
end
Scaleforms.DrawScaleformMoviePosition2 = function(scaleformName,...)
    exports.scaleforms:DrawScaleformMoviePosition2(scaleformName,...)
end
Scaleforms.EndScaleformMovie = function(scaleformName)
    exports.scaleforms:EndScaleformMovie(scaleformName)
end
Scaleforms.KillScaleformMovie = function(scaleformName)
    exports.scaleforms:KillScaleformMovie(scaleformName)
end
Scaleforms.DrawScaleformMovieDuration = function(scaleformName,duration,...)
    exports.scaleforms:DrawScaleformMovieDuration(scaleformName,duration,...)
end
Scaleforms.DrawScaleformMoviePositionDuration = function(scaleformName,duration,...)
    exports.scaleforms:DrawScaleformMoviePositionDuration(scaleformName,duration,...)
end
Scaleforms.DrawScaleformMoviePosition2Duration = function(scaleformName,duration,...)
    exports.scaleforms:DrawScaleformMoviePosition2Duration(scaleformName,duration,...)
end

