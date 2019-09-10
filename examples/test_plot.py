from PySide2.QtCore import *
from PySide2.QtGui import *
from PySide2.QtWidgets import *
from pysideqwt.pysideqwt import *
import numpy as np

app = QApplication([])

plot = QwtPlot()
plot.setTitle("TEST PLOT")
plot.setCanvasBackground(Qt.white)

plot.enableAxis(QwtPlot.yRight)
plot.setAxisTitle(QwtPlot.xBottom, "X Axis")
plot.setAxisTitle(QwtPlot.yLeft, "Y Axis")
plot.setAxisTitle(QwtPlot.yRight, "Y2 Axis")
plot.insertLegend(QwtLegend(), QwtPlot.BottomLegend)

curve = QwtPlotCurve("Curve")
curve.setPen(QColor("#0000c0"), 1)
curve.setRenderHint(QwtPlotCurve.RenderAntialiased, True)
pointCount = 100
maxValue = 1000
xData = np.arange(pointCount)
yData = np.random.randint(maxValue, size=pointCount)
curve.setSamples(xData, yData)
curve.attachToPlot(plot)

curveSymbol = QwtSymbol(QwtSymbol.Ellipse,
    QBrush(QColor("#0000c0")),
    QPen(Qt.black, 0),
    QSize(6, 6))
curve.setSymbol(curveSymbol)

pickerPen = QPen()
pickerPen.setColor(QColor(Qt.red))
pickerPen.setWidth(1)

picker = QwtPlotPicker(QwtPlot.xBottom, QwtPlot.yLeft,
    QwtPlotPicker.CrossRubberBand, QwtPicker.ActiveOnly,
    plot.canvas())
picker.setStateMachine(QwtPickerDragPointMachine())
picker.setRubberBandPen(pickerPen)
picker.setRubberBand(QwtPicker.CrossRubberBand)
picker.setTrackerPen(pickerPen)

markerSymbol = QwtSymbol(QwtSymbol.XCross,
    QBrush(QColor("#ff0000")),
    QPen(QColor("#ff0000"), 2),
    QSize(12, 12))

plot.resize(640, 480)
plot.show()

app.exec_()

del app
