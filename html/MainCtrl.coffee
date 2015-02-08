angular.module("gatherApp")
.controller("MainCtrl", ["$scope","DataService", ($scope, DataService) ->
    console.log "MainCtrl!"
    DataService.getMain((data)->$scope.data = data)
])