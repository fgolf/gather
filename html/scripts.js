

// html/App.coffee
// Generated by CoffeeScript 1.8.0
angular.module("gatherApp", []);

// html/DataService.coffee
// Generated by CoffeeScript 1.8.0
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

// html/MainCtrl.coffee
// Generated by CoffeeScript 1.8.0
angular.module("gatherApp").controller("MainCtrl", [
  "$scope", "DataService", function($scope, DataService) {
    var plot;
    console.log("MainCtrl!");
    $scope.bucketSize = 1000;
    $scope.drawBuckets = [];
    DataService.getMain(function(data) {
      $scope.data = data;
      return $scope.updateBuckets();
    });
    $scope.$watch('bucketSize', function() {
      if (($scope.bucketSize != null) && $scope.bucketSize > 0) {
        return $scope.updateBuckets();
      }
    });
    $scope.updateBuckets = function() {
      var buckets, k, newBuckets, v, val, x, _ref;
      buckets = {};
      _ref = $scope.data;
      for (k in _ref) {
        v = _ref[k];
        x = k - (k % $scope.bucketSize);
        val = buckets[x];
        if (val == null) {
          val = 0;
        }
        val += v.value;
        buckets[x] = val;
      }
      newBuckets = [];
      for (k in buckets) {
        v = buckets[k];
        newBuckets.push({
          x: k,
          value: v
        });
      }
      $scope.drawBuckets = _.sortBy(newBuckets, function(d) {
        return d.x;
      });
      return $scope.draw();
    };
    plot = null;
    $scope.initDraw = function() {
      var chart, selector, title, xAxis, xScale, yAxis, yLabel, yScale;
      xScale = new Plottable.Scale.Linear();
      yScale = new Plottable.Scale.Linear();
      title = new Plottable.Component.TitleLabel("Histogram");
      yLabel = new Plottable.Component.Label("Y", "left");
      xAxis = new Plottable.Axis.Numeric(xScale, "bottom");
      yAxis = new Plottable.Axis.Numeric(yScale, "left");
      plot = new Plottable.Plot.Bar(xScale, yScale, true).addDataset("data", $scope.drawBuckets).project("x", "x", xScale).project("y", "value", yScale).animate(true);
      selector = new Plottable.Interaction.Click().callback(function(p) {
        var bar;
        bar = plot.getBars(p.x, p.y);
        if (!bar || bar.length === 0 || bar[0].length === 0) {
          return;
        }
        return console.log("click bar", bar[0][0].__data__);
      });
      plot.registerInteraction(selector);
      return chart = new Plottable.Component.Table([[null, null, title], [yLabel, yAxis, plot], [null, null, xAxis]]).renderTo("#testplot");
    };
    $scope.draw = function() {
      return plot.addDataset("data", $scope.drawBuckets);
    };
    $scope.initDraw();
    return $scope.draw();
  }
]);

// html/Plot.coffee
// Generated by CoffeeScript 1.8.0
$(document).ready(function() {
  var data;
  return data = [
    {
      x: 10,
      value: 10
    }, {
      x: 20,
      value: 30
    }, {
      x: 30,
      value: 20
    }
  ];
});
