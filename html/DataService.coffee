angular.module("gatherApp")
.service("DataService", ["$http", ($http) ->
  @getMain = (callback) ->
    $http({
      url: "/api/main"
      method: "GET"
    })
    .success (config) ->
      callback(config)

  return @
])
