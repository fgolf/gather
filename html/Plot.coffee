$(document).ready(()->
  data = [
    {x:10, value: 10},
    {x:20, value:30},
    {x:30, value: 20}

  ]

  # Scales
  xScale = new Plottable.Scale.Linear()
  yScale = new Plottable.Scale.Linear()

  # # Plot Components
  title  = new Plottable.Component.TitleLabel("Histogram")
  yLabel = new Plottable.Component.Label("Y", "left")
  xAxis  = new Plottable.Axis.Numeric(xScale, "bottom")
  yAxis  = new Plottable.Axis.Numeric(yScale, "left")
  plot   = new Plottable.Plot.Bar(xScale, yScale, true)
    .addDataset(data)
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

)