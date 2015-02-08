angular.module("gatherApp")
.controller("MainCtrl", ["$scope","DataService", ($scope, DataService) ->
    console.log "MainCtrl!" 
    $scope.bucketSize = 1000
    $scope.drawBuckets = []
    DataService.getMain((data)->
        $scope.data = data
        $scope.updateBuckets()
    )
    $scope.$watch('bucketSize',()->
        if $scope.bucketSize? and $scope.bucketSize > 0
            $scope.updateBuckets()
    )

    $scope.updateBuckets = () ->
        buckets = {}
        for k,v of $scope.data
            x = k - (k % $scope.bucketSize)
            val = buckets[x]
            if not val?
                val = 0
            val+=v.value
            buckets[x]=val

        newBuckets = []
        for k,v of buckets
            newBuckets.push({x: k, value: v})
        $scope.drawBuckets = _.sortBy(newBuckets,(d)->d.x)
        $scope.draw()


    plot = null
    $scope.initDraw = () ->
        # Scales
        xScale = new Plottable.Scale.Linear()
        yScale = new Plottable.Scale.Linear()

        # # Plot Components
        title  = new Plottable.Component.TitleLabel("Histogram")
        yLabel = new Plottable.Component.Label("Y", "left")
        xAxis  = new Plottable.Axis.Numeric(xScale, "bottom")
        yAxis  = new Plottable.Axis.Numeric(yScale, "left")
        plot   = new Plottable.Plot.Bar(xScale, yScale, true)
            .addDataset("data",$scope.drawBuckets)
            .project("x", "x", xScale)
            .project("y", "value", yScale)
            .animate(true)

        selector = new Plottable.Interaction.Click()
          .callback((p) -> 
              bar = plot.getBars(p.x, p.y)
              if not bar or bar.length == 0 or bar[0].length == 0
                  return

              console.log "click bar",bar[0][0].__data__
          )

        plot.registerInteraction(selector)

        # Layout and render
        chart = new Plottable.Component.Table([
            [null,    null, title],
            [yLabel, yAxis, plot],
            [null,    null, xAxis]
        ])
        .renderTo("#testplot")

    $scope.draw = () ->
        plot.addDataset("data",$scope.drawBuckets)

    $scope.initDraw()
    $scope.draw()
        


])