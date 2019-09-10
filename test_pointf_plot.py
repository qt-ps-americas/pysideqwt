from PySide2.QtCore import *
from PySide2.QtGui import *
from PySide2.QtWidgets import *
from pysideqwt.pysideqwt import *
import numpy as np

app = QApplication([])

plot = QwtPlot()
plot.setTitle("TEST POINTF PLOT")

plot.setAxisTitle(QwtPlot.xBottom, "X Axis")
plot.setAxisTitle(QwtPlot.yLeft, "Y Axis")
plot.insertLegend(QwtLegend(), QwtPlot.BottomLegend)
plot.plotLayout().setCanvasMargin(10,QwtPlot.yRight)

curve = QwtPlotCurve("Curve")
curve.setPen(QColor("#0000c0"), 1)
curve.setRenderHint(QwtPlotCurve.RenderAntialiased, True)
pointCount = 100
maxValue = 1000
xData = np.arange(pointCount)
yData = np.random.randint(maxValue, size=pointCount)
pts=[]
for n in range(pointCount):
	x=xData[n]
	y=yData[n]
	point=QPointF(x,y)
	pts.append(point)
curve.setSamples(pts)
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
