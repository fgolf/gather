// Generated by CoffeeScript 1.8.0
angular.module("gatherApp", []);

angular.module("gatherApp").service("DataService", [
  "$http", function($http) {
    this.getMain = function(callback) {
      return $http({
        url: "/api/main",
        method: "GET"
      }).success(function(config) {
        return callback(config);
      });
    };
    return this;
  }
]);

angular.module("gatherApp").controller("MainCtrl", [
  "$scope", "DataService", function($scope, DataService) {
    console.log("MainCtrl!");
    return DataService.getMain(function(data) {
      return $scope.data = data;
    });
  }
]);
