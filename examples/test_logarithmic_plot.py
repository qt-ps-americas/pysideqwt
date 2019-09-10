from PySide2.QtCore import *
from PySide2.QtGui import *
from PySide2.QtWidgets import *
from pysideqwt.pysideqwt import *
import numpy as np

app = QApplication([])

plot = QwtPlot()
plot.setTitle("TEST LOGARITHMIC PLOT")
plot.setCanvasBackground(Qt.white)

plot.enableAxis(QwtPlot.yRight)
plot.setAxisTitle(QwtPlot.xBottom, "X Axis")
plot.setAxisTitle(QwtPlot.yLeft, "Y Axis")
plot.setAxisTitle(QwtPlot.yRight, "Y2 Axis")
plot.insertLegend(QwtLegend(), QwtPlot.BottomLegend)

plot.setAxisScaleEngine(QwtPlot.xBottom, QwtLogScaleEngine())


curve = QwtPlotCurve("Curve")
curve.setPen(QColor("#00c0c0"), 1)
curve.setRenderHint(QwtPlotCurve.RenderAntialiased, True)
pointCount = 100
maxValue = 10000000
yData = np.arange(pointCount)
xData = np.random.randint(maxValue, size=pointCount)
curve.setSamples(xData, yData)
curve.attachToPlot(plot)

curveSymbol = QwtSymbol(QwtSymbol.Star2,
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

curve2 = QwtPlotCurve("Curve2")
curve2.setYAxis(QwtPlot.yRight)
curve2.setPen(QColor("#c000c0"), 1)
curve2.setRenderHint(QwtPlotCurve.RenderAntialiased,True)
pointCount2=50
yData2=np.arange(pointCount2)
xData2=np.random.randint(maxValue,size=pointCount2)
curve2.setSamples(xData2,yData2)
curve2.attachToPlot(plot)

curveSymbol2 = QwtSymbol(QwtSymbol.Triangle,
    QBrush(QColor("#c000c0")),
    QPen(Qt.black, 0),
    QSize(6, 6))
curve2.setSymbol(curveSymbol2)

plot.resize(640, 480)
plot.show()

app.exec_()

del app