NB. gdiplus

coclass 'jgdiplus'

GdipBitmapLockBits=: 'gdiplus GdipBitmapLockBits i x *i i i *x'&cd
GdipBitmapSetPixel=: 'gdiplus GdipBitmapSetPixel > i x i i i'&cd
GdipBitmapUnLockBits=: 'gdiplus GdipBitmapUnlockBits > i x *x'&cd
GdipCreateBitmapFromFile=: 'gdiplus GdipCreateBitmapFromFile > i *w *x'&cd
GdipCreateBitmapFromGdiDib=: 'gdiplus GdipCreateBitmapFromGdiDib > i x x *x'&cd
GdipCreateBitmapFromScan0=: 'gdiplus GdipCreateBitmapFromScan0 > i i i i i *i *x'&cd
GdipCreateBitmapFromScan0c=: 'gdiplus GdipCreateBitmapFromScan0 > i i i i i *c *x'&cd
GdipCreateBitmapFromStream=: 'gdiplus GdipCreateBitmapFromStream > i x *x'&cd
GdipCreateFont=: 'gdiplus GdipCreateFont > i x f i i *x'&cd
GdipCreateFontFamilyFromName=: 'gdiplus GdipCreateFontFamilyFromName > i *w x *x'&cd
GdipCreatePen1=: 'gdiplus GdipCreatePen1 > i x f i *x'&cd
GdipCreateSolidFill=: 'gdiplus GdipCreateSolidFill > i x *x'&cd
GdipDeleteBrush=: 'gdiplus GdipDeleteBrush > i x'&cd
GdipDeleteFont=: 'gdiplus GdipDeleteFont > i x'&cd
GdipDeleteFontFamily=: 'gdiplus GdipDeleteFontFamily > i x'&cd
GdipDeleteGraphics=: 'gdiplus GdipDeleteGraphics > i x'&cd
GdipDeletePen=: 'gdiplus GdipDeletePen > i x'&cd
GdipDisposeImage=: 'gdiplus GdipDisposeImage > i x'&cd
GdipDrawArc=: 'gdiplus GdipDrawArcI > i x x i i i i f f'&cd
GdipDrawClosedCurve=: 'gdiplus GdipDrawClosedCurve2I > i x x *i i f'&cd
GdipDrawCurve=: 'gdiplus GdipDrawCurve2I > i x x *i i f'&cd
GdipDrawEllipse=: 'gdiplus GdipDrawEllipseI > i x x i i i i'&cd
GdipDrawImageI=: 'gdiplus GdipDrawImageI > i x x i i'&cd
GdipDrawLines=: 'gdiplus GdipDrawLinesI > i x x *i i'&cd
GdipDrawPie=: 'gdiplus GdipDrawPieI > i x x i i i i f f'&cd
GdipDrawPolygon=: 'gdiplus GdipDrawPolygonI > i x x *i i'&cd
GdipDrawRectangle=: 'gdiplus GdipDrawRectangleI > i x x i i i i'&cd
GdipDrawString=: 'gdiplus GdipDrawString > i x *w i x *f x x'&cd
GdipFillClosedCurve=: 'gdiplus GdipFillClosedCurve2I > i x x *i i f i'&cd
GdipFillEllipse=: 'gdiplus GdipFillEllipseI > i x x i i i i'&cd
GdipFillPie=: 'gdiplus GdipFillPieI > i x x i i i i f f'&cd
GdipFillPolygon=: 'gdiplus GdipFillPolygonI > i x x *i i i'&cd
GdipFillRectangle=: 'gdiplus GdipFillRectangleI > i x x i i i i'&cd
GdipGetCellAscent=: 'gdiplus GdipGetCellAscent > i x i *s'&cd
GdipGetCellDescent=: 'gdiplus GdipGetCellDescent > i x i *s'&cd
GdipGetEmHeight=: 'gdiplus GdipGetEmHeight > i x i *s'&cd
GdipGetFamily=: 'gdiplus GdipGetFamily > i x *x'&cd
GdipGetFontSize=: 'gdiplus GdipGetFontSize > i x *f'&cd
GdipGetFontStyle=: 'gdiplus GdipGetFontStyle > i x *i'&cd
GdipGetImageGraphicsContext=: 'gdiplus GdipGetImageGraphicsContext > i x *x'&cd
GdipGetImageHeight=: 'gdiplus GdipGetImageHeight i x *i'&cd
GdipGetImageWidth=: 'gdiplus GdipGetImageWidth i x *i'&cd
GdipGetLineSpacing=: 'gdiplus GdipGetLineSpacing > i x i *s'&cd
GdipMeasureString=: 'gdiplus GdipMeasureString > i x *w i x *f x *f *i *i'&cd
GdipResetClip=: 'gdiplus GdipResetClip > i x'&cd
GdipResetWorldTransform=: 'gdiplus GdipResetWorldTransform > i x'&cd
GdipRestoreGraphics=: 'gdiplus GdipRestoreGraphics > i x x'&cd
GdipRotateWorldTransform=: 'gdiplus GdipRotateWorldTransform > i x f i'&cd
GdipSaveGraphics=: 'gdiplus GdipSaveGraphics > i x *x'&cd
GdipSaveImageToStream=: 'gdiplus GdipSaveImageToStream > i x x *c *c'&cd
GdipSetClipRect=: 'gdiplus GdipSetClipRectI > i x i i i i i'&cd
GdipSetCompositingQuality=: 'gdiplus GdipSetCompositingQuality > i x i'&cd
GdipSetInterpolationMode=: 'gdiplus GdipSetInterpolationMode > i x i'&cd
GdipSetPenDashStyle=: 'gdiplus GdipSetPenDashStyle > i x i'&cd
GdipSetPenWidth=: 'gdiplus GdipSetPenWidth > i x f'&cd
GdipSetSmoothingMode=: 'gdiplus GdipSetSmoothingMode > i x i'&cd
GdipTranslateWorldTransform=: 'gdiplus GdipTranslateWorldTransform > i x f f i'&cd
GdiplusShutdown=: 'gdiplus GdiplusShutdown > n x'&cd
GdiplusStartup=: 'gdiplus GdiplusStartup > i *x *x x'&cd
NB. =========================================================

PixelFormat32bppARGB=: 16b26200a
ImageLockModeRead=: 1
GdiplusStartupInput=: 1 0 0 0
MatrixOrderPrepend=: 0
MatrixOrderAppend=: 1

SmoothingModeHighSpeed=: 1
CompositingQualityHighSpeed=: 1
InterpolationModeLowQuality=: 1

SmoothingModeHighQuality=: 2
CompositingQualityHighQuality=: 2
InterpolationModeHighQuality=: 2

NB.*Unit n World Display Pixel Point Inch Document Millimeter
'World Display Pixel Point Inch Document Millimeter'=: i.7

NB.*FillMode n Alternate Winding
'Alternate Winding'=: i.2
